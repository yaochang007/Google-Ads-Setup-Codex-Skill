# Google-Ads-Setup-Codex-Skill

Google-Ads-Setup-Codex-Skill is a local Codex browser-use skill library for safely guiding
Google Ads audits, planning, draft setup, and launch review workflows.

The project is not an autonomous Google Ads operator. It is a set of Markdown
skills, references, templates, and human checklists that keep a browser-use
agent inside explicit safety rails. No skill should log in, change billing,
start spend, publish campaigns, or change account access without the required
human approval gate.

## Structure

- `AGENTS.md`: AI agent working instructions.
- `docs/architecture.md`: system shape, boundaries, and data flow.
- `docs/decisions.md`: decision log.
- `docs/browser-use-safety.md`: global browser-use safety rules.
- `docs/google-ads-workflows.md`: workflow catalog and testing model.
- `docs/approval-gates.md`: human approval gate definitions.
- `skills/`: Codex browser-use skills for Google Ads workflows.
- `checklists/`: human-facing review and safety checklists.
- `tasks/todo.md`: active project task list.
- `prompts/initial-brief.md`: project kickoff prompt.
- `scripts/check.sh`: project validation entrypoint.
- `scripts/dev.sh`: local development entrypoint.
- `scripts/session-start.sh`: session startup checklist.
- `scripts/session-close.sh`: session closeout checklist.

## V1 Skills

- `google-ads-account-audit`: strictly read-only account overview, billing
  status, campaigns, campaign statuses, conversion actions, linked accounts,
  account access/users, and recommendations audit.
- `google-ads-conversion-tracking-audit`: strictly read-only conversion goals,
  conversion actions, GA4/GTM/linking readiness, tag readiness, and recent
  conversion activity audit.
- `google-ads-reporting-audit`: strictly read-only reporting review for
  campaigns, conversions, spend, CPA/ROAS, search terms, assets,
  recommendations, and account health.
- `google-ads-search-campaign-planning`: planning-only Search campaign plan for
  structure, keywords, negative keywords, ads, budget, bidding, locations,
  languages, landing pages, conversion goals, and gates.
- `google-ads-search-campaign-draft-setup`: browser-use Search draft setup
  guidance that stops before final save, publish, enable, or launch.
- `google-ads-performance-max-planning`: planning-only Performance Max plan for
  goals, conversion readiness, budget, asset groups, audience signals, final URL
  settings, brand exclusions, Merchant Center readiness, and gates.
- `google-ads-performance-max-draft-setup`: browser-use Performance Max draft
  setup guidance that stops before final save, publish, enable, or launch.
- `google-ads-negative-keywords`: read-only search term review plus approved
  negative keyword proposal/addition workflow.
- `google-ads-budget-and-bidding-review`: read-only/planning review of budgets,
  bidding strategies, CPA/ROAS, constraints, and proposed changes.
- `google-ads-final-launch-review`: final pre-launch QA and approval review;
  publish/enable/launch requires exact campaign and budget confirmation.

## Commands

```sh
./scripts/check.sh --dry-run
./scripts/check.sh --apply
./scripts/dev.sh --dry-run
./scripts/session-start.sh --dry-run
./scripts/session-close.sh --dry-run
```

All scripts accept:

- `--dry-run`: print what would happen without changing project state.
- `--apply`: perform the script action.
- `--help`: show usage.

`scripts/check.sh --apply` verifies required project files, executable scripts,
skill frontmatter, required skill sections, safety references, output templates,
read-only declarations, and approval language around publish/enable/launch
actions.

## Safety Model

- Read-only audit skills must remain strictly read-only.
- Planning skills do not run browser automation.
- Draft setup skills may describe browser-use steps, but must stop before final
  save, publish, enable, launch, or spend-starting actions.
- Budget, bidding, targeting expansion, negative keyword additions, and launch
  actions require explicit human approval gates.
- Recommendations are read, not applied automatically.

## License

Licensed under the Apache License, Version 2.0.

Copyright 2026 Vue Tech Pte Ltd, Singapore.

Forks and derivative works must preserve the Apache 2.0 license and retain the
original copyright and attribution notices required by the license.

## Session Workflow

1. Start with `./scripts/session-start.sh --dry-run`.
2. Read the relevant skill and checklist.
3. Edit only skills, docs, templates, and checklists unless a task explicitly
   asks for code.
4. Run `bash scripts/check.sh --apply` before handoff.
5. Run `./scripts/session-close.sh --dry-run`.
6. Report changes, checks, commits, and remaining risks.
