# Final Launch Review Preflight

Record:

- Account name:
- Customer ID:
- User role/access level:
- Campaign name:
- Campaign type:
- Expected budget:
- Expected bidding:
- Approved plan path:
- Draft setup summary path:
- Billing readiness source:
- Conversion tracking readiness source:
- Mode: review-only | launch execution requested

Default to review-only. Required launch approval:

```text
approve publish <campaign-name> budget <number>
```

The number must exactly equal the visible campaign daily budget. Stop if Gate C
QA sign-off is missing or the launch approval phrase is absent/mismatched.
