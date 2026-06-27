# AGENTS.md

This repository is a local-first WordPress DevSecOps starter kit.

It demonstrates a safe, repeatable and auditable local development model for WordPress-based platforms using Docker Compose, MariaDB, Mailpit, documentation, governance boundaries and CI/CD validation.

This repository is not a production deployment platform.

## Core rule

Assist, do not automate ownership.

AI may help inspect, explain, document and propose changes, but it must not bypass Git, human review, privacy boundaries or repository validation.

## Repository purpose

Use this repository to demonstrate:

- local-first WordPress development
- Docker Compose based onboarding
- privacy-aware development workflow
- no production data in local development
- AI boundary model for development support
- runbooks and evidence templates
- CI/CD validation baseline
- governance-before-scale thinking

## First-pass workflow

For AI-assisted work, follow this sequence:

```text
Inspect -> Branch -> Change -> Diff -> Review -> Validate -> Commit -> PR -> Merge
```

Do not skip directly to code or runtime changes.

## Allowed AI assistance

AI may help with:

- summarizing repository structure
- explaining Docker Compose services
- drafting README or documentation improvements
- clarifying runbooks
- drafting checklists
- drafting pull request summaries
- suggesting test or validation commands
- explaining non-sensitive logs
- preparing documentation-only changes

## Ask before doing

AI must ask before:

- editing files
- running commands that change local runtime state
- starting or stopping containers
- modifying `docker-compose.yml`
- modifying `.github/workflows/`
- modifying scripts
- modifying `.env.example`
- changing `.gitignore`
- creating commits
- pushing branches
- opening pull requests

## Not allowed independently

AI must not independently:

- merge pull requests
- push directly to `main`
- create release tags
- publish containers
- change branch protection
- weaken security scans
- expose ports beyond localhost without explicit approval
- import production data
- read or create secret material
- process customer data
- bypass documented review gates

## Sensitive and local-only material

Do not paste, store or commit raw sensitive material from:

```text
.env
.env.*
secrets/
private-data/
customer-data/
dumps/
backups/
production exports
real database dumps
wp-content/uploads/ real data
```

`.env.example` may be reviewed because it should contain placeholders only.

## Safe first edit areas

Good first AI-assisted changes are documentation-only:

```text
README.md
docs/dev/
docs/governance/
docs/privacy/
docs/ops/
docs/evidence/
AGENTS.md
docs/AI_WORKFLOW.md
```

## Higher-risk areas

These require explicit review and validation:

```text
docker-compose.yml
.github/workflows/
scripts/
.env.example
.gitignore
container publishing workflow
security scanning workflow
```

## Local validation commands

Before runtime-aware changes are considered ready, use the documented validation path.

Documentation-only changes:

```bash
git diff --stat
git diff
```

Runtime-aware checks:

```bash
docker compose config
docker compose ps
```

Do not run destructive reset or cleanup commands unless the repository state is understood.

## Git expectations

Before work:

```bash
git status
git branch --show-current
git remote -v
git diff --stat
```

Use feature or documentation branches. Do not work directly on `main` for AI-assisted changes.

## Done criteria

A change is ready for review when:

- the purpose is clear
- changed files are listed
- sensitive data was not added
- validation path is documented
- rollback path is clear
- Git diff is reviewable
- PR summary explains the risk level
