---
name: google-ads-final-launch-review
description: Use when asked to run final pre-launch QA, launch readiness review, publish review, or enable review for a Google Ads campaign. Verifies settings, budget, bidding, conversion goals, locations, languages, assets, landing pages, tracking, billing readiness, and exact human approval before launch.
---

# Google Ads Final Launch Review

Run the final pre-launch review for a drafted campaign. This skill verifies
launch readiness and human approvals. It must not click publish, enable, launch,
or final save unless the human explicitly asks for that execution and confirms
the exact campaign and budget using the required approval format.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/final-launch-output-template.md`
- `../../checklists/google-ads-final-launch-review.md`

## When to use

Use this skill when the human asks for final launch review, pre-launch QA,
publish readiness, enable readiness, or final sign-off for a drafted Search or
Performance Max campaign.

## Inputs required

- Target account name and customer ID.
- Draft campaign name and campaign type.
- Approved plan and draft setup summary.
- Expected budget and bidding strategy.
- Expected locations, languages, networks/final URL settings, conversion goals,
  ad assets, landing pages, tracking, and status.
- Billing readiness from the latest account audit.
- Human QA sign-off and exact launch authorization if launch execution is
  requested.

## Preflight checks

Complete `references/preflight.md`. Confirm account identity, draft campaign,
expected settings, billing readiness, conversion tracking readiness, and whether
the human wants review-only or launch execution. Default to review-only.

## Browser-use workflow

1. Confirm account and draft campaign identity.
2. Review campaign status and verify it is not already enabled unexpectedly.
3. Verify budget exactly matches the expected value.
4. Verify bidding strategy and targets.
5. Verify conversion goals and tracking readiness.
6. Verify locations, languages, networks, final URL settings, brand exclusions,
   Merchant Center/feed selection if relevant, and targeting constraints.
7. Verify ads, assets, asset groups, ad groups, keywords, negatives, final URLs,
   and landing pages.
8. Verify billing readiness and absence of account-level blocking warnings.
9. Produce the final launch review checklist and stop for Gate C sign-off.
10. If the human requested launch execution, ask for Gate D approval with the
    exact campaign name and budget.
11. Do not click publish, enable, launch, or final save unless Gate C is signed
    and Gate D matches exactly.

## Human approval gates

- Gate C - QA Sign-off: required before launch can be considered.
- Gate D - Spend Authorization: required before publish/enable/launch/final
  save. Approval format:
  `approve publish <campaign-name> budget <number>`.
- Gate E/F/G: required if the final review discovers budget, bidding, or
  targeting changes are needed before launch.

## Never do without approval

Never publish, enable, launch, final save, pause, remove, or edit a campaign
without explicit approval. Never change budgets, bidding, conversion actions,
billing, account access, recommendations, targeting, ads, assets, keywords,
negatives, tracking, final URL expansion, or Merchant Center links without the
specific required gate. Never apply recommendations. Never proceed if the exact
campaign name or budget is uncertain.

## Stop conditions

Stop if the campaign name, budget, bidding, conversion goal, locations,
languages, assets, landing pages, billing readiness, or tracking readiness do
not match expectations. Stop if Gate C is unsigned, Gate D is absent or has the
wrong budget, the UI shows unexpected changes, or a policy/billing/re-auth modal
appears.

## Output format

Write `final-launch-review.md` using the output template. Include pass/fail
status, mismatches, approvals required, and the exact launch approval phrase if
launch execution is requested.
