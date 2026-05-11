---
name: google-ads-reporting-audit
description: Use when asked to audit, review, inspect, or summarize Google Ads reporting in read-only mode, including campaign performance, conversions, spend, CPA, ROAS, search terms, assets, recommendations, and account health.
---

# Google Ads Reporting Audit

This is a strictly read-only browser-use skill for reviewing reporting and
performance signals. It must not edit campaigns, budgets, bidding, tracking,
recommendations, reports, or account settings.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/reporting-output-template.md`
- `../../checklists/google-ads-reporting-audit.md`

## When to use

Use this skill when the human asks for a reporting audit, performance review,
campaign health review, CPA/ROAS review, search terms review, asset review,
recommendations review, or account health snapshot.

## Inputs required

- Target Google Ads account name.
- Target customer ID, if known.
- Date range and comparison range.
- Primary KPIs, such as conversions, cost, CPA, conversion value, ROAS, CTR, or
  search terms quality.
- Campaigns or campaign types to include, if scoped.

## Preflight checks

Complete `references/preflight.md`. Confirm account name, customer ID if
visible, user role/access level if visible, and date range. Stop if the account
or date range is uncertain.

## Browser-use workflow

1. Confirm account identity and date range.
2. Review account health banners, policy warnings, billing warnings, and major
   delivery constraints in read-only mode.
3. Review campaign performance: cost, conversions, conversion value, CPA/ROAS,
   status, impression share if visible, and obvious outliers.
4. Review conversion reporting for volume, value, and tracking gaps.
5. Review spend distribution by campaign or campaign type.
6. Review search terms in read-only mode, noting irrelevant queries, missing
   negatives, high-cost terms, and conversion-driving terms.
7. Review assets and ads in read-only mode, noting disapproved, limited, weak,
   or missing assets.
8. Review recommendations in read-only mode. Record the recommendation category
   and risk if applied blindly. Do not apply or dismiss.
9. Produce the report using `references/reporting-output-template.md`.
10. Stop at Gate A - Audit Review.

## Human approval gates

- Gate A - Audit Review: required before recommendations, negative keywords,
  budgets, bidding, or draft setup skills rely on this report.

Gate A approval does not authorize edits.

## Never do without approval

Never create, edit, pause, enable, remove, publish, save, or apply anything.
Never change budgets, bidding, targeting, recommendations, conversion actions,
assets, reports, columns, account access, or billing. Never apply Google
recommendations automatically.

## Stop conditions

Stop if any page asks to save/apply a report, create a report, add a negative
keyword, apply a recommendation, edit a campaign, change a date range in a way
that conflicts with the requested range, re-authenticate, or resolve billing.

## Output format

Write `reporting-audit.md` using the output template. Separate observed
performance facts from interpretation and recommended next steps.
