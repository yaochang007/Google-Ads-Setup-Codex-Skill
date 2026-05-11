# Architecture

## Purpose

Google Ads Setup is a reusable **Codex skill library** plus a **browser-use
workflow harness** for safely setting up different Google Ads campaign types.
The skills guide a browser-use agent (a Claude/Codex-driven browser automation
agent) through the Google Ads web UI, while a human operator approves every
action that has financial, account, or delivery impact.

The project is *not* a Google Ads automation tool. It is an assistant for an
operator who is already authorized to manage a Google Ads account.

## Audience

- Primary user: a marketer or growth engineer who already manages the target
  Google Ads account and is logged in to the browser-use session.
- Secondary user: a Codex/Claude agent that loads a skill and drives the browser
  on the operator's behalf.

## Principles

- **Money safety first.** Any action that can spend money, change spend, change
  delivery, or change account access requires explicit human approval.
- **Read-only audit before write.** Every workflow opens with a read-only audit
  pass that captures the current state before proposing changes.
- **Draft, then publish.** Setup is split into a *draft / planning* phase and a
  *publish / enable* phase. The agent may build drafts; only the human flips
  campaigns from paused to enabled.
- **Skills are written for the agent, checklists are written for the human.**
  Every workflow produces a human-readable checklist artifact in addition to
  driving the browser.
- **One skill, one workflow.** Skills are small, composable, and each owns one
  workflow (audit, keyword research, campaign draft, etc.).
- **Stack-thin.** Skills are Markdown + YAML frontmatter. The browser-use
  harness is a thin wrapper; no heavy framework code.

## System Overview

- **Entry points:**
  - Codex CLI invokes a skill (e.g. `skills/audit-account/SKILL.md`).
  - A wrapper script `scripts/run-skill.sh` launches a browser-use session with
    the selected skill bundle attached.
- **Core modules:**
  - `skills/<skill-name>/` — one folder per skill: `SKILL.md`, `checklist.md`,
    optional `references/`, optional `selectors.md`.
  - `lib/browser-use/` — shared instructions, allowlists, denylists, and safety
    rails for the browser-use agent.
  - `lib/google-ads/` — shared reference material about Google Ads concepts,
    field meanings, and common pitfalls.
  - `artifacts/` — per-run outputs (audit reports, draft plans, change logs)
    written by the agent and reviewed by the human.
- **External dependencies:**
  - Browser-use agent (Claude/Codex-driven), already authenticated to Google Ads.
  - Google Ads web UI (`ads.google.com`).
  - Optional: Google Ads Editor exports (CSV) as a read-only data source.
- **Data stores:**
  - `artifacts/<YYYY-MM-DD>-<run-id>/` — append-only run artifacts.
  - `state/` — small JSON files capturing the last-known account snapshot.
- **Background jobs:** none. Every run is operator-initiated.

## Boundaries

- **In scope:**
  - Read-only audits of Google Ads accounts.
  - Drafting Search, Performance Max, Demand Gen, Display, and Video campaigns
    in *paused* state.
  - Producing structured plans, checklists, and diffs for the human.
  - Encoding approval gates that the agent must respect.
- **Out of scope:**
  - Programmatic spending or bid changes without human approval.
  - Google Ads API integration (v1; we intentionally use the UI to keep the
    human in the loop and to avoid API-credential management).
  - Multi-account MCC bulk operations.
  - Conversion tracking implementation in the customer's website/app.
  - Creative production (copy, images, video).

## Data Flow

```text
Operator chooses skill
        |
        v
Skill loaded by Codex  -->  browser-use harness opens Google Ads UI
        |
        v
Read-only audit  -->  audit artifact written to artifacts/
        |
        v
Draft / plan phase  -->  draft artifact + checklist written
        |
        v
Human reviews artifacts and grants/denies approval gates
        |
        v
Publish phase (only on explicit approval)  -->  change log written
```

The agent never skips ahead. Each phase has an explicit stop point until the
human responds.

## Repository Layout

```text
google-ads-setup/
├── AGENTS.md
├── README.md
├── docs/
│   ├── architecture.md           # this file
│   ├── decisions.md
│   ├── browser-use-safety.md
│   ├── google-ads-workflows.md
│   ├── approval-gates.md
│   └── superpowers/plans/        # implementation plans (when used)
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md              # agent-facing skill spec
│       ├── checklist.md          # human-facing checklist
│       ├── inputs.schema.json    # required inputs
│       ├── references/           # cheat sheets, screenshots, glossaries
│       └── selectors.md          # known stable UI selectors (best-effort)
├── lib/
│   ├── browser-use/
│   │   ├── safety-rules.md
│   │   ├── allowlist.md
│   │   ├── denylist.md
│   │   └── stop-conditions.md
│   └── google-ads/
│       ├── glossary.md
│       └── pitfalls.md
├── prompts/
│   └── initial-brief.md
├── scripts/
│   ├── check.sh
│   ├── dev.sh
│   ├── run-skill.sh              # to be added
│   ├── session-start.sh
│   └── session-close.sh
├── artifacts/                    # gitignored (run outputs)
├── state/                        # gitignored (last-known snapshots)
└── tasks/
    └── todo.md
```

## Operational Notes

- **Configuration:** Per-run config lives in a small YAML file passed to
  `run-skill.sh` (account id label, dry-run flag, approval mode).
- **Local development:** Run skills against the *Google Ads test account* (an
  unfunded account or a manager-account child with $0 budget caps) for
  end-to-end testing without spending. See
  [google-ads-workflows.md](google-ads-workflows.md#testing-without-spending).
- **Testing:** Three layers, described in `google-ads-workflows.md`: skill
  static lint, dry-run simulation, and live test-account walk-through.
- **Deployment:** None. This is a local-first skill library.
- **Observability:** Per-run artifacts under `artifacts/` are the audit trail.

## Risks

- **Google Ads UI changes break selectors.** Mitigation: skills use
  semantic/text selectors and a screenshot diff step, not brittle XPath.
- **Agent acts beyond the approval gate.** Mitigation: hard stops encoded in
  `lib/browser-use/safety-rules.md` and per-skill checklists; see
  [approval-gates.md](approval-gates.md).
- **Operator approves without reading.** Mitigation: approval prompts must
  surface the *exact* change (campaign name, budget number, status transition)
  and require the operator to retype critical values (e.g. budget) for
  destructive or spend-enabling actions.
- **Drafts accidentally publish.** Mitigation: every draft is created in
  *paused* state; status transitions are a separate, gated step.
