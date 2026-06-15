# Docker Compose Lifecycle Audit

## Scope

This audit records a practical lifecycle validation for the local-first WordPress DevSecOps environment.

The validation covered:

```text
controlled shutdown
expected exec failure after shutdown
restart vs recreate behavior
stack recreation
service status verification
localhost-bound port interpretation
runtime shell access into the WordPress container
```

This is operational evidence. It shows environment lifecycle understanding, not only a successful first-time startup.

## Starting point

The stack had previously been validated as running with the following services:

```text
local_wp        WordPress
local_wp_db     MariaDB
local_mailpit   Mailpit
```

Earlier application logs had shown successful HTTP 200 responses for WordPress admin and application paths such as:

```text
wp-admin
plugins.php
users.php
REST API
admin-ajax.php
```

This indicates that the application was functionally responding, not only that containers were listed as running.

## Controlled shutdown

Command:

```bash
docker compose down
```

Observed result:

```text
Container local_wp Removed
Container local_mailpit Removed
Container local_wp_db Removed
Network local-first-wordpress-devsecops-kit_app-net Removed
```

Interpretation:

```text
WordPress container removed: PASS
Mailpit container removed: PASS
MariaDB container removed: PASS
Compose network removed: PASS
```

No volume removal was observed. The command used was not:

```bash
docker compose down -v
```

Therefore the database volume was likely preserved.

Audit result:

```text
Controlled shutdown: PASS
Containers removed: PASS
Network removed: PASS
Database volume likely preserved: PASS
```

## Expected exec failure after shutdown

Command:

```bash
docker compose exec wordpress bash
```

Observed result:

```text
service "wordpress" is not running
```

Interpretation:

`docker compose exec` requires a running target container. Because `docker compose down` had removed the WordPress container, there was no running container to enter.

This was an expected state error, not a Docker failure.

Audit result:

```text
Error understood: PASS
Root cause: container not running
Severity: non-issue
```

## Restart after down

Command:

```bash
docker compose restart
```

Interpretation:

`restart` is useful when containers still exist and need to be restarted. After `docker compose down`, the containers had already been removed, so there were no existing containers to restart.

Correct recovery command after `down`:

```bash
docker compose up -d
```

Audit result:

```text
restart after down: ineffective but harmless
correct recovery command identified: PASS
```

## Stack recreation

Command:

```bash
docker compose up -d
```

Observed result:

```text
Container local_wp_db    Healthy
Container local_mailpit  Started
Container local_wp       Started
```

Interpretation:

```text
Compose recreated the stack: PASS
MariaDB reached healthy state: PASS
Mailpit started: PASS
WordPress started: PASS
previous shutdown did not break the environment: PASS
```

The database health status is especially important because it shows that the service reached its defined healthy state rather than merely starting a process.

## Runtime service verification

Command:

```bash
docker compose ps
```

Observed runtime state:

```text
local_mailpit   Up / healthy   127.0.0.1:8025->8025/tcp
local_wp        Up             127.0.0.1:8080->80/tcp
local_wp_db     Up / healthy   3306/tcp
```

Interpretation:

```text
WordPress container running: PASS
MariaDB running and healthy: PASS
Mailpit running and healthy: PASS
WordPress published to localhost: PASS
Mailpit published to localhost: PASS
Database not directly published to host: PASS
```

Security note:

```text
127.0.0.1:8080->80
127.0.0.1:8025->8025
```

The application and mail UI are bound to localhost rather than all network interfaces. This is appropriate for a local-first development environment.

Audit result:

```text
Runtime service status: PASS
Port mapping: PASS
Localhost binding: PASS
Database internal-only exposure: PASS
```

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
WordPress service is running: PASS
Compose resolves the service name: PASS
shell access into container works: PASS
bash is available in the container: PASS
runtime application filesystem is reachable: PASS
working directory is /var/www/html: PASS
```

`/var/www/html` is the normal WordPress web root in the official WordPress Docker image context.

## Overall audit result

```text
Compose lifecycle validation: PASS
Controlled shutdown: PASS
Expected error interpretation: PASS
Stack recreation: PASS
Database health: PASS
Mailpit health: PASS
WordPress startup: PASS
Container exec access: PASS
Operational understanding: PASS
Overall status: OPERATIONAL
```

## What this proves

This validation proves practical web platform operations capability around a local-first PHP/WordPress stack:

```text
start
inspect
shutdown
understand failed exec
recreate
verify status
enter running application container
```

It demonstrates:

```text
Docker Compose lifecycle management
container state understanding
difference between down / restart / up
service health verification
port mapping interpretation
runtime shell access
application container inspection readiness
```

## Portfolio statement

```text
Validated the Docker Compose lifecycle of a local-first WordPress/PHP environment in practice: performed a controlled shutdown, identified why exec cannot enter a removed container, recreated the stack with docker compose up -d, verified service status and health checks with docker compose ps, interpreted localhost-bound ports and opened shell access into the running WordPress container for runtime inspection.
```

Finnish version:

```text
Validoin Docker Compose -pohjaisen WordPress/PHP-ympäristön elinkaaren käytännössä: sammutin stackin hallitusti, tunnistin miksi exec ei toimi poistettuun konttiin, käynnistin ympäristön uudelleen docker compose up -d -komennolla, varmistin palveluiden tilan docker compose ps -komennolla, tulkitsin localhostiin sidotut portit ja avasin shell-yhteyden käynnissä olevaan WordPress-konttiin runtime-tarkastusta varten.
```
