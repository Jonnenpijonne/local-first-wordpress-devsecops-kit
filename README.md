# local-first-wordpress-devsecops-kit

Local-first DevSecOps starter kit for regulated WordPress development: Docker Compose, privacy-safe data handling, AI boundaries, runbooks and audit evidence templates.

![CI](https://github.com/Jonnenpijonne/local-first-wordpress-devsecops-kit/actions/workflows/ci.yml/badge.svg)
![Security](https://github.com/Jonnenpijonne/local-first-wordpress-devsecops-kit/actions/workflows/security-scan.yml/badge.svg)
![CD](https://github.com/Jonnenpijonne/local-first-wordpress-devsecops-kit/actions/workflows/container-publish.yml/badge.svg)

A lightweight, auditable and recoverable local development model for regulated WordPress-based platforms.

`DevSecOps` `WordPress` `Docker` `Governance` `Privacy` `AI Boundary`

---

## Status

**v1.0.0 Local Development Ready**

✅ CI/CD Active — Automated validation for the local development baseline  
✅ Security Checks — Container, Python and secret scanning included  
✅ Branch Protection — Review and status-check model documented  
✅ Release Tagged — v1.0.0 ready for local development use  

---

## Local validation evidence

This repository has been validated locally on Windows with WSL2, Docker Desktop and Git Bash.

Validated runtime state:

- WordPress available at `http://localhost:8080`
- Mailpit available at `http://localhost:8025`
- MariaDB reached healthy state
- Docker Compose lifecycle tested: `up`, `ps`, `down`, `up -d`, `exec`
- WordPress container shell access validated with `docker compose exec wordpress bash`

Detailed evidence:

- `docs/evidence/LOCAL_VALIDATION_2026-06-15.md`
- `docs/evidence/LIGHTHOUSE_AUDIT_2026-06-15.md`
- `docs/ops/DOCKER_COMPOSE_LIFECYCLE_AUDIT.md`

---

## Purpose

This repository demonstrates a local-first DevSecOps development baseline for WordPress-based platforms that may later need to operate in regulated, privacy-aware or multi-tenant environments.

The goal is not to create a production platform locally.

The goal is to make local development:

- repeatable
- recoverable
- understandable
- safe by default
- easy to onboard
- auditable enough for early-stage governance
- protected from accidental production-data and AI-context leakage

In short:

> Anyone in the team should be able to clone the repository, start the stack and understand what is running — without cargo-culting Docker, leaking data or depending on one person's memory.

---

## Core idea

Most local development environments fail in the same way:

- setup depends on one person
- production data gets copied casually
- secrets end up in repositories or chats
- Docker is used without understanding what it actually isolates
- AI tools are given too much context
- no one knows what is safe to reset
- environments drift until they become snowflakes

This kit addresses those problems with a small, explicit and documented baseline:

```text
Docker Compose runtime
+ WordPress development stack
+ Git / SSH / signed commit workflow
+ no production data in development
+ anonymized dataset handling model
+ local AI boundary model
+ developer runbooks
+ evidence templates
+ GitHub Actions CI/CD
