# Pre-Production Readiness Baseline — 2026-06-15

## Scope

This report records the pre-production readiness baseline for the `local-first-wordpress-devsecops-kit` repository.

Repository:

```text
Jonnenpijonne/local-first-wordpress-devsecops-kit
```

This is a portfolio and local-development pre-production readiness baseline. It is not a claim of production hosting readiness or enterprise managed platform ownership.

## Baseline status

```text
Status: PRE-PRODUCTION READY BASELINE
Date: 2026-06-15
Scope: local-first WordPress/PHP web platform operations baseline
```

## What is included

The repository now contains evidence and documentation for:

```text
repeatable Docker Compose local web stack
WordPress/PHP application runtime
MariaDB database dependency
Mailpit local email capture
localhost-bound service exposure
local environment bootstrap through .env.example -> .env
web platform operations evidence pack
local Docker Compose validation evidence
privacy-safe development boundaries
AI boundary and governance thinking
runbook and recoverability orientation
```

## Runtime validation summary

Local validation confirmed:

```text
Docker Desktop: 4.77.0
Docker Engine: 29.5.3
Docker Compose: v5.1.4
WSL2 Ubuntu backend: OK
Git: 2.54.0.windows.1
```

Compose stack validation confirmed:

```text
WordPress container: running
MariaDB container: healthy
Mailpit container: healthy
WordPress admin: reachable at localhost:8080
Mailpit UI: reachable at localhost:8025
MariaDB: internal Compose network only
```

## Evidence files

Key evidence file:

```text
docs/evidence/LOCAL_DOCKER_COMPOSE_VALIDATION_2026-06-15.md
```

Key operations note:

```text
docs/ops/WEB_PLATFORM_OPERATIONS_EVIDENCE_PACK.md
```

## Pre-production meaning

In this repository, pre-production readiness means:

```text
local stack can be started
runtime dependencies are defined
services can be inspected
health/status can be validated
a browser-reachable application exists
mail testing is locally captured
rollback/update/incident thinking is documented
evidence is recorded
scope and limitations are explicit
```

It does not mean:

```text
production WordPress hardening
production Moodle administration
Kubernetes operation
cloud deployment ownership
managed hosting product readiness
enterprise platform ownership
```

## Operational readiness checklist

Validated:

```text
Docker installed and working
WSL2 backend installed and working
Ubuntu WSL2 distribution available
Docker Compose command works
.env created from .env.example
images pulled successfully after transient TLS timeout recovery
stack started with docker compose up -d
containers inspected with docker compose ps
WordPress admin opened in browser
Mailpit exposed locally
MariaDB healthy
```

Recommended before future external demo:

```text
run docker compose ps
open localhost:8080
open localhost:8025
confirm git status --short
avoid showing secrets or local credentials on screen
keep .env uncommitted
```

## Security and governance notes

Positive controls and boundaries:

```text
localhost-bound ports
MariaDB not directly exposed to host port
Mailpit prevents real outbound test email behavior
.env.example used as versioned model
local .env used as runtime configuration
Docker Compose network isolates service communication
local-first model avoids accidental public exposure
```

## Portfolio interpretation

This baseline demonstrates practical ability to:

```text
prepare a Windows + WSL2 + Docker development environment
troubleshoot virtualization and backend issues
run a PHP/web application stack locally
validate database-backed application behavior
use Docker Compose for repeatable environment orchestration
inspect container health and service exposure
record operational evidence
connect development tooling to governance and recoverability thinking
```

## Interview framing

English:

```text
This repository demonstrates a pre-production local web platform baseline. I validated a Docker Compose stack with WordPress, MariaDB and Mailpit on Windows using WSL2 and Docker Desktop, resolved setup and image pull issues, and documented the runtime evidence, health checks, rollback thinking and operational boundaries.
```

Finnish:

```text
Tämä repo näyttää pre-production-tasoisen paikallisen web-platform-baselinen. Validoin Docker Compose -stackin, jossa on WordPress, MariaDB ja Mailpit, Windowsin, WSL2:n ja Docker Desktopin päällä. Ratkaisin ympäristön käyttöönotto- ja image pull -ongelmat sekä dokumentoin runtime-evidencen, healthcheckit, rollback-ajattelun ja operatiiviset rajat.
```

## Suggested tag

Recommended annotated tag after this report is present on `main`:

```text
v0.1.0-pre-production-readiness
```

Suggested tag meaning:

```text
Local-first WordPress/PHP web platform baseline validated, documented and ready for portfolio/demo-level pre-production presentation.
```
