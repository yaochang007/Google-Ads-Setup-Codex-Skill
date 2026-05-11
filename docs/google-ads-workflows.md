# Google Ads Workflows

This doc describes the v1 skill library workflows, required inputs, artifact
outputs, and approval gates.

## Workflow Catalog

| ID | Skill | Read/Write | V1 role |
|---|---|---|---|
| W01 | `google-ads-account-audit` | R | Account snapshot and readiness audit |
| W02 | `google-ads-conversion-tracking-audit` | R | Conversion, GA4/GTM/linking, tag, and activity audit |
| W03 | `google-ads-reporting-audit` | R | Performance, spend, search term, asset, recommendation, and health review |
| W04 | `google-ads-search-campaign-planning` | Local plan only | Search campaign planning packet |
| W05 | `google-ads-search-campaign-draft-setup` | Browser-use draft guidance | Search draft setup, stopped before final save/publish/launch |
| W06 | `google-ads-performance-max-planning` | Local plan only | Performance Max planning packet |
| W07 | `google-ads-performance-max-draft-setup` | Browser-use draft guidance | PMax draft setup, stopped before final save/publish/launch |
| W08 | `google-ads-negative-keywords` | R + approved narrow write | Search term review and approved negative keyword addition |
| W09 | `google-ads-budget-and-bidding-review` | R + proposal | Budget and bidding review; no execution |
| W10 | `google-ads-final-launch-review` | R + optional exact-approved launch | Final QA and launch authorization review |

## V1 Skill Composition

Typical Search flow:

```text
W01 account audit
  -> W02 conversion tracking audit
  -> W03 reporting audit, if existing data matters
  -> W04 Search planning
  -> W05 Search draft setup
  -> W10 final launch review
```

Typical Performance Max flow:

```text
W01 account audit
  -> W02 conversion tracking audit
  -> W06 Performance Max planning
  -> W07 Performance Max draft setup
  -> W10 final launch review
```

Negative keyword and budget/bidding reviews can run after an account/reporting
audit and produce proposals for separate human approval.

## Required Inputs by Workflow

### W01 - Account audit

- Target account name.
- Customer ID, if known.
- Audit depth: `summary` or `full`.

### W02 - Conversion tracking audit

- Target account name and customer ID, if known.
- Expected conversion actions or business goals.
- Lookback window, default 30 days.

### W03 - Reporting audit

- Target account name and customer ID, if known.
- Date range and comparison range.
- KPI focus: conversions, cost, CPA, conversion value, ROAS, search terms,
  assets, recommendations, or account health.

### W04 - Search campaign planning

- Business summary, offer, campaign goal, conversion goal.
- Locations, languages, landing pages.
- Seed keywords, negative keyword seeds, competitor terms if relevant.
- Budget cap, bidding preference, brand/compliance constraints.

### W05 - Search campaign draft setup

- Target account name and customer ID.
- Approved Search plan and Gate B approval.
- Campaign name, budget cap, bidding, locations, languages, conversion goal,
  ad groups, keywords, negatives, ads, final URLs, and tracking.

### W06 - Performance Max planning

- Business goal and primary conversion goal.
- Conversion tracking readiness.
- Budget cap, bidding objective, locations, languages.
- Asset groups, assets, audience signals, final URLs, final URL expansion,
  brand exclusions, Merchant Center/feed readiness if ecommerce applies.

### W07 - Performance Max draft setup

- Target account name and customer ID.
- Approved PMax plan and Gate B approval.
- Campaign settings, asset groups, assets, audience signals, final URL settings,
  URL exclusions, brand exclusions, Merchant Center/feed status, and tracking.

### W08 - Negative keywords

- Account/campaign/ad group/shared-list scope.
- Date range and threshold.
- Business-safe terms that must remain eligible.
- Proposal-only or exact approval for addition.

### W09 - Budget and bidding review

- Campaign scope and date range.
- KPI focus and business constraints.
- Current/proposed budget and bidding ideas, if any.

### W10 - Final launch review

- Target account name and customer ID.
- Draft campaign name and type.
- Approved plan and draft setup summary.
- Expected budget, bidding, conversion goal, locations, languages, assets,
  landing pages, tracking, and billing readiness.
- Gate C sign-off and Gate D exact launch authorization if execution is
  requested.

## Approval Gate Mapping

| Workflow | Required gates |
|---|---|
| W01 account audit | Gate A |
| W02 conversion tracking audit | Gate A |
| W03 reporting audit | Gate A |
| W04 Search planning | Gate B before draft setup |
| W05 Search draft setup | Gate B; stops before Gate D |
| W06 PMax planning | Gate B before draft setup |
| W07 PMax draft setup | Gate B; Gate G for expansion changes; stops before Gate D |
| W08 negative keywords | Gate A for proposal; Gate J for additions |
| W09 budget/bidding review | Gate A; future Gate E/F for execution |
| W10 final launch review | Gate C; Gate D for exact launch execution |

## Testing Without Spending

### Layer 1 - Skill static lint

Run:

```sh
bash scripts/check.sh --apply
```

The check verifies:

- Required project files exist.
- Every skill folder has `SKILL.md`.
- Every `SKILL.md` has `name` and `description` frontmatter.
- Every skill has required sections for use, inputs, preflight, workflow,
  approval gates, approval safety, stop conditions, and output format.
- Every skill references browser-use safety rules.
- Every read-only audit skill explicitly says read-only.
- Skills do not mention publish/enable/launch without approval language.
- Every skill has `references/preflight.md` and an output template.

### Layer 2 - Recorded simulation

Future harness work can run skills against recorded Google Ads screenshots or
fixtures. No real account login is needed for this layer.

### Layer 3 - Live test account

Live browser-use tests should use an unfunded or tightly capped test account.
Draft setup runs stop before final save, publish, enable, or launch. Launch
review requires Gate C and Gate D with exact campaign and budget confirmation.

## Artifact Outputs by Workflow

| Workflow | Primary artifact |
|---|---|
| W01 | `audit-summary.md` |
| W02 | `conversion-tracking-audit.md` |
| W03 | `reporting-audit.md` |
| W04 | `search-campaign-plan.md` |
| W05 | `search-draft-summary.md` |
| W06 | `performance-max-plan.md` |
| W07 | `performance-max-draft-summary.md` |
| W08 | `negative-keyword-proposal.md` |
| W09 | `budget-bidding-review.md` |
| W10 | `final-launch-review.md` |
