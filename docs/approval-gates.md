# Approval Gates

Approval gates are the human-in-the-loop checkpoints that protect against
unwanted spend, unwanted delivery changes, and unwanted account changes. This
document is normative: every skill must reference these gates by ID.

## Gate Lifecycle

Each gate has the same lifecycle:

```text
PENDING --(agent surfaces request)--> AWAITING APPROVAL
        --(human approves)----------> APPROVED
        --(human denies / silence)---> DENIED
APPROVED --(agent performs action)---> EXECUTED
EXECUTED --(agent logs)--------------> CLOSED
```

A gate is not closed until the post-action confirmation is logged.

## Gate IDs

### Gate A — Audit Review

- **When:** After every read-only audit (W01, W02, W10, W11, W12), before any
  draft phase can start.
- **What the human approves:** "The audit reflects the current state of the
  account as I expect."
- **Approval format:** Free-form `approve audit` or `audit looks good`.
- **Why it exists:** Catches account-ID mismatches, conversion-tracking gaps,
  unexpected campaigns, suspensions.

### Gate B — Draft Review

- **When:** After a draft campaign is built (W04, W06, W07, W08, W09), before
  the QA gate can run.
- **What the human approves:** Each draft entity (campaign, ad groups, ads,
  asset groups) by name.
- **Approval format:** `approve draft <campaign-name>`.
- **Why it exists:** Last chance to fix typos, wrong landing pages, wrong
  targeting before QA.

### Gate C — QA Sign-off

- **When:** After W13 runs the pre-launch QA against a draft.
- **What the human approves:** Each item on the QA checklist.
- **Approval format:** Human edits the `qa-checklist.md` artifact, checks every
  box, types their initials at the bottom, then replies `qa signed`.
- **Why it exists:** Forces the human to actually look at every required field
  (budget, bidding, targeting, ad copy, conversion goals, tracking template,
  geo and language) before going live.

### Gate D — Spend Authorization (Publish)

- **When:** Only in W05 (publish & enable).
- **What the human approves:** Flipping status from `paused` to `enabled` for a
  specific campaign, with a specific daily budget.
- **Approval format:** `approve publish <campaign-name> budget <number>`. The
  `<number>` must exactly equal the campaign's current daily budget. Free-form
  `yes` is not accepted. `approve all` is not accepted.
- **Why it exists:** This is the only place where the system starts spending
  money. The retyped budget is a "are you really paying attention?" check.

### Gate E — Budget Change

- **When:** Any skill that proposes changing a daily budget on an *enabled*
  campaign (W11 proposes; a future skill may execute).
- **What the human approves:** The new budget number for a specific campaign.
- **Approval format:** `approve budget <campaign-name> <new-number>` where
  `<new-number>` is the proposed value retyped.
- **Why it exists:** Budget changes are spend changes. Same care as Gate D.

### Gate F — Bidding-Strategy Change

- **When:** Any skill that proposes changing bidding strategy on a campaign.
- **What the human approves:** The new strategy + (if applicable) target value.
- **Approval format:** `approve bidding <campaign-name> <strategy>[
  <target-value>]`.
- **Why it exists:** Bidding changes can drastically alter spend velocity even
  without a budget change.

### Gate G — Targeting Expansion

- **When:** Any change that materially *expands* delivery (removing a location
  restriction, removing a negative keyword list, broadening match types,
  enabling search partners, enabling Display Network on a Search campaign).
- **What the human approves:** The specific expansion, described in plain
  language.
- **Approval format:** `approve expand <campaign-name>: <one-line
  description>`.
- **Why it exists:** "Expand reach" is how Google Ads spend gets out of hand
  fastest, especially on Performance Max and Search-with-partners.

### Gate H — Denylist Override

- **When:** The operator asks the agent to do something on the denylist (see
  `browser-use-safety.md`).
- **Approval format:** Two-step. First message:
  `override denylist: <action> on <entity>`. Second message: `confirm
  override`.
- **Why it exists:** Make it inconvenient enough that it cannot happen by
  accident.

### Gate I — Stop / Resume

- **When:** Any time the agent halts on a stop condition.
- **What the human approves:** Either `resume` (after fixing the cause) or
  `abort` (close out the run, write artifacts, exit).
- **Why it exists:** The agent should not silently retry after a halt.

## Gate Matrix by Workflow

| Workflow | A | B | C | D | E | F | G |
|---|---|---|---|---|---|---|---|
| W01 audit | ✔ | — | — | — | — | — | — |
| W02 conv. audit | ✔ | — | — | — | — | — | — |
| W03 keyword research | ✔ | — | — | — | — | — | — |
| W04 draft Search | ✔ | ✔ | — | — | — | — | — |
| W05 publish | (req) | (req) | ✔ | ✔ | — | — | — |
| W06 draft PMax | ✔ | ✔ | — | — | — | — | — |
| W07 draft Demand Gen | ✔ | ✔ | — | — | — | — | — |
| W08 draft Display | ✔ | ✔ | — | — | — | — | — |
| W09 draft Video | ✔ | ✔ | — | — | — | — | — |
| W10 neg-kw review | ✔ | — | — | — | — | — | — |
| W11 budget proposal | ✔ | — | — | — | (propose) | — | — |
| W12 weekly digest | ✔ | — | — | — | — | — | — |
| W13 pre-launch QA | (req) | (req) | ✔ | — | — | — | — |

`(req)` = the gate must already be CLOSED from an earlier workflow.

## What an Approval Request Looks Like

The agent's approval requests are templated. Example for Gate D:

```text
==== Gate D — Spend Authorization ====
Customer: Acme Co (123-456-7890)
Campaign: [draft] Acme — Brand Search
Daily budget: $25.00
Bidding: Maximize Conversions
Networks: Search only (search partners OFF)
Geo: United States; Language: English
Conversion goal: Lead form submission
Final URL: https://acme.example.com/contact

To approve, reply with exactly:
    approve publish Acme — Brand Search budget 25

Anything else, including "yes" or "approve all", will be treated as denial.
======================================
```

The agent attaches `screenshots/before-gate-d.png` to the request.

## What Approval is *Not*

- Approval is not a permission for the next action. It is permission for
  *this* action, on *this* entity, with *these* parameters.
- Approval does not carry across runs. A new run re-requests.
- Approval does not unlock the denylist. Gate H is the only way.

## Audit Trail

Every gate event is appended to `artifacts/<run>/change-log.md` with:

- Timestamp (ISO 8601, local + UTC).
- Gate ID and entity.
- The operator's literal approval string.
- The pre-action and post-action UI confirmation text (e.g. Google Ads' own
  "Campaign saved" or "Status changed" message).
- A pointer to the before/after screenshots.

The change log is the source of truth for what the agent did on the operator's
behalf.
