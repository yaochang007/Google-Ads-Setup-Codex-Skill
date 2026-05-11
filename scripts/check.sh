#!/usr/bin/env sh

set -eu

MODE="apply"

# Print help text for people and agents before they run the script.
usage() {
  cat <<'EOF'
Usage: ./scripts/check.sh [--dry-run|--apply|--help]

Runs project checks for the Google Ads Setup skill library.

Default: --apply
EOF
}

# Parse supported mode flags. Keep this strict so typos fail loudly.
while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run) MODE="dry-run" ;;
    --apply) MODE="apply" ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'ERROR: unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

REQUIRED_FILES="
AGENTS.md
README.md
docs/architecture.md
docs/decisions.md
tasks/todo.md
prompts/initial-brief.md
scripts/check.sh
scripts/dev.sh
scripts/session-start.sh
scripts/session-close.sh
.gitignore
"

READ_ONLY_SKILLS="
google-ads-account-audit
google-ads-conversion-tracking-audit
google-ads-reporting-audit
"

# In dry-run mode, describe the checks without reading or changing state.
if [ "$MODE" = "dry-run" ]; then
  for path in $REQUIRED_FILES; do
    printf '[dry-run] check %s exists\n' "$path"
  done
  printf '[dry-run] check shell scripts are executable\n'
  printf '[dry-run] lint every skills/*/SKILL.md file\n'
  printf '[dry-run] check skill frontmatter, required sections, approval gates, and safety language\n'
  printf '[dry-run] check read-only skills explicitly say read-only\n'
  printf '[dry-run] check skills do not allow publish/enable/launch without approval\n'
  exit 0
fi

# Verify that every required template file is present.
for path in $REQUIRED_FILES; do
  if [ ! -e "$path" ]; then
    printf 'ERROR: missing required file: %s\n' "$path" >&2
    exit 1
  fi
done

# Verify script executability so project commands can be run consistently.
for path in scripts/check.sh scripts/dev.sh scripts/session-start.sh scripts/session-close.sh; do
  if [ ! -x "$path" ]; then
    printf 'ERROR: script is not executable: %s\n' "$path" >&2
    exit 1
  fi
done

if [ ! -d skills ]; then
  printf 'ERROR: missing skills directory\n' >&2
  exit 1
fi

skill_count=0
for skill_dir in skills/*; do
  [ -d "$skill_dir" ] || continue
  skill_count=$((skill_count + 1))
  skill_name=$(basename "$skill_dir")
  skill_file="$skill_dir/SKILL.md"

  if [ ! -f "$skill_file" ]; then
    printf 'ERROR: missing SKILL.md in %s\n' "$skill_dir" >&2
    exit 1
  fi

  first_line=$(sed -n '1p' "$skill_file")
  if [ "$first_line" != "---" ]; then
    printf 'ERROR: %s must start with YAML frontmatter\n' "$skill_file" >&2
    exit 1
  fi

  if ! grep -Eq '^name: .+' "$skill_file"; then
    printf 'ERROR: %s missing name frontmatter\n' "$skill_file" >&2
    exit 1
  fi

  if ! grep -Eq '^description: .+' "$skill_file"; then
    printf 'ERROR: %s missing description frontmatter\n' "$skill_file" >&2
    exit 1
  fi

  declared_name=$(grep -E '^name: ' "$skill_file" | sed 's/^name: //')
  if [ "$declared_name" != "$skill_name" ]; then
    printf 'ERROR: %s frontmatter name does not match folder name\n' "$skill_file" >&2
    exit 1
  fi

  for section in \
    "## When to use" \
    "## Inputs required" \
    "## Preflight checks" \
    "## Browser-use workflow" \
    "## Human approval gates" \
    "## Never do without approval" \
    "## Stop conditions" \
    "## Output format"
  do
    if ! grep -Fq "$section" "$skill_file"; then
      printf 'ERROR: %s missing required section: %s\n' "$skill_file" "$section" >&2
      exit 1
    fi
  done

  if ! grep -Fq "../../docs/browser-use-safety.md" "$skill_file"; then
    printf 'ERROR: %s must reference docs/browser-use-safety.md\n' "$skill_file" >&2
    exit 1
  fi

  if ! grep -Fq "## Human approval gates" "$skill_file"; then
    printf 'ERROR: %s missing human approval gates\n' "$skill_file" >&2
    exit 1
  fi

  if grep -Eiq '(publish|enable|launch)' "$skill_file" && ! grep -Eiq 'approval|approve|authorization' "$skill_file"; then
    printf 'ERROR: %s mentions publish/enable/launch without approval language\n' "$skill_file" >&2
    exit 1
  fi

  if grep -Eiq 'apply Google recommendations automatically|apply recommendations automatically' "$skill_file"; then
    :
  elif grep -Eiq 'recommendations' "$skill_file" && ! grep -Eiq 'do not apply|never apply|without applying|not applied' "$skill_file"; then
    printf 'ERROR: %s mentions recommendations without anti-apply safety language\n' "$skill_file" >&2
    exit 1
  fi

  if [ ! -f "$skill_dir/references/preflight.md" ]; then
    printf 'ERROR: %s missing references/preflight.md\n' "$skill_dir" >&2
    exit 1
  fi

  if ! find "$skill_dir/references" -type f \( -name '*template.md' -o -name 'output-template.md' \) | grep -q .; then
    printf 'ERROR: %s missing an output/template reference file\n' "$skill_dir" >&2
    exit 1
  fi

  for read_only_skill in $READ_ONLY_SKILLS; do
    if [ "$skill_name" = "$read_only_skill" ] && ! grep -Eiq 'strictly read-only|read-only' "$skill_file"; then
      printf 'ERROR: %s must explicitly say it is read-only\n' "$skill_file" >&2
      exit 1
    fi
  done
done

if [ "$skill_count" -eq 0 ]; then
  printf 'ERROR: no skill folders found under skills/\n' >&2
  exit 1
fi

printf 'Project checks passed. Linted %s skills.\n' "$skill_count"
