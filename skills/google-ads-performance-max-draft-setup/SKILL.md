---
name: google-ads-performance-max-draft-setup
description: Use when asked to guide browser-use setup of a Google Ads Performance Max campaign draft from an approved plan. May prepare draft fields only after explicit approval; must stop before publish, enable, launch, final save, or any spend-starting action.
---

# Google Ads Performance Max Draft Setup

Guide a browser-use agent through preparing a Performance Max campaign draft
from an approved plan. Because Performance Max can expand across inventory, this
skill is conservative and must stop before final save, publish, enable, launch,
or spend authorization.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/performance-max-draft-output-template.md`
- `../../checklists/google-ads-performance-max-draft-setup.md`

## When to use

Use this skill when the human has approved a Performance Max plan and asks the
agent to guide browser-use draft setup.

## Inputs required

- Target account name and customer ID.
- Approved Performance Max plan.
- Gate B approval text.
- Campaign name, budget cap, bidding objective, conversion goal, locations,
  languages, asset groups, audience signals, final URLs, URL exclusions, brand
  exclusions, assets, and Merchant Center/feed status if ecommerce applies.
- Confirmation that this run stops before final save/publish/enable/launch.

## Preflight checks

Complete `references/preflight.md`. Confirm account identity, customer ID,
visible access level if possible, approved plan, conversion tracking readiness,
asset readiness, final URL expansion settings, and Gate B approval. Stop if any
critical input is missing or conflicts with the UI.

## Browser-use workflow

1. Confirm target account and approved plan.
2. Ask for Gate B approval before entering campaign setup.
3. Navigate only within the human-provided Google Ads tab.
4. Enter Performance Max setup only after Gate B approval.
5. Fill draft fields from the approved plan: goal, budget, bidding, locations,
   languages, final URL settings, URL exclusions, asset groups, assets, audience
   signals, brand exclusions, Merchant Center/feed selection if relevant, and
   tracking.
6. Keep the campaign draft/paused/not-published wherever the UI offers that
   option.
7. Stop before any final save, publish, enable, launch, continue-to-publish, or
   confirmation step.
8. Produce a draft setup summary and hand off to final launch review.

## Human approval gates

- Gate B - Draft Review: required before setup and before treating the draft as
  ready for QA.
- Gate D - Spend Authorization: not executable in this skill; required later.
- Gate G - Targeting Expansion: required for final URL expansion, audience
  broadening, inventory expansion, or brand-exclusion changes beyond the plan.

## Never do without approval

Never create, save, publish, launch, enable, pause, remove, or finalize a
campaign without explicit approval. Even with Gate B, do not click final save,
publish, enable, or launch in this skill. Never change billing, account access,
conversion actions, Merchant Center links, enabled campaign budgets, enabled
campaign bidding. Never apply recommendations.

## Stop conditions

Stop if the UI shows `Publish`, `Enable`, `Launch`, `Save`, `Apply`,
`Continue`, or any equivalent final action. Stop if Google Ads changes or
recommends changing final URL expansion, budget, bidding, locations, conversion
goal, Merchant Center/feed, audience signals, assets, or brand exclusions away
from the approved plan. Stop on re-auth, billing, policy, account mismatch, or
unexpected confirmation modals.

## Output format

Write `performance-max-draft-summary.md` using the output template. Include
entered/intended fields, mismatches, stopped actions, and the next recommended
skill: `google-ads-final-launch-review`.
