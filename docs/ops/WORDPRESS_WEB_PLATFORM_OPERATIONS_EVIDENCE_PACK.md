# WordPress Web Platform Operations Evidence Pack

## Purpose

This note connects the local-first WordPress DevSecOps baseline to practical web platform operations work relevant to PHP-based customer environments, including WordPress-, Moodle- or other database-backed web application stacks.

It is not a claim of senior production platform ownership. It is a focused portfolio bridge showing how PHP-based web environments can be maintained, updated, checked, restored and explained in a controlled way.

## Practical fit

Web platform operations work may involve:

```text
customer web environments
PHP-style application stacks
database-backed services
updates and maintenance windows
incidents and troubleshooting
monitoring and alerting
Linux/web-server thinking
Docker/container familiarity
customer communication
documentation and repeatability
```

This repository demonstrates the local-first side of that operating model:

```text
Docker Compose baseline
WordPress/PHP application container
MariaDB dependency
Mailpit local mail capture
localhost-bound ports
healthcheck thinking
runbooks
privacy-safe development rules
AI boundary model
evidence templates
```

## Web platform operations evidence pack

A lightweight web platform operations evidence pack should answer these questions:

```text
Can the environment be started repeatably?
Can the database dependency be checked?
Can the application be reached locally?
Can mail behavior be tested safely?
Can the environment be stopped safely?
Can the environment be reset intentionally?
Can the update path be documented?
Can rollback be described before change?
Can incident triage be written down clearly?
Can customer communication be kept calm and useful?
Can evidence be recorded after checks?
```

## Local environment checks

Expected local startup path:

```bash
cp .env.example .env
docker compose up -d
docker compose ps
```

Expected service endpoints:

```text
WordPress: http://localhost:8080
Mailpit:   http://localhost:8025
```

The localhost-bound port model is intentional. It reduces accidental exposure outside the local workstation and supports safer development behavior.

## Healthcheck focus

A practical web platform operator should be able to check:

```text
Are containers running?
Is the database healthy?
Is the application reachable?
Are local mail events visible in Mailpit?
Are logs readable?
Are configured ports bound only to localhost?
Is the environment using expected environment variables?
```

Example checks:

```bash
docker compose ps
docker compose logs --tail=100 wordpress
docker compose logs --tail=100 db
docker compose config
```

## Update checklist

Before update:

```text
1. Identify the component being updated.
2. Check whether the update affects application, database, plugin/theme, configuration or container image.
3. Record current known-good state.
4. Confirm backup or rollback path.
5. Define maintenance window if customer-facing.
6. Define smoke test after update.
7. Define go/no-go criteria.
```

During update:

```text
1. Apply change in a controlled way.
2. Watch logs.
3. Check application reachability.
4. Check database connectivity.
5. Check admin/login flow if relevant.
6. Record commands and result.
```

After update:

```text
1. Confirm service status.
2. Confirm smoke test result.
3. Confirm whether rollback was needed.
4. Record evidence.
5. Communicate result clearly.
```

## Rollback checklist

Rollback should be planned before the change, not invented during an incident.

Minimum rollback thinking:

```text
What changed?
What is the last known-good state?
What data could be affected?
Can configuration be reverted?
Can the previous image/package/version be restored?
Is database rollback needed?
Who needs to be informed?
What evidence proves rollback succeeded?
```

## Incident triage examples

### Application down

Check:

```bash
docker compose ps
docker compose logs --tail=100 wordpress
docker compose logs --tail=100 db
```

Questions:

```text
Is the application container running?
Is the database running?
Did the application lose DB connectivity?
Was there a recent update?
Is this local-only or customer-facing?
```

### Database down

Check:

```bash
docker compose ps
docker compose logs --tail=100 db
```

Questions:

```text
Is the database container unhealthy?
Is the volume available?
Was configuration changed?
Was the environment reset intentionally?
```

### Slow site

Check:

```text
recent changes
logs
container resource pressure
database errors
plugin/theme changes
external service dependencies
```

### Login problem

Check:

```text
application logs
user role or permission changes
recent plugin/configuration changes
mail/reset flow if relevant
customer scope: one user or many users
```

## Monitoring and alerting notes

Useful alerts:

```text
application unreachable
database unavailable
repeated failed healthcheck
storage close to full
error-rate spike
failed backup or missing backup evidence
certificate/domain expiry in real environments
```

Avoid noisy alerts:

```text
single transient local restart
expected maintenance restart
known test email events in local Mailpit
short-lived warning with no customer impact
```

Escalation threshold should be based on:

```text
customer impact
data risk
security risk
duration
repeatability
rollback uncertainty
```

## Customer communication template

Initial message:

```text
We have identified an issue affecting the service. We are checking application status, database connectivity and recent changes. We will provide the next update after the initial triage.
```

Progress update:

```text
The application layer has been checked. Database connectivity is being verified. No rollback has been performed yet / rollback is being prepared if needed.
```

Resolution update:

```text
The service has been restored and the smoke checks have passed. We will record the incident evidence and follow up with any preventive actions if needed.
```

## Evidence checklist

Record after operational work:

```text
date and time
repository/environment
change or incident summary
commands or checks performed
result
rollback status
customer impact
follow-up actions
```

## Connection to other portfolio repositories

RBAC-Lite demonstrates:

```text
PHP/WordPress access-control baseline
partner-based user scoping
fail-closed behavior
nonce-protected profile update
audit logging
WordPress query-hook hardening
```

Gatehouse demonstrates:

```text
change validation
risk classification
approval thinking
rollback requirement
audit evidence
CI/CD quality gate thinking
```

This local-first WordPress DevSecOps kit demonstrates:

```text
repeatable Docker Compose web environment
PHP application and database dependency
local-first safety
runbooks
recoverability thinking
privacy-safe development rules
```

Together these form a practical web platform operations story:

```text
PHP/web application + database + access control + change governance + rollback + evidence + customer-facing operational discipline
```

## Interview framing

```text
I do not position myself as a senior production platform owner. My portfolio shows the underlying web platform operations logic: a PHP-based application, database dependency, user and role boundaries, controlled updates, rollback thinking, audit trail, Docker Compose environments and documented recoverability.
```

Finnish version:

```text
En myy tätä senior-tuotantoalustan omistajuutena, mutta portfolio osuu web-platform-ylläpidon peruslogiikkaan: PHP-pohjainen sovellus, tietokanta, käyttäjä- ja roolirajaukset, päivitysten muutoksenhallinta, rollback, audit trail, Docker Compose -ympäristö ja dokumentoitu palautettavuus.
```

## Conservative positioning

This note supports the following positioning:

```text
DevOps-oriented IT Specialist with DevSecOps, governance and web platform operations direction.
```

It should not be overstated as:

```text
senior production platform owner
enterprise cloud architect
complete managed hosting product
```
