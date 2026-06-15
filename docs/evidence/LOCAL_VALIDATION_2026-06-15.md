# Local Validation Evidence — 2026-06-15

## Scope

This document records local validation evidence for the `local-first-wordpress-devsecops-kit` repository.

Repository:

```text
Jonnenpijonne/local-first-wordpress-devsecops-kit
```

Environment type:

```text
local-first WordPress / PHP / MariaDB / Mailpit Docker Compose environment
```

This is evidence for a runnable local development baseline. It is not a production readiness claim.

## Environment

Validated locally with:

```text
Host: Windows
Shell: Git Bash
WSL: Ubuntu / WSL2
Docker Desktop: 4.77.0
Docker Engine: 29.5.3
Docker Compose: v5.1.4
Git: 2.54.0.windows.1
```

## Runtime services

Expected services:

```text
local_wp        WordPress / PHP application container
local_wp_db     MariaDB database container
local_mailpit   Mailpit local mail capture container
```

Expected local endpoints:

```text
WordPress: http://localhost:8080
Mailpit:   http://localhost:8025
```

## Validation commands

Core validation commands:

```bash
docker compose version
git --version
cp .env.example .env
docker compose pull
docker compose up -d
docker compose ps
docker compose logs --tail=100 wordpress
docker compose logs --tail=100 db
docker compose logs --tail=100 mailpit
docker compose exec wordpress bash
docker compose down
docker compose up -d
docker compose ps
```

## Startup result

The stack started successfully with:

```bash
docker compose up -d
```

Observed service result:

```text
WordPress container started successfully
MariaDB container reached healthy state
Mailpit container started successfully
WordPress application was available at http://localhost:8080
Mailpit UI was available at http://localhost:8025
```

## Runtime result

`docker compose ps` showed the services running.

Important runtime findings:

```text
WordPress published to localhost on port 8080
Mailpit published to localhost on port 8025
MariaDB available internally on the Compose network
MariaDB not directly published to the host
```

Security-relevant observation:

```text
127.0.0.1:8080->80/tcp
127.0.0.1:8025->8025/tcp
```

The local application and Mailpit UI are bound to localhost. This reduces accidental exposure outside the local workstation and is appropriate for a local-first development baseline.

## Browser validation

The application was verified beyond container status.

Observed result:

```text
WordPress admin opened successfully at localhost:8080
Mailpit opened successfully at localhost:8025
WordPress application paths returned successful HTTP 200 responses in logs
```

Previously observed successful WordPress paths included:

```text
wp-admin
plugins.php
users.php
REST API
admin-ajax.php
```

This indicates that the application was actually responding, not merely listed as a running container.

## Runtime shell access

Command:

```bash
docker compose exec wordpress bash
```

Observed result:

```text
root@65e34abc7e70:/var/www/html#
```

Interpretation:

```text
WordPress service was running
Compose resolved the service name
shell access into the container worked
runtime application filesystem was reachable
working directory was /var/www/html
```

`/var/www/html` is the normal WordPress web root in the official WordPress Docker image context.

## Lifecycle validation

The environment lifecycle was also tested.

Command:

```bash
docker compose down
```

Observed result:

```text
WordPress container removed
Mailpit container removed
MariaDB container removed
Compose network removed
```

No `-v` flag was used. Therefore database volumes were not intentionally removed.

Expected failure after shutdown:

```bash
docker compose exec wordpress bash
```

Observed result:

```text
service "wordpress" is not running
```

This was expected because `docker compose exec` requires a running target container. After `docker compose down`, the target container had been removed.

Correct recovery command:

```bash
docker compose up -d
```

The stack was recreated successfully afterwards and checked again with:

```bash
docker compose ps
```

## Transient issue encountered

An initial Docker Hub pull had a transient TLS handshake timeout.

The issue was resolved by running a separate pull and then starting the stack normally:

```bash
docker compose pull
docker compose up -d
```

Interpretation:

```text
transient network/pull issue
not a repository configuration failure
resolved with repeatable Docker pull/start workflow
```

## Audit result

```text
Docker Compose config understood: PASS
Stack startup: PASS
WordPress container startup: PASS
MariaDB health: PASS
Mailpit startup: PASS
Localhost-bound ports: PASS
Database internal-only exposure: PASS
Application browser reachability: PASS
Runtime container shell access: PASS
Controlled shutdown: PASS
Expected exec failure understood: PASS
Stack recreation after shutdown: PASS
Overall status: OPERATIONAL
```

## Evidence value

This validation proves more than first-time startup.

It demonstrates practical lifecycle operation:

```text
start
inspect
read logs
open application
enter running container
shutdown
understand failed exec after shutdown
recreate stack
verify service status again
```

## Portfolio statement

English:

```text
Validated a local-first WordPress/PHP Docker Compose environment in practice: started the WordPress, MariaDB and Mailpit stack, confirmed MariaDB health, verified localhost-bound service exposure, opened the application in browser, inspected logs, entered the running WordPress container and tested shutdown/recreate lifecycle behavior.
```

Finnish:

```text
Validoin local-first WordPress/PHP Docker Compose -ympäristön käytännössä: käynnistin WordPress-, MariaDB- ja Mailpit-stackin, varmistin MariaDB:n healthcheckin, tarkistin localhostiin sidotut portit, avasin sovelluksen selaimessa, tarkistin lokit, menin käynnissä olevan WordPress-kontin sisään ja testasin hallitun sammutus/uudelleenkäynnistys-elinkaaren.
```

## Conservative framing

This evidence supports the following positioning:

```text
DevOps-oriented IT Specialist with practical Docker Compose, local-first web platform operations and DevSecOps governance direction.
```

It should not be overstated as:

```text
production Kubernetes operations
senior platform ownership
managed hosting architecture
enterprise SRE ownership
```
