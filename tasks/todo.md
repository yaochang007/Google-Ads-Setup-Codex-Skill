# Todo

Project: Google Ads Setup — Codex skill library + browser-use workflow.

See:
- `docs/architecture.md`
- `docs/decisions.md`
- `docs/browser-use-safety.md`
- `docs/google-ads-workflows.md`
- `docs/approval-gates.md`

## Now (P0 — first release)

### Immediate next Codex task

- [ ] **Scaffold the repository layout.** Create the empty directories defined
  in `docs/architecture.md` (`skills/`, `lib/browser-use/`,
  `lib/google-ads/`, `artifacts/`, `state/`) with a `.gitkeep` in each. Add
  `artifacts/` and `state/` to `.gitignore`. Update `README.md` to point at
  the five new docs and to remove the template-era language. **Do not create
  any skills in this task.**

### After scaffolding, build the first 5 skills, in order

The five skills below are the P0 cut. Each task creates one skill folder under
`skills/`. The skill files themselves are written in a follow-up planning pass
using the `superpowers:writing-plans` skill — this todo list captures the
order, not the implementation steps.

- [ ] **Skill 1: `audit-account` (W01).** Read-only. Walks the agent through
  capturing a snapshot of the account: campaigns, status, daily budgets,
  bidding strategies, conversion goals linked, geo + language targeting,
  active recommendations, auto-apply status, billing-banner state. Output:
  `audit-summary.md` + `account-snapshot.json`. Gate A only.

- [ ] **Skill 2: `audit-conversion-tracking` (W02).** Read-only. Inventories
  conversion actions and goals, flags ones not firing in the last 30 days,
  and diffs against `expected_conversion_actions`. Output:
  `conversion-tracking-audit.md`. Gate A only.

- [ ] **Skill 3: `research-keywords` (W03).** Mostly read-only (uses Keyword
  Planner). Produces an intent map and seed negatives. Output:
  `keyword-plan.md`, `intent-map.md`, `negatives-seed.txt`. Gate A only.

- [ ] **Skill 4: `draft-search-campaign` (W04).** First write-capable skill.
  Builds a paused Search campaign from the W03 output. Output:
  `draft-plan.md`, `draft-diff.md`, `change-log.md`. Gates A + B.

- [ ] **Skill 5: `publish-and-enable` (W05).** Only skill that flips status
  from `paused` to `enabled`. Requires a closed Gate C from W13. Output:
  `publish-log.md`, before/after screenshots. Gates C + D.

### Shared infrastructure (built alongside the skills above)

- [ ] **`lib/browser-use/safety-rules.md`.** The canonical safety-rules file
  that every `SKILL.md` includes. Content lifted from
  `docs/browser-use-safety.md`.

- [ ] **`lib/browser-use/denylist.md`.** The hard denylist, lifted from
  `docs/browser-use-safety.md`.

- [ ] **`lib/browser-use/allowlist.md`.** The allowed-actions list.

- [ ] **`lib/browser-use/stop-conditions.md`.** The stop-conditions list.

- [ ] **`lib/google-ads/glossary.md`.** Plain-language definitions of campaign
  type, ad group, asset group, conversion action, conversion goal, bidding
  strategy, search partner, network. So skills can be terse.

- [ ] **`lib/google-ads/pitfalls.md`.** Known traps: auto-applied recs,
  Performance Max audience signals being non-binding, search partners default,
  Display Network default on Search campaigns, broad match defaults under
  Maximize Conversions.

- [ ] **`scripts/run-skill.sh`.** Wrapper that starts a browser-use session
  attached to a skill folder, supports `--dry-run`, `--apply`, `--help`.

- [ ] **`scripts/check.sh` (real implementation).** Lints every skill: frontmatter,
  references to safety rules, gate IDs present, schema parses, allowlist
  coverage.

- [ ] **`skills/.template/`.** A skeleton skill folder with `SKILL.md`,
  `checklist.md`, `inputs.schema.json`, `references/`, `selectors.md`.

- [ ] **Pre-launch QA skill: `pre-launch-qa` (W13).** Required dependency for
  `publish-and-enable`. Builds and *requires* the human to sign the QA
  checklist. Gate C.

## Next (P1)

- [ ] **Skill: `draft-performance-max` (W06).** Stricter gates given PMax blast
  radius (Gate G applies for any audience-signal expansion).
- [ ] **Skill: `draft-demand-gen` (W07).**
- [ ] **Skill: `review-negative-keywords` (W10).** Reads the search-terms
  report and proposes negatives.
- [ ] **Skill: `propose-budget-change` (W11).** Read-only proposal; no execute.
- [ ] **Money-safety drills.** Document and rehearse the four red-team
  scenarios from `docs/google-ads-workflows.md`.
- [ ] **Recorded-fixture harness.** Capture HAR + screenshot fixtures so
  Layer 2 dry-run simulation works without a live account.

## Later (P2 / nice to have)

- [ ] **Skill: `draft-display-campaign` (W08).**
- [ ] **Skill: `draft-video-campaign` (W09).**
- [ ] **Skill: `weekly-digest` (W12).**
- [ ] **Codex plugin packaging.** Optionally package `skills/` as a Codex
  plugin so it can be installed in other projects.
- [ ] **Google Ads API for read-only reporting.** Revisit the API decision
  if/when we want richer cross-account reporting that the UI cannot produce
  efficiently.
- [ ] **Shopping / PMax-with-feed campaign coverage.** Out of scope for v1;
  needs separate Merchant Center workflow doc.

## Open Questions (resolve before P1)

- [ ] Where do approvals land — same chat as the agent, or a separate review
  surface? (Decision: same chat for v1; revisit if multi-operator.)
- [ ] How do we identify a "draft is stale"? E.g. an account-audit older than
  24h should invalidate the draft phase. Need a TTL convention in
  `state/<customer_id>.json`.
- [ ] How do we redact account IDs before sharing an artifact externally?
  Likely a `scripts/redact.sh` once we hit the need.
