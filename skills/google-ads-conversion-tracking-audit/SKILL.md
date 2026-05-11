---
name: google-ads-conversion-tracking-audit
description: Use when asked to audit, review, inspect, or troubleshoot Google Ads conversion tracking in read-only mode, including conversion goals, conversion actions, GA4/GTM readiness, linked accounts, tag status, and recent conversion activity.
---

# Google Ads Conversion Tracking Audit

This is a strictly read-only browser-use skill. It audits conversion tracking
readiness and recent activity without editing goals, conversion actions, tags,
linked accounts, or website code.

## Required references

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/conversion-tracking-output-template.md`
- `../../checklists/google-ads-conversion-tracking-audit.md`

## When to use

Use this skill when the human asks for a conversion tracking audit, goal review,
conversion action review, GA4/GTM readiness check, tag readiness check, or
recent conversion activity inspection.

## Inputs required

- Target Google Ads account name.
- Target customer ID, if known.
- Expected conversion actions or business goals, if known.
- Lookback window for recent activity, defaulting to 30 days.
- Known GA4, GTM, website, or CRM dependencies, if provided by the human.

## Preflight checks

Complete `references/preflight.md` before inspecting conversion pages.
Confirm account name, customer ID if visible, and user role/access level if
visible. Stop if the account identity is uncertain or conflicts with the target.

## Browser-use workflow

1. Stay in the human-provided Google Ads tab and confirm the active account.
2. Open Goals or Conversions pages in read-only mode.
3. Inventory visible conversion goals and conversion actions.
4. For each visible action, record name, source, status, optimization setting,
   recent activity indicators, primary/secondary role, and obvious warnings.
5. Inspect tag diagnostics, Google tag, GTM, and GA4 linking readiness only from
   read-only status pages or detail views.
6. Review linked-account readiness for GA4, Google Tag Manager, Merchant Center,
   YouTube, Firebase, CRM, or offline conversion imports when visible.
7. Compare visible conversion actions against the expected business goals.
8. Record missing, duplicate, inactive, unverified, or unclear conversion setup.
9. Produce the report using `references/conversion-tracking-output-template.md`.
10. Stop at Gate A - Audit Review.

## Human approval gates

- Gate A - Audit Review: required before other skills rely on this conversion
  audit.

Gate A approval does not authorize conversion edits, tag edits, linking changes,
or website changes.

## Never do without approval

Never create, edit, remove, reclassify, import, or reassign conversion actions
or conversion goals. Never change primary/secondary optimization, attribution,
value rules, counting method, enhanced conversions, Google tag settings, GA4
links, GTM containers, offline import settings, or website tags. Never save,
publish, apply, continue, or confirm changes.

## Stop conditions

Stop immediately if Google Ads shows an edit form, confirmation modal, re-auth
prompt, tag installation wizard, code snippet flow, link/unlink prompt, save
button, apply button, or any step that could change tracking or account links.
Stop if conversion status cannot be read without entering an edit flow.

## Output format

Write `conversion-tracking-audit.md` using the output template. Include observed
facts, unknowns, risks, and recommended next steps. Do not present any next step
as approved for execution.
