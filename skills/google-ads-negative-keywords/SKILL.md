---
name: google-ads-negative-keywords
description: Use when asked to review search terms, plan negative keywords, propose negatives, or safely add negative keywords in Google Ads with explicit approval. Includes read-only search term review and approval gates before any negative keyword addition.
---

# Google Ads Negative Keywords

This skill reviews search terms, plans negative keywords, and may guide safe
negative keyword additions only after explicit approval for the exact negatives
and scope. It must not remove negatives or broaden delivery.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/negative-keywords-output-template.md`
- `../../checklists/google-ads-negative-keywords.md`

## When to use

Use this skill when the human asks to review search terms, find wasted queries,
plan negative keywords, add approved negatives, or create a negative keyword
proposal for campaigns or shared lists.

## Inputs required

- Target account name and customer ID.
- Campaigns, ad groups, or shared negative list scope.
- Date range and minimum spend/impression threshold for search term review.
- Business terms that should remain eligible.
- Proposed negatives, if supplied by the human.
- Approval mode: proposal-only or approved addition.

## Preflight checks

Complete `references/preflight.md`. Confirm account identity, scope, date range,
and whether this run is proposal-only or addition-approved. If approval is not
explicit, remain read-only and proposal-only.

## Browser-use workflow

1. Confirm account identity and search term review scope.
2. Review search terms in read-only mode for the requested date range.
3. Identify irrelevant, low-intent, competitor, job-seeker, support, free,
   informational, or otherwise wasteful terms.
4. Propose negatives with match type and scope. Explain why each is safe.
5. Stop for human review of the negative keyword proposal.
6. If and only if the human explicitly approves exact negatives and scope,
   guide adding those negatives.
7. Before saving or applying the negative keyword changes, surface the exact
   diff and ask for final confirmation.
8. Stop if the UI proposes removing negatives, broadening match, changing
   campaign status, or applying recommendations.

## Human approval gates

- Gate A - Audit Review: required for proposal review.
- Gate G - Targeting Expansion: required if any action could broaden delivery,
  such as removing negatives. This skill should normally refuse expansion.
- Negative Keyword Addition Gate: required before adding negatives. Approval
  format: `approve negatives <scope>: <count> terms`.

## Never do without approval

Never add negative keywords without exact human approval. Never remove negative
keywords, change match types beyond the approved list, change campaign status,
change budgets, change bidding, edit conversion actions, change billing, change
account access, save, publish, or apply uncertain changes. Never apply
recommendations.

## Stop conditions

Stop if search term scope is unclear, a proposed negative could block valuable
traffic, approval text does not match the exact scope/count, Google Ads shows a
save/apply confirmation with unexpected changes, or the UI asks to remove
negatives or apply recommendations.

## Output format

Write `negative-keyword-proposal.md` using the output template. If additions are
approved and performed in a later real run, include the exact approved terms,
scope, approval text, and post-action status. In this project context, do not
run real browser automation.
