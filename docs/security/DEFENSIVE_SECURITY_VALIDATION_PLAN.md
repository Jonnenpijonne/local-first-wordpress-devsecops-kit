# Defensive Security Validation Plan

## Purpose

This document defines a defensive security validation plan for the local-first WordPress DevSecOps kit.

The goal is not to perform offensive testing against external targets. The goal is to validate the local WordPress/PHP/Docker Compose environment in a controlled way, document findings and use those findings to guide future hardening.

## Scope

In scope:

```text
local WordPress/PHP application running at http://localhost:8080
local Mailpit UI running at http://localhost:8025
MariaDB service inside the Docker Compose network
Docker Compose configuration
local development scripts
repository-level documentation and evidence files
localhost-bound port exposure
container runtime behavior
```

Out of scope:

```text
external websites
third-party systems
production environments
brute force testing
destructive scanning
credential attacks
public internet scanning
social engineering
denial-of-service testing
malware or exploit payload execution
```

## Validation principle

This is a defensive validation phase.

The intended flow is:

```text
observe
check
map risk
record evidence
propose hardening
change only after review
```

Hardening should be based on evidence, not guesswork.

## Allowed checks

Allowed local checks:

```text
docker compose config
docker compose ps
docker compose logs --tail=100 wordpress
docker compose logs --tail=100 db
docker compose logs --tail=100 mailpit
docker compose exec wordpress bash
docker compose exec db mariadb-admin ping -h localhost -uroot -proot
curl -I http://localhost:8080
curl -I http://localhost:8025
lightweight browser-based Lighthouse checks
lightweight OWASP/ZAP baseline check against localhost only
manual review of docker-compose.yml
manual review of .env.example and .gitignore
manual review of scripts and evidence files
```

Allowed repository checks:

```text
secret-pattern scan with scripts/scan-secrets.sh
review of ignored runtime paths
review of generated WordPress files not committed to Git
review of local evidence completeness
review of README claims against actual repository state
```

## Not allowed checks

The following are not allowed in this validation phase:

```text
active exploitation
credential guessing
password spraying
brute force login testing
payload upload testing against anything except controlled local dummy data
scanning external networks
scanning public IP addresses
attempting privilege escalation with exploit code
destructive database operations
removing Docker volumes unless explicitly testing reset behavior
deleting local data without a reset plan
```

## OWASP-style local web checks

The local WordPress environment may be checked for common web-application concerns at a high level.

Examples:

```text
is the application reachable only through localhost?
are admin pages reachable in the expected local context?
are error pages leaking unnecessary information?
are logs readable for troubleshooting?
are test emails captured locally rather than sent externally?
are plugin/theme changes visible in wp-content?
are sensitive files accidentally exposed or committed?
```

Recommended tooling:

```text
browser developer tools
Lighthouse local report
OWASP ZAP baseline scan against http://localhost:8080 only
manual review
```

The first ZAP phase should be passive or baseline-oriented. Active scanning should only be considered later, with a clear local-only scope and disposable test data.

## Docker and container hardening review

Review current controls:

```text
WordPress port bound to 127.0.0.1:8080
Mailpit port bound to 127.0.0.1:8025
MariaDB not directly published to host
services isolated in Docker Compose bridge network
MariaDB healthcheck configured
.env ignored from Git
runtime WordPress files ignored or left untracked
```

Possible future hardening candidates:

```text
pin image versions instead of using latest
add lightweight application healthchecks where practical
add no-new-privileges where compatible
review cap_drop options where compatible
document container user expectations
separate local-only secrets from examples
improve secret scanning with a dedicated tool such as Gitleaks
add CI check for docker compose config
```

Hardening candidates must be tested before adoption. WordPress may require write access to local runtime paths, so read-only or capability-reduction changes must not be applied blindly.

## MITRE ATT&CK mapping

MITRE ATT&CK is used here as a defensive mapping model, not as a pentest method.

Possible mapping:

```text
Initial Access      exposed web admin or misconfigured local service exposure
Execution           malicious plugin/theme code execution risk
Persistence         modified plugin/theme or wp-content persistence
Privilege Escal.    overly privileged container or filesystem permission issue
Defense Evasion     weak logging or missing audit evidence
Credential Access   .env leakage, wp-config.php exposure, database credentials
Discovery           service enumeration, open ports, WordPress version discovery
Lateral Movement    database exposure or unnecessary network reachability
Collection          wp-content uploads, database dumps, local test data
Exfiltration        accidental secret/data leakage through Git or external AI tools
Impact              broken local environment, corrupted development data, unsafe reset
```

The purpose of this mapping is to turn technical observations into understandable defensive controls.

## Evidence to collect

Recommended evidence files:

```text
docs/evidence/LOCAL_VALIDATION_2026-06-15.md
docs/evidence/LIGHTHOUSE_AUDIT_2026-06-15.md
docs/ops/DOCKER_COMPOSE_LIFECYCLE_AUDIT.md
future: docs/evidence/ZAP_BASELINE_YYYY-MM-DD.md
future: docs/evidence/CONTAINER_HARDENING_REVIEW_YYYY-MM-DD.md
```

Evidence should record:

```text
date
environment
commands used
scope
result
findings
false positives
follow-up actions
what was not tested
```

## Findings classification

Suggested finding classes:

```text
Info        observation with no immediate risk
Low         improvement candidate with limited local impact
Medium      issue that could affect confidentiality, integrity or repeatability
High        issue that could expose secrets/data or break isolation assumptions
Critical    production-like exposure, secret leak or destructive risk
```

For this local-first repository, most findings should be expected to be Info or Low unless secrets, public exposure or data leakage are found.

## Change control

Any hardening change should follow this flow:

```text
1. Document finding.
2. Classify risk.
3. Identify affected file.
4. Define expected behavior after change.
5. Make one small change.
6. Validate locally.
7. Record evidence.
8. Commit with clear message.
9. Avoid broad refactors during security hardening.
```

Examples of controlled future commits:

```text
Add Docker Compose config validation workflow
Pin local development container image versions
Add container hardening review evidence
Add ZAP baseline evidence for local WordPress stack
Document secret scanning limitations
```

## Safe interview framing

English:

```text
The next planned phase is defensive security validation: a local-only OWASP/ZAP baseline check, Docker hardening review and MITRE ATT&CK mapping. The goal is not offensive pentesting, but controlled validation that turns findings into documented hardening candidates.
```

Finnish:

```text
Seuraava suunniteltu vaihe on defensive security validation: paikallinen OWASP/ZAP-kevyt tarkistus, Docker-kovennusten katselmointi ja MITRE ATT&CK -mapping. Tarkoitus ei ole hyökkäävä pentest, vaan hallittu validointi, jossa löydökset muutetaan dokumentoiduiksi kovennuskandidaateiksi.
```

## Final note

This plan intentionally avoids unnecessary aggression and unnecessary complexity.

The target is a local development environment. Therefore the correct maturity signal is not aggressive scanning, but clear scope, safe tooling, evidence discipline, conservative interpretation and controlled hardening.
