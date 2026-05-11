# Conversion Tracking Audit Preflight

Record these values before inspecting conversion tracking:

- Account name:
- Customer ID:
- User role/access level:
- Expected conversion actions:
- Lookback window:
- Visible account warnings:

Confirm the browser is not in an edit wizard, tag setup wizard, billing modal,
or account-linking flow. If the visible customer ID conflicts with the target,
stop. If a re-authentication prompt appears, stop and ask the human.

Safe pages include read-only conversion summaries, conversion action detail
views, diagnostics views, linked-account status views, and tag status views.
Unsafe pages include create/edit conversion action flows, tag installation
wizards, link/unlink flows, and any page with a pending save/apply state.
