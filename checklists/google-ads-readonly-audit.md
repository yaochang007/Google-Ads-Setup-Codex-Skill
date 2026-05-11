# Google Ads Read-Only Audit Checklist

Use this checklist when reviewing a `google-ads-account-audit` run. It is
human-facing and confirms that the browser-use agent stayed read-only.

## Account Confirmation

- [ ] Account name was recorded.
- [ ] Customer ID was recorded if visible.
- [ ] User role/access level was recorded if visible.
- [ ] Any account-level banners or alerts were recorded.
- [ ] The audit stopped if account identity could not be confirmed.

## Read-Only Coverage

- [ ] Account overview was inspected.
- [ ] Billing status was inspected in read-only mode.
- [ ] Existing campaigns were inspected in read-only mode.
- [ ] Campaign statuses were inspected in read-only mode.
- [ ] Conversion actions were inspected in read-only mode.
- [ ] Linked accounts were inspected in read-only mode.
- [ ] Account access/users were inspected in read-only mode.
- [ ] Recommendations were inspected in read-only mode.

## Safety Confirmation

- [ ] No campaign was created.
- [ ] No campaign, ad group, ad, asset, or recommendation was enabled or paused.
- [ ] No budget was edited.
- [ ] No bidding setting was changed.
- [ ] No conversion action or goal was edited.
- [ ] No recommendation was applied, dismissed, or auto-applied.
- [ ] No billing setting was changed.
- [ ] No account access or user permission was changed.
- [ ] No save, publish, apply, continue, or confirm action was clicked.
- [ ] The agent stopped before any destructive or spend-related action.
- [ ] The agent asked the human if a modal requested save/apply/continue.

## Output Review

- [ ] Account identity section is complete or marks unknowns explicitly.
- [ ] Billing readiness section is complete or marks unknowns explicitly.
- [ ] Campaign summary is complete for visible campaigns.
- [ ] Conversion tracking status is complete for visible conversion actions.
- [ ] Linked accounts section is complete for visible links.
- [ ] Account access summary is complete for visible users/managers.
- [ ] Risks/issues are separated from observed facts.
- [ ] Recommended next steps are proposals only and do not imply approval to act.

## Gate A

- [ ] Human reviewed the audit report.
- [ ] Human explicitly approved with `approve audit` or `audit looks good`, or
      withheld approval and requested corrections.
