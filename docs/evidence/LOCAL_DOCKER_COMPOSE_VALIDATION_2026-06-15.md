# Local Docker Compose Validation Evidence — 2026-06-15

## Scope

This evidence note records the local validation of the `local-first-wordpress-devsecops-kit` repository on a Windows workstation using WSL2, Docker Desktop and Docker Compose.

Repository:

```text
Jonnenpijonne/local-first-wordpress-devsecops-kit
```

This file is documentation evidence only. It does not change the runtime configuration, Docker Compose file, workflows or application behavior.

## Environment

Validated environment:

```text
Windows host
WSL2 with Ubuntu
Docker Desktop 4.77.0
Docker Engine 29.5.3
Docker Compose v5.1.4
Git 2.54.0.windows.1
```

Docker backend validation showed a Linux backend through Docker Desktop:

```text
Context: desktop-linux
Server: Docker Desktop 4.77.0
Engine OS/Arch: linux/amd64
```

## Initial issue

Docker Desktop initially reported a virtualization-related startup issue.

The host virtualization setting was checked through Windows Task Manager and found to be enabled.

The actual missing piece was the WSL2/Linux distribution side:

```text
Docker Desktop installed: yes
BIOS/CPU virtualization: enabled
WSL initially missing: yes
Ubuntu WSL2 distribution initially missing: yes
```

## WSL2 and Ubuntu validation

WSL2 was installed and Ubuntu was provisioned as the WSL2 Linux distribution.

Validated result:

```text
Ubuntu registered in WSL
Ubuntu uses WSL version 2
WSL2 backend available
```

## Docker and Compose validation

Docker CLI and Compose were validated.

Commands:

```bash
docker version
docker compose version
git --version
```

Results:

```text
Docker Engine: 29.5.3
Docker Desktop: 4.77.0
Docker Compose: v5.1.4
Git: 2.54.0.windows.1
```

## Repository setup

The repository was cloned locally and the local environment configuration was created from the example file.

Commands:

```bash
git clone https://github.com/Jonnenpijonne/local-first-wordpress-devsecops-kit.git
cd local-first-wordpress-devsecops-kit
cp .env.example .env
```

Result:

```text
Repository cloned: OK
Local .env created: OK
```

## Image pull issue and recovery

The first Compose startup attempt began pulling images but hit a Docker Hub authentication/TLS timeout.

Observed issue:

```text
failed to fetch oauth token
TLS handshake timeout
```

This was treated as a transient network/Docker Hub pull issue, not as a Docker, WSL or Compose configuration failure.

Recovery command:

```bash
docker compose pull
```

Result:

```text
wordpress:latest pulled
mariadb:11 pulled
axllent/mailpit:latest pulled
```

## Stack startup validation

After the images were pulled, the stack was started successfully.

Command:

```bash
docker compose up -d
```

Runtime result:

```text
Docker network created
Docker volume created
MariaDB container healthy
WordPress container started
Mailpit container started
```

## Service status validation

Command:

```bash
docker compose ps
```

Validated services:

```text
local_wp        wordpress:latest         Up
local_wp_db     mariadb:11               Up / healthy
local_mailpit   axllent/mailpit:latest   Up / healthy
```

Validated local ports:

```text
WordPress: 127.0.0.1:8080 -> container port 80
Mailpit:   127.0.0.1:8025 -> container port 8025
MariaDB:   internal Compose network only, 3306/tcp
```

## Browser validation

The WordPress admin UI was opened successfully in the browser:

```text
http://localhost:8080/wp-admin/
```

Observed result:

```text
WordPress dashboard reachable
WordPress admin session usable
Database connectivity implied by working admin UI
```

Mailpit was exposed locally through:

```text
http://localhost:8025
```

## Architecture validated

The validated local architecture:

```text
Browser
  |
  | http://localhost:8080
  v
WordPress container
  |
  | internal Docker Compose network
  v
MariaDB container

Browser
  |
  | http://localhost:8025
  v
Mailpit container
```

Compose-created resources:

```text
Network: local-first-wordpress-devsecops-kit_app-net
Volume:  local-first-wordpress-devsecops-kit_db_data
```

## Security and governance observations

Positive observations:

```text
Services exposed only through localhost-bound ports
MariaDB not directly exposed to host port
Mailpit used for local email capture
.env.example used as versioned configuration model
.env used as local runtime configuration
MariaDB reached healthy state
Stack starts through repeatable Docker Compose command
```

Operational meaning:

```text
The environment is local-first, repeatable, recoverable and suitable for safe PHP/web development validation.
```

## Known limitations

This validation does not claim:

```text
production WordPress hardening
production Moodle administration
Kubernetes operation
cloud deployment ownership
complete managed hosting product readiness
enterprise platform ownership
```

The stack is a local development and portfolio baseline.

## Recommended follow-up checks

Useful optional checks:

```bash
docker compose logs --tail=50
docker compose exec db mariadb --version
docker compose exec wordpress php -v
docker compose exec wordpress apache2 -v
docker compose config
git status --short
```

These can provide additional evidence for runtime versions, rendered Compose configuration and working tree cleanliness.

## Portfolio interpretation

This validation shows practical ability to:

```text
install and validate Docker Desktop on Windows
identify WSL2/backend issues
install and provision Ubuntu on WSL2
validate Docker Engine and Docker Compose
clone and prepare a local web-stack repository
handle transient image pull failures
start a PHP/web + database + mail testing stack
inspect container health and port bindings
validate a browser-reachable web application
record evidence of the process
```

## Interview framing

English:

```text
I built and validated a local-first WordPress development environment on Windows using WSL2, Docker Desktop and Docker Compose. The stack includes WordPress, MariaDB and Mailpit for local email testing. I troubleshot the initial Docker virtualization/WSL backend issue, installed and validated Ubuntu on WSL2, resolved a transient Docker Hub TLS timeout during image pull, and confirmed the environment through docker compose ps and a working WordPress admin session on localhost:8080.
```

Finnish:

```text
Rakensin ja validoin paikallisen WordPress-kehitysympäristön Windowsin, WSL2:n, Docker Desktopin ja Docker Composen päälle. Stack sisältää WordPressin, MariaDB:n ja Mailpitin paikalliseen sähköpostitestaukseen. Ratkaisin alkuperäisen Dockerin virtualisointi-/WSL-backend-ongelman, asensin ja validoin Ubuntun WSL2:ssa, korjasin Docker Hubin TLS-timeoutiin liittyneen image pull -ongelman ja varmistin ympäristön toiminnan docker compose ps -tuloksella sekä toimivalla WordPress-adminilla osoitteessa localhost:8080.
```

## Final validation status

```text
Technical result: PASS
Environment status: Operational
Compose startup: Successful
WordPress: Running and reachable
MariaDB: Healthy
Mailpit: Healthy
Evidence quality: Strong practical local validation
```
