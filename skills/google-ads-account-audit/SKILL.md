---
name: google-ads-account-audit
description: Use when asked to audit, review, inspect, or summarize a Google Ads account in read-only mode, including account overview, billing readiness, existing campaigns, campaign statuses, conversion actions, linked accounts, account access/users, or recommendations. This skill never creates, edits, enables, pauses, applies, publishes, saves, or changes Google Ads settings.
---

# Google Ads Account Audit

Guide a browser-use agent through a strictly read-only Google Ads account audit.
This skill is for account review and inspection only. It must not create,
modify, publish, enable, pause, save, apply, or remove anything.

## Required References

- `../../docs/browser-use-safety.md`
- `../../docs/approval-gates.md`
- `references/preflight.md`
- `references/audit-output-template.md`
- `../../checklists/google-ads-readonly-audit.md`

The safety rules in `../../docs/browser-use-safety.md` take precedence over this
skill. If any Google Ads page, banner, modal, drawer, or prompt asks to save,
apply, continue, publish, enable, pause, edit, remove, invite, change billing,
or confirm an action, stop and ask the human.

## When to use

Use this skill when the human asks for a Google Ads account audit, account
review, read-only inspection, or current-state snapshot.

## Inputs required

- Target Google Ads account name.
- Target customer ID, if known.
- Audit depth: `summary` or `full`.
- Any account areas the human expects to be present or absent.

## Preflight checks

Before navigating beyond the initial Google Ads page, complete
`references/preflight.md`.

You must confirm and record:

- Google Ads account name.
- Customer ID, if visible.
- User role or access level, if visible.

If the account identity cannot be confirmed, stop and ask the human for
direction. If the visible customer ID conflicts with the requested target, stop.

## Browser-use workflow

Inspect only these areas:

- Account overview.
- Billing status, read-only.
- Existing campaigns, read-only.
- Campaign statuses, read-only.
- Conversion actions, read-only.
- Linked accounts, read-only.
- Account access/users, read-only.
- Recommendations, read-only.

Do not inspect unrelated account sections. If the human asks for a section
outside this scope, stop and explain that it belongs in a separate read-only
skill or a future approved workflow.

1. Open or stay in the human-provided Google Ads tab.
2. Confirm the account identity and access level using the preflight reference.
3. Review the account overview without changing filters unless necessary to see
   current account state. Record high-level status, alerts, and notable trends.
4. Review billing status in read-only mode. Record whether billing appears
   ready, limited, suspended, missing, or unclear. Do not open payment edit
   flows.
5. Review existing campaigns. Record campaign names, types, statuses, and any
   visible high-level delivery or policy warnings.
6. Review campaign statuses. Confirm which campaigns are enabled, paused,
   removed, limited, pending, or otherwise constrained.
7. Review conversion actions. Record visible actions, statuses, source/type,
   recent activity indicators, and obvious issues. Do not edit goals or actions.
8. Review linked accounts. Record visible links and statuses, such as Analytics,
   Merchant Center, YouTube, Search Console, or manager-account relationships.
   Do not accept, reject, unlink, or initiate links.
9. Review account access/users. Record visible users, roles, pending invites,
   and manager access. Do not invite, remove, or change permissions.
10. Review recommendations in read-only mode. Record categories and notable
    recommendations. Do not apply, dismiss, auto-apply, or preview changes that
    require confirmation.
11. Produce the audit report using `references/audit-output-template.md`.
12. Stop at Gate A - Audit Review. Ask the human to review the audit artifact.

## Human approval gates

- Gate A - Audit Review: required before another workflow treats this audit as
  the current account snapshot.

Gate A approval does not authorize edits.

## Never do without approval

Never do any of the following:

- Create campaigns, ad groups, ads, assets, audiences, keywords, or negatives.
- Enable or pause campaigns, ad groups, ads, assets, or recommendations.
- Edit budgets.
- Change bidding.
- Edit conversion actions, goals, tracking templates, or attribution settings.
- Apply recommendations or enable auto-apply.
- Change billing, payment methods, tax settings, invoices, or billing profiles.
- Change account access, invite users, remove users, edit roles, or accept links.
- Save, publish, apply, continue through, or confirm any change.

If a destructive, account-access, or spend-related action appears possible, stop
before clicking it. Do not test whether a button is safe by clicking it.

## Stop conditions

- Stop before any destructive, account-access, or spend-related action.
- Ask human approval if any modal asks to save, apply, continue, confirm, or
  publish.
- Do not click `Publish`, `Enable`, `Pause`, `Apply`, `Auto-apply`, `Save`,
  `Remove`, `Invite`, `Accept`, `Link`, `Unlink`, or any equivalent action.
- Do not type into login, re-authentication, two-factor, payment, or account
  access fields.
- Do not navigate into edit forms unless the page is clearly read-only. If the
  only path to view a value is an edit form, stop and ask the human.
- Prefer reading visible tables, details panels, and status pages. Close any
  accidental edit surface without saving if a safe close or cancel option is
  clearly available; otherwise stop.

## Output format

Create an audit report with these sections:

- Account identity.
- Billing readiness.
- Campaign summary.
- Conversion tracking status.
- Linked accounts.
- Account access summary.
- Risks/issues.
- Recommended next steps.

The report should distinguish observed facts from recommendations. Include
unknowns explicitly rather than guessing.

At the end of the audit, stop and present the report to the human.

Ask for Gate A approval only:

```text
Gate A - Audit Review
Please review the read-only account audit. To approve it as the current account
snapshot, reply with `approve audit` or `audit looks good`.
```

Gate A approval does not authorize any edits. This skill ends after Gate A.
