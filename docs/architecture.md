# Architecture

## Purpose

Google-Ads-Setup-Codex-Skill is a reusable **Codex skill library** plus a lightweight
**browser-use workflow model** for safely auditing, planning, drafting, and
reviewing Google Ads setup workflows. The skills guide a browser-use agent
through the Google Ads web UI only where browser steps are explicitly part of
the workflow, while a human operator approves every action that has financial,
account, or delivery impact.

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
  - Codex loads a skill from `skills/<skill-name>/SKILL.md`.
  - Planning skills produce local Markdown plans without browser automation.
  - Browser-use skills describe safe UI workflows and stop points for a future
    browser-use harness.
- **Core modules:**
  - `skills/<skill-name>/` — one folder per skill: `SKILL.md` plus
    `references/preflight.md` and an output template.
  - `checklists/` — human-facing checklist for each workflow.
  - `artifacts/` — per-run outputs (audit reports, draft plans, change logs)
    written by the agent and reviewed by the human.
- **External dependencies:**
  - Browser-use agent (Claude/Codex-driven), already authenticated to Google Ads
    only during real operator-approved runs.
  - Google Ads web UI (`ads.google.com`) for browser-use workflows.
  - Optional: Google Ads Editor exports (CSV) as a read-only data source.
- **Data stores:**
  - `artifacts/<YYYY-MM-DD>-<run-id>/` — append-only run artifacts.
  - `state/` — small JSON files capturing the last-known account snapshot.
- **Background jobs:** none. Every run is operator-initiated.

## Boundaries

- **In scope:**
  - Read-only audits of Google Ads accounts.
  - Planning Search and Performance Max campaigns.
  - Guiding draft setup for Search and Performance Max campaigns with hard stop
    points before final save, publish, enable, or launch.
  - Negative keyword proposals and approved additions.
  - Budget and bidding reviews as read-only/planning artifacts.
  - Final launch review with explicit campaign and budget confirmation.
  - Producing structured plans, checklists, and diffs for the human.
  - Encoding approval gates that the agent must respect.
- **Out of scope:**
  - Programmatic spending or bid changes without human approval.
  - Google Ads API integration (v1; we intentionally use skills and browser-use
    instructions to keep the human in the loop and avoid API credentials).
  - Multi-account MCC bulk operations.
  - Conversion tracking implementation in the customer's website/app.
  - Creative production (images, video).
  - Autonomous browser automation from this repository.

## Data Flow

```text
Operator chooses skill
        |
        v
Skill loaded by Codex  -->  planning-only OR browser-use instructions
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
Final launch review (only on exact approval)  -->  change log written
```

The agent never skips ahead. Each phase has an explicit stop point until the
human responds.

## Repository Layout

```text
Google-Ads-Setup-Codex-Skill/
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
│       ├── references/           # cheat sheets, screenshots, glossaries
│       │   ├── preflight.md
│       │   └── *template.md
├── checklists/
│   └── google-ads-*.md           # human-facing workflow checklists
├── prompts/
│   └── initial-brief.md
├── scripts/
│   ├── check.sh
│   ├── dev.sh
│   ├── session-start.sh
│   └── session-close.sh
├── artifacts/                    # gitignored (run outputs)
├── state/                        # gitignored (last-known snapshots)
└── tasks/
    └── todo.md
```

## Operational Notes

- **Configuration:** Per-run inputs are captured in the skill output templates
  and any future harness config.
- **Local development:** Run skills against the *Google Ads test account* (an
  unfunded account or a manager-account child with $0 budget caps) for
  end-to-end testing without spending. See
  [google-ads-workflows.md](google-ads-workflows.md#testing-without-spending).
- **Testing:** The current v1 check is static skill lint via
  `bash scripts/check.sh --apply`. Future browser-use harness work can add
  recorded dry-run simulation and live test-account walk-throughs.
- **Deployment:** None. This is a local-first skill library.
- **Observability:** Per-run artifacts under `artifacts/` are the audit trail.

## Risks

- **Google Ads UI changes break selectors.** Mitigation: skills use
  semantic/text selectors and a screenshot diff step, not brittle XPath.
- **Agent acts beyond the approval gate.** Mitigation: hard stops encoded in
  `docs/browser-use-safety.md`, each skill, and per-skill checklists; see
  [approval-gates.md](approval-gates.md).
- **Operator approves without reading.** Mitigation: approval prompts must
  surface the *exact* change (campaign name, budget number, status transition)
  and require the operator to retype critical values (e.g. budget) for
  destructive or spend-enabling actions.
- **Drafts accidentally publish.** Mitigation: every draft is created in
  *paused* state; status transitions are a separate, gated step.
