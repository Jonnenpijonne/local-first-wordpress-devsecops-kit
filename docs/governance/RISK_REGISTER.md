# Risk Register

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Scope creep | Stack becomes too complex | Add services only when needed |
| Production data leakage | GDPR / confidentiality risk | No production data in dev |
| Secrets in repo | Credential compromise | Ignore local files and run scans |
| AI context leakage | Sensitive information exposure | Use AI boundary model |
| Docker misconfiguration | Accidental network exposure | Bind ports to localhost |
| Tenant boundary mistakes | Data isolation failure | Tenant isolation first |
| Unowned scripts | Operational risk | Document scripts and ownership |
| Environment drift | Onboarding failure | Docker Compose and scripts |
| No evidence trail | Audit weakness | Evidence templates |
