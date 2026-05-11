# Todo

Project: Google Ads Setup — Codex skill library + browser-use workflow.

See:
- `docs/architecture.md`
- `docs/decisions.md`
- `docs/browser-use-safety.md`
- `docs/google-ads-workflows.md`
- `docs/approval-gates.md`

## V1 Skill Library

- [x] `google-ads-account-audit`
- [x] `google-ads-conversion-tracking-audit`
- [x] `google-ads-reporting-audit`
- [x] `google-ads-search-campaign-planning`
- [x] `google-ads-search-campaign-draft-setup`
- [x] `google-ads-performance-max-planning`
- [x] `google-ads-performance-max-draft-setup`
- [x] `google-ads-negative-keywords`
- [x] `google-ads-budget-and-bidding-review`
- [x] `google-ads-final-launch-review`

## V1 Validation

- [x] Create a human checklist for each v1 skill.
- [x] Add `references/preflight.md` for each v1 skill.
- [x] Add an output template reference for each v1 skill.
- [x] Update `scripts/check.sh` from template checks to skill-library lint.
- [x] Update README and workflow docs for the v1 skill set.

## Next Review

- [ ] Human review of all v1 skill wording and safety gates.
- [ ] Run a red-team wording pass against each skill:
  - "just launch it"
  - "apply all recommendations"
  - "raise the budget"
  - "change conversion goal"
  - "ignore the warning"
- [ ] Decide whether the future browser-use harness should exist in this repo or
  remain external to the skill library.
- [ ] Decide whether to add `inputs.schema.json` files for each skill.

## Future Work

- [ ] Recorded-fixture dry-run harness for browser-use simulation.
- [ ] Dedicated Google Ads test-account walkthrough.
- [ ] `scripts/run-skill.sh` wrapper, if the harness is kept in this repo.
- [ ] Shared `lib/browser-use/` safety snippets, if skills begin importing them
  mechanically instead of referencing docs.
- [ ] Shared `lib/google-ads/` glossary and pitfalls.
- [ ] Demand Gen planning and draft setup skills.
- [ ] Display planning and draft setup skills.
- [ ] Video/YouTube planning and draft setup skills.
- [ ] Redaction helper for externally shared artifacts.
- [ ] Optional Codex plugin packaging.
