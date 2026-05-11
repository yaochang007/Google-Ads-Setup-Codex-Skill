---
name: google-ads-search-campaign-draft-setup
description: Use when asked to guide browser-use setup of a Google Ads Search campaign draft from an approved plan. May prepare draft fields only after explicit approval; must stop before publish, enable, launch, final save, or any spend-starting action.
---

# Google Ads Search Campaign Draft Setup

Guide a browser-use agent through preparing a Search campaign draft from an
approved plan. This skill may enter draft setup only after explicit human
approval and must stop before publish, enable, launch, final save, or any action
that could start spend.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/search-draft-output-template.md`
- `../../checklists/google-ads-search-campaign-draft-setup.md`

## When to use

Use this skill when the human has approved a Search campaign plan and asks the
agent to guide browser-use draft setup in Google Ads.

## Inputs required

- Target account name and customer ID.
- Approved Search campaign plan.
- Campaign name, budget cap, bidding strategy, locations, languages, networks,
  conversion goal, ad groups, keywords, negatives, ads, and landing pages.
- Gate B approval text for draft setup.
- Confirmation that this run stops before final save/publish/enable/launch.

## Preflight checks

Complete `references/preflight.md`. Confirm account identity, customer ID,
visible access level if possible, approved plan, and Gate B approval. Stop if
the account identity, budget cap, conversion goal, landing pages, or approval
text is missing or ambiguous.

## Browser-use workflow

1. Confirm the target account and the approved campaign plan.
2. Ask for Gate B approval before entering any campaign creation flow.
3. Navigate only within the human-provided Google Ads tab.
4. Enter the Search campaign setup flow only after Gate B approval.
5. Fill draft fields from the approved plan: campaign name, goal, networks,
   locations, languages, budget, bidding, ad groups, keywords, negatives, ads,
   and final URLs.
6. Keep the campaign in draft/paused/not-published state wherever the UI offers
   that option.
7. Before any final save, publish, enable, launch, continue-to-publish, or
   confirmation step, stop and produce a draft summary.
8. Do not click the final action. Hand off to final launch review.

## Human approval gates

- Gate B - Draft Review: required before entering campaign setup and again
  before the human treats the draft as ready for QA.
- Gate D - Spend Authorization: not executable in this skill; required later by
  `google-ads-final-launch-review` for any publish/enable/launch action.
- Gate E/F/G: required later for budget, bidding, or targeting changes beyond
  the approved plan.

## Never do without approval

Never create, save, publish, launch, enable, pause, remove, or finalize a
campaign without explicit approval. Even with Gate B, do not click final save,
publish, enable, or launch in this skill. Never change billing, account access,
conversion actions, enabled campaign budgets, enabled campaign bidding, or apply
recommendations. Never apply recommendations.

## Stop conditions

Stop if the UI shows `Publish`, `Enable`, `Launch`, `Save`, `Apply`, `Continue`,
or any equivalent final action. Stop if the UI changes the budget, bidding,
network, location, conversion goal, or status away from the approved plan. Stop
on re-auth, billing, policy, account mismatch, or unexpected confirmation
modals.

## Output format

Write `search-draft-summary.md` using the output template. Include every field
entered or intended, every mismatch, screenshots if available, and the next
recommended skill: `google-ads-final-launch-review`.
