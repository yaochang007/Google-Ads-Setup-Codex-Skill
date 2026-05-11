---
name: google-ads-budget-and-bidding-review
description: Use when asked to review, audit, inspect, or propose Google Ads budgets and bidding strategies. Read-only/planning skill that reviews spend, budget caps, bidding strategy, CPA/ROAS, constraints, and recommendations; never changes budgets or bidding without explicit approval.
---

# Google Ads Budget and Bidding Review

This is a read-only and planning skill. It reviews budget and bidding state and
produces recommendations, but it does not change budgets or bidding.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/budget-bidding-output-template.md`
- `../../checklists/google-ads-budget-and-bidding-review.md`

## When to use

Use this skill when the human asks for a budget review, bidding review,
CPA/ROAS analysis, spend pacing review, budget change proposal, bidding
strategy proposal, limited-by-budget review, or recommendations sanity check.

## Inputs required

- Target account name and customer ID.
- Campaigns or campaign types to review.
- Date range and comparison range.
- Business KPI: CPA, ROAS, conversion volume, conversion value, or spend pacing.
- Current budget constraints and proposed budget/bidding ideas, if any.

## Preflight checks

Complete `references/preflight.md`. Confirm account identity, date range,
campaign scope, and that this run is read-only/planning unless a separate,
explicit approval workflow is invoked later.

## Browser-use workflow

1. Confirm account identity and date range.
2. Review campaign budgets, spend, pacing, statuses, and limited-by-budget
   indicators in read-only mode.
3. Review bidding strategies, targets, conversion volume, CPA/ROAS, and obvious
   learning or constraint indicators.
4. Review recommendation cards related to budget or bidding in read-only mode.
5. Compare current state to the human's KPI goals.
6. Produce budget and bidding recommendations as proposals only.
7. Stop at Gate A - Audit Review.

## Human approval gates

- Gate A - Audit Review: required before the review is used for planning.
- Gate E - Budget Change: required before any later budget change.
- Gate F - Bidding-Strategy Change: required before any later bidding change.
- Gate D - Spend Authorization: required before any launch/enable action.

## Never do without approval

Never change a budget, bidding strategy, target CPA, target ROAS, campaign
status, recommendations, conversion actions, billing, account access, targeting,
or tracking. Never apply recommendations. Never save, apply, publish, launch,
enable, pause, or finalize changes. This skill does not execute budget or
bidding changes.

## Stop conditions

Stop if the UI opens an edit budget/bidding flow, shows an apply/save modal,
asks to apply a recommendation, or if performance data is too sparse to support
a recommendation without human context.

## Output format

Write `budget-bidding-review.md` using the output template. Mark every budget or
bidding idea as `proposal only` and include the required approval gate for any
future execution.
