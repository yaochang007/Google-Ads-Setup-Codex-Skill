# Audit Output Template

Use this template for the read-only account audit report. Keep observations
factual. Mark unknown or hidden values as `unknown` or `not visible`.

```md
# Google Ads Account Audit

Date:
Auditor:
Skill: google-ads-account-audit
Mode: read-only

## Account Identity

- Account name:
- Customer ID:
- User role/access level:
- Manager/direct account view:
- Account-level banners or alerts:

## Billing Readiness

- Billing status observed:
- Payment method/profile visibility:
- Billing warnings:
- Readiness assessment: ready | limited | blocked | unknown
- Notes:

## Campaign Summary

| Campaign | Type | Status | Visible warnings | Notes |
|---|---|---|---|---|
|  |  |  |  |  |

Summary:

- Total visible campaigns:
- Enabled:
- Paused:
- Removed:
- Limited or constrained:
- Other statuses:

## Conversion Tracking Status

| Conversion action | Source/type | Status | Recent activity visible | Notes |
|---|---|---|---|---|
|  |  |  |  |  |

Summary:

- Conversion tracking appears configured: yes | no | partial | unknown
- Visible issues:
- Missing or unclear items:

## Linked Accounts

| Linked product/account | Status | Notes |
|---|---|---|
|  |  |  |

Summary:

- Analytics links:
- Merchant Center links:
- YouTube links:
- Search Console links:
- Manager-account links:
- Other links:

## Account Access Summary

| User or manager | Role/access level | Status | Notes |
|---|---|---|---|
|  |  |  |  |

Summary:

- Visible users:
- Admin users:
- Standard users:
- Read-only/email-only users:
- Pending invites:
- Manager access:

## Recommendations

| Recommendation area | Recommendation observed | Risk if applied blindly | Notes |
|---|---|---|---|
|  |  |  |  |

Auto-apply status:

## Risks/Issues

- 

## Recommended Next Steps

- 

## Gate A - Audit Review

Human review required. Reply with `approve audit` or `audit looks good` only if
this report reflects the current account state.
```
