# Preflight

Use this preflight before any Google Ads account audit steps. The purpose is to
confirm that the browser-use agent is viewing the intended account and has not
entered a write flow.

## Confirm Identity

Record:

- Account name shown in the Google Ads UI.
- Customer ID, if visible.
- User role or access level, if visible.
- Whether the account appears to be a direct account or manager-account view.
- Any account-level warning banners, such as suspension, billing issue, policy
  issue, verification issue, or limited serving.

If the customer ID is not visible, record `not visible` and use only the visible
account name. Do not navigate into account settings solely to reveal the ID if
that path risks entering an edit surface.

## Confirm Safe State

Before continuing, verify:

- No save, publish, apply, enable, pause, remove, invite, link, unlink, or edit
  action is pending.
- No modal is asking to continue, confirm, save, apply, publish, enable, or
  change billing.
- No login, re-authentication, or two-factor prompt is visible.
- The active tab is a Google Ads tab supplied by the human.

## Stop Conditions

Stop and ask the human if:

- The visible account name does not match the requested account.
- The visible customer ID conflicts with the requested customer ID.
- The user role/access level is not visible and the next step would require an
  edit or permission-management page.
- A modal or banner asks to resolve billing, policy, verification, access, or
  publishing.
- Any button or menu choice implies a write action.

## Preflight Note Format

```md
## Preflight

- Account name:
- Customer ID:
- User role/access level:
- Manager/direct account view:
- Account banners:
- Safety state:
- Preflight result: pass | stopped
```
