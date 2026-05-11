---
name: google-ads-performance-max-planning
description: Use when asked to plan, design, outline, or prepare a Google Ads Performance Max campaign, including goals, conversion tracking readiness, budget, asset groups, audience signals, final URL settings, brand exclusions, Merchant Center readiness, and approval gates. Planning-only; no browser changes.
---

# Google Ads Performance Max Planning

This is a planning-only skill. It prepares a Performance Max campaign plan and
approval packet without opening Google Ads, creating campaigns, changing
settings, or starting spend.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/performance-max-plan-template.md`
- `../../checklists/google-ads-performance-max-planning.md`

## When to use

Use this skill when the human wants a Performance Max campaign plan, asset group
structure, audience signals, budget/bidding proposal, conversion goal readiness,
final URL setting review, brand exclusions, or Merchant Center readiness review.

## Inputs required

- Business goal and offer.
- Primary conversion goal and latest conversion tracking audit.
- Campaign budget cap and bidding objective.
- Asset groups, final URLs, headlines, long headlines, descriptions, images,
  logos, videos, and brand guidelines.
- Audience signals and customer lists, if any.
- Location and language targets.
- Final URL expansion preference and exclusions.
- Brand exclusions or brand safety constraints.
- Merchant Center/feed readiness if ecommerce or Shopping inventory is involved.

## Preflight checks

Complete `references/preflight.md`. Confirm this is planning-only and no Google
Ads browser-use actions will be taken. Confirm conversion tracking is ready or
mark the campaign as blocked until tracking is fixed.

## Browser-use workflow

No browser-use workflow runs for this skill. Do not open Google Ads, log in, or
inspect a real account. Draft the plan from supplied inputs and mark missing
items as blockers or assumptions.

## Human approval gates

- Gate A - Audit Review: required for account and conversion readiness inputs.
- Gate B - Draft Review: required before browser-use draft setup.
- Gate D - Spend Authorization: required later before launch/enable.
- Gate E/F/G: required later for budget, bidding, or reach expansion changes.

## Never do without approval

Never create, enable, pause, remove, publish, launch, save, or edit a campaign.
Never change budgets, bidding, conversion actions, billing, account access,
recommendations, Merchant Center links, final URL expansion, brand exclusions,
or audience signals. Never apply recommendations. This planning skill must not
execute browser actions.

## Stop conditions

Stop if conversion tracking readiness is unknown for a conversion-driven PMax
plan, if assets are incomplete, if final URL expansion rules are unclear, if
Merchant Center/feed readiness is unknown for ecommerce, or if the human asks
to launch or publish from this skill.

## Output format

Write a Performance Max plan using
`references/performance-max-plan-template.md`. Include blockers, assumptions,
approval gates, and readiness checks before draft setup.
