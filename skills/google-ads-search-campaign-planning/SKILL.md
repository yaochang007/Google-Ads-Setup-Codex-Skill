---
name: google-ads-search-campaign-planning
description: Use when asked to plan, design, outline, or prepare a Google Ads Search campaign, including structure, keywords, negative keywords, ads, budget, bidding, locations, languages, landing pages, conversion goals, and approval gates. Planning-only; no browser changes.
---

# Google Ads Search Campaign Planning

This is a planning-only skill. It drafts a Search campaign plan and review
checklist without touching Google Ads, creating campaigns, changing settings, or
starting spend.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/search-plan-template.md`
- `../../checklists/google-ads-search-campaign-planning.md`

## When to use

Use this skill when the human wants a Search campaign plan, keyword/ad group
structure, negative keyword plan, ad copy draft, budget/bidding proposal,
location/language plan, landing page review, or approval packet before setup.

## Inputs required

- Business summary and offer.
- Campaign goal and primary conversion goal.
- Target locations and languages.
- Landing page URLs.
- Seed keywords and excluded terms.
- Competitors or comparison terms, if relevant.
- Budget range or daily budget cap.
- Bidding preference or constraints.
- Brand policy, regulated-category limits, and required ad copy disclaimers.
- Recent account, conversion tracking, or reporting audit artifacts if present.

## Preflight checks

Complete `references/preflight.md`. Confirm this is planning-only and no Google
Ads browser-use actions will be taken. If the human asks to create or launch the
campaign in the same step, switch to the draft setup skill only after explicit
approval and keep launch separated.

## Browser-use workflow

No browser-use workflow runs for this skill. Do not open Google Ads. Do not log
in. Do not inspect or modify a real account. If context is missing, ask for it
or mark the plan section as `needs human input`.

## Human approval gates

- Gate A - Audit Review: recommended if this plan depends on a prior account,
  conversion, or reporting audit.
- Gate B - Draft Review: required before any draft setup skill uses this plan.
- Gate E - Budget Change: applies to any later budget edit on an enabled
  campaign.
- Gate F - Bidding-Strategy Change: applies to any later bidding edit.
- Gate G - Targeting Expansion: applies to any later reach expansion.

## Never do without approval

Never create, enable, pause, remove, publish, launch, or save a campaign. Never
change billing, budgets, bidding, conversion actions, recommendations, account
access, targeting, keywords, negatives, ads, assets, or tracking. This planning
skill must not execute any browser action. Never apply recommendations.

## Stop conditions

Stop if the human asks to launch, publish, enable, edit a live campaign, use a
real account without audit context, or proceed with an ambiguous budget,
location, conversion goal, landing page, compliance requirement, or business
policy.

## Output format

Write a Search campaign plan using `references/search-plan-template.md`. Include
all assumptions, open questions, approval gates, and items that must be
confirmed before browser-use draft setup.
