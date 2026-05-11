# Decisions

Record important project decisions here. Keep entries short, dated, and reversible when possible.

## Template

```md
## YYYY-MM-DD: Decision Title

Status: proposed | accepted | superseded

Context:

Decision:

Consequences:
```

## Log

## 2026-05-02: Keep Template Language-Neutral

Status: superseded by 2026-05-11

Context:
This repository was a reusable starting point for projects that may use
different languages, frameworks, and deployment models.

Decision:
Keep scripts, documentation, and prompts stack-agnostic until a project chooses
its technology stack.

Consequences:
The initial commands validate structure and print guidance rather than invoking
language-specific tooling.

## 2026-05-02: Require Script Modes

Status: accepted

Context:
Reusable automation should be safe to inspect before it changes project state.

Decision:
Every shell script supports `--dry-run`, `--apply`, and `--help`.

Consequences:
Future project-specific scripts must preserve those options when replacing
placeholder behavior.

## 2026-05-11: Project Purpose Is Google-Ads-Setup-Codex-Skill via Skills + Browser-use

Status: accepted

Context:
The template has been adopted for a real project: a reusable skill library that
guides a browser-use agent through Google Ads campaign setup.

Decision:
Project purpose is locked. Skills live under `skills/<skill-name>/`, are
Markdown-with-frontmatter, and target the Google Ads web UI (not the Ads API).

Consequences:
Subsequent docs may reference Google Ads concepts directly. The template-level
neutrality decision is superseded.

## 2026-05-11: Use Google Ads Web UI, Not the Google Ads API

Status: accepted

Context:
The Google Ads API would allow direct programmatic control. However it requires
developer-token approval, credential management, and removes the human from the
loop. The point of this project is *safe* setup with human approval gates, and
the operator is already trained on the web UI.

Decision:
All workflows drive the Google Ads web UI via a browser-use agent.

Consequences:
- No developer token or API client to manage.
- Skills must be resilient to UI changes (use semantic selectors, screenshots).
- The Ads API may be revisited later for *read-only* reporting.

## 2026-05-11: Read-Only Audit Before Any Write

Status: accepted

Context:
Money-impacting changes need context. Acting blind on an unfamiliar account
risks breaking active campaigns.

Decision:
Every write-capable skill must run, or depend on, a read-only audit pass first
and write an audit artifact the operator can review.

Consequences:
- Adds time to each workflow.
- First skill we build is the audit skill; everything else builds on it.

## 2026-05-11: Draft / Publish Separation

Status: accepted

Context:
Google Ads campaigns can be created in *paused* state and only spend money
once enabled. We exploit this for safety.

Decision:
Draft setup skills stop before final save, publish, enable, or launch. Final
launch review is the separate, explicitly-gated workflow for any spend-starting
action.

Consequences:
- The agent cannot, by construction, start a campaign spending money in a single
  shot — it has to come back through a separate gate.
- "Draft" artifacts are reviewable before going live.

## 2026-05-11: Hard Denylist for Destructive Actions

Status: accepted

Context:
Some actions are too dangerous to do via an agent without specific human
authorization: changing billing, deleting campaigns, changing account access,
removing conversion goals.

Decision:
The browser-use safety rules and each skill enumerate actions the agent must
refuse even if asked. The operator can override only via an explicit override
phrase that names the denylisted action.

Consequences:
- The agent will sometimes refuse and ask the human to act manually. Accepted.

## 2026-05-11: Skills Format

Status: accepted

Context:
The project sits inside the Codex / Claude Code skill ecosystem. Existing
superpowers skills use Markdown with YAML frontmatter (`name`, `description`).

Decision:
Each skill is a folder under `skills/<skill-name>/` containing `SKILL.md`
(YAML frontmatter + agent instructions), `checklist.md` (human-facing),
`inputs.schema.json` (required inputs), and optional `references/`.

Consequences:
- Skills are easy to lint and copy between projects.
- The library can later be packaged as a Codex plugin if desired.

## 2026-05-11: Artifacts and State Are Gitignored

Status: accepted

Context:
Run artifacts (audit reports, draft plans) may contain account-identifying or
spend-sensitive data.

Decision:
`artifacts/` and `state/` are gitignored. The skills write to them, the human
reviews locally.

Consequences:
- No accidental commit of campaign data.
- Sharing a run requires an explicit redaction step.

## 2026-05-11: V1 Skill Library Scope

Status: accepted

Context:
The project needs a complete first version of the skill library before any real
browser-use execution or Google Ads account access.

Decision:
V1 contains ten skills: account audit, conversion tracking audit, reporting
audit, Search planning, Search draft setup, Performance Max planning,
Performance Max draft setup, negative keywords, budget and bidding review, and
final launch review.

Consequences:
- Demand Gen, Display, Video, API reporting, and harness simulation remain
  future work.
- Draft setup skills describe browser-use steps but stop before final save,
  publish, enable, or launch.
- Final launch review is the only v1 skill that may describe launch execution,
  and only after Gate C plus exact Gate D campaign/budget authorization.

## 2026-05-11: Static Skill Lint Is Required for V1

Status: accepted

Context:
The repository is mostly Markdown. Safety regressions are more likely to happen
in skill wording than code.

Decision:
`scripts/check.sh --apply` lints skill folders for frontmatter, required
sections, browser-use safety references, approval-gate language, read-only
declarations, and output templates.

Consequences:
- The project can catch missing safety sections without browser automation.
- The linter is intentionally conservative and can be expanded as the harness
  grows.
