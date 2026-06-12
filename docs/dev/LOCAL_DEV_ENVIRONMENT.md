# Local Development Environment

## Purpose

This document describes the local WordPress development runtime used by this repository.

The local stack is intended for development, onboarding, testing and documentation. It is not a production deployment model.

## Services

| Service | Purpose | Local URL / access |
| --- | --- | --- |
| WordPress | Application runtime | http://localhost:8080 |
| MariaDB | Local database | Docker internal network |
| Mailpit | Local email capture | http://localhost:8025 |

## Start

```bash
docker compose up -d
```

## Stop

```bash
docker compose down
```

## Health check

```bash
./scripts/dev-health.sh
```

## Reset

```bash
./scripts/dev-reset.sh
```

The reset script removes local containers and volumes. Use it only when local data is disposable.

## Local-only principle

Ports are bound to `127.0.0.1` to reduce accidental network exposure outside the developer workstation.
