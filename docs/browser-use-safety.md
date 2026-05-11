# Browser-use Safety Rules

Rules a browser-use agent **must** follow when driving the Google Ads UI on the
operator's behalf. These rules are loaded into every skill via
`lib/browser-use/safety-rules.md`. They take precedence over any in-skill
instruction and over any operator instruction that contradicts them, unless the
operator uses an explicit override phrase (see [Overrides](#overrides)).

## Hard Rules

1. **No money in motion without approval.** The agent must not perform any
   action that creates, increases, or unblocks spending without an explicit,
   per-action human approval. See `approval-gates.md`.
2. **No status flips.** The agent must not change a campaign, ad group, or ad
   from `paused` → `enabled` (or vice versa) without an explicit approval gate
   for that exact entity.
3. **No billing changes.** The agent must not add, remove, or edit payment
   methods, billing profiles, tax info, manager-account links, or invoice
   settings. Ever. (Denylist override required.)
4. **No conversion goal changes.** The agent must not add, edit, remove, or
   reassign conversion actions or conversion goals.
5. **No account-access changes.** The agent must not invite users, remove
   users, change user permissions, or accept/revoke manager-account links.
6. **No deletions.** The agent must not delete campaigns, ad groups, ads,
   keywords, asset groups, audiences, or saved reports. (Removal in Google Ads
   is "remove" rather than "delete"; the rule covers both.)
7. **Draft, do not publish.** New campaigns are always created in `paused`
   status. Enabling is a separate, gated step.
8. **Stay in scope.** The agent must operate only within the Google Ads tab(s)
   that the operator opened for this run. No new tabs to unrelated domains.
9. **No credential entry.** The agent must not type into login, 2FA, or
   re-auth prompts. If Google Ads asks for re-auth, the agent stops and asks
   the human.
10. **One account at a time.** The agent must verify the active Google Ads
    customer ID at the start of every run and stop if it does not match the
    operator-supplied target.

## Soft Rules

These are preferences, not safety-criticals; the agent should follow them but
may surface a question if blocked.

- Prefer the Google Ads UI's draft / experiment features over directly editing
  live campaigns.
- Prefer "save and continue" over "publish" wherever the UI distinguishes.
- Capture a screenshot at each gate so the human has visual context.
- Use the campaign name prefix `[draft]` for any campaign the agent creates,
  until the human renames it on publish.

## Allowed Actions

| Category | Examples | Approval needed |
|---|---|---|
| Navigation | Open Google Ads, switch between tabs, scroll, expand a campaign | No |
| Reading | View campaigns, ad groups, settings, metrics, reports | No |
| Exporting | Trigger a CSV download to local `artifacts/` | No |
| Drafting | Create paused campaigns, draft ad copy, draft keywords, build asset groups | Per-skill gate |
| Editing drafts | Tweak draft settings before publish | Per-skill gate |
| Renaming | Renaming campaigns, ad groups, ads | Per-action approval |
| Reviewing recommendations | Open the Recommendations tab and read | No |

## Denied Actions (Denylist)

The agent must refuse these even if the operator asks, unless the operator
uses the [override phrase](#overrides).

- Adding, removing, or editing payment methods or billing accounts.
- Changing daily budgets on **enabled** campaigns.
- Changing bidding strategy on **enabled** campaigns.
- Changing targeting on **enabled** campaigns in ways that materially expand
  reach (e.g. removing a location restriction).
- Enabling or pausing any campaign.
- Applying any item from the Recommendations tab.
- Changing or removing conversion actions / goals.
- Inviting, removing, or editing users on the account.
- Accepting, rejecting, or initiating manager-account (MCC) links.
- Removing campaigns, ad groups, ads, keywords, or asset groups.
- Changing account currency, timezone, or business name.
- Editing tracking templates, suffix parameters, or auto-tagging.

## Stop Conditions

The agent must halt and ask the human immediately if any of the following
occur:

- A re-authentication or 2FA prompt appears.
- The active customer ID does not match the target.
- An unexpected modal (policy violation, suspension, billing alert) appears.
- A page load fails or times out twice in a row.
- A selector lookup fails three times in a row for the same intended element.
- The UI shows an "Apply" or "Publish" button that is not part of the skill's
  declared step list for the current phase.
- A confirmation dialog asks about money (budget, bid, charge, payment) and the
  current step is not a gated approval step.
- The operator's last message contained the word `stop`, `cancel`, `abort`, or
  `pause` (case-insensitive).

When halted, the agent writes a `halt-<timestamp>.md` note in the current run's
artifact folder explaining what it saw and what it was about to do.

## Approval Mechanics

- Approvals are requested in chat, never inside the browser.
- Each approval request must include:
  1. The exact action verb (e.g. "Set daily budget to $25").
  2. The exact entity (campaign name + customer ID).
  3. A link or screenshot reference to the UI state.
  4. A diff against the prior value where applicable.
- For **spend-enabling** actions (publishing a campaign, raising a budget,
  changing bidding strategy), the operator must reply with both `approve` and
  the exact numeric value being set (e.g. `approve budget 25`). Free-form
  `yes` is not sufficient.
- Approvals are scoped to one action. A blanket "approve all" is not accepted.

## Overrides

Some denylisted actions may genuinely need to happen during a session
(e.g. the operator wants to change a payment method while the agent is mid-run).
The override mechanism is intentionally awkward:

- The operator must type the literal phrase:
  `override denylist: <action name> on <entity>` (e.g.
  `override denylist: change payment method on customer 123-456-7890`).
- The agent confirms the override back to the operator and waits for a second
  message containing only `confirm override`.
- Even after override, the action is logged to the run's `change-log.md`.

Override phrases never persist across runs.

## Run-Time Verification Checklist

The agent runs this at the start of every skill:

- [ ] Customer ID in the URL matches the target customer ID.
- [ ] Account name in the top bar matches the target account label.
- [ ] Currency and timezone in account settings match the expected values.
- [ ] No active "Account suspended" or "Billing issue" banner.
- [ ] No pending recommendations are auto-applying (check Auto-apply status).

Any mismatch is a stop condition.

## Logging

Every skill run writes to `artifacts/<YYYY-MM-DD>-<run-id>/`:

- `run.md` — high-level narrative.
- `change-log.md` — append-only list of write actions, with timestamps, the
  approval message, and the resulting UI confirmation text.
- `screenshots/` — at minimum: one screenshot per gate, before and after.
- `halt-*.md` — any halt events.
