# AI-Assisted Workflow

This document defines how AI-assisted tools such as OpenCode-style agents, local coding assistants or chat-based helpers may be used in this repository.

The purpose is to gain documentation, troubleshooting and development support without losing Git traceability, privacy boundaries or human review.

## Repository role

This repository is a local-first DevSecOps starter kit for WordPress-based development.

It contains a Docker Compose local runtime, documentation, governance notes, evidence templates and CI/CD validation examples.

It is not a production deployment platform.

## Operating principle

AI is assistive, not autonomous.

The repository workflow remains:

```text
Inspect -> Branch -> Change -> Diff -> Review -> Validate -> Commit -> PR -> Merge
```

AI may help within that workflow, but it must not replace it.

## Phase 1: Read-first orientation

The first AI-assisted session in this repository should be read-only.

The agent should answer:

- what is this repository for?
- what are the main folders?
- what services are defined by Docker Compose?
- what commands start, stop and validate the stack?
- what files are sensitive or local-only?
- what files may be edited safely first?
- what is the validation path?

No files should be edited during the first orientation session unless explicitly approved.

## Phase 2: Documentation-first changes

After orientation, AI may help with documentation-only changes.

Good first changes:

- README clarification
- runbook cleanup
- developer checklist improvements
- governance note improvements
- evidence template clarification
- PR summary drafts
- `AGENTS.md` updates
- `docs/AI_WORKFLOW.md` updates

Validation:

```bash
git diff --stat
git diff
```

## Phase 3: Runtime support

AI may help explain Docker Compose and local runtime state.

Commands that inspect or validate runtime:

```bash
docker compose config
docker compose ps
docker compose logs
```

Commands that start, stop or reset runtime require explicit approval:

```bash
docker compose up -d
docker compose down
```

Reset scripts, volume deletion, database imports and cleanup commands require extra care and should not be run unless the current state is understood.

## Phase 4: Code or configuration changes

Code, Docker, CI or script changes are allowed only after:

- the current branch is not `main`
- the intended change is described
- affected files are listed
- validation commands are known
- rollback path is known
- the user has approved the change category

Higher-risk files:

```text
docker-compose.yml
.github/workflows/
scripts/
.env.example
.gitignore
```

## AI permission posture

Recommended posture:

| Action | Permission |
| --- | --- |
| Read repository files | allow |
| Search repository files | allow |
| Explain documentation | allow |
| Explain Docker Compose | allow |
| Draft documentation | ask |
| Edit files | ask |
| Run tests or validation commands | ask |
| Start or stop Docker runtime | ask |
| Modify Docker Compose | ask |
| Modify GitHub Actions | ask |
| Modify scripts | ask |
| Push branches | deny by default |
| Merge PRs | deny |
| Create release tags | deny |
| Handle secrets or customer data | deny |

## Sensitive data boundary

Do not provide AI with raw material from:

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
real wp-content/uploads/ data
```

Use placeholder values and synthetic examples.

## Local-first data rule

Production data must not be copied directly into local development.

Development datasets must be minimized, anonymized or synthetic. Even anonymized datasets should be treated as confidential unless explicitly approved for use.

## PR summary expectation

AI-assisted PRs should include:

- what changed
- why it changed
- files touched
- validation performed
- risk level
- rollback path
- whether sensitive data was involved

Example:

```text
Risk level: documentation-only / low
Validation: git diff reviewed
Sensitive data: none
Runtime impact: none
Rollback: revert PR or restore changed docs
```

## Rollback examples

For local file edits:

```bash
git status
git diff
git restore <file>
```

For branch-level abandonment:

```bash
git switch main
git branch -D <branch-name>
```

For PR-level rollback:

```text
Revert the PR through GitHub or create a corrective PR.
```

## Definition of done

AI-assisted work is done only when:

- Git diff is reviewed
- validation path is executed or explicitly marked not applicable
- PR summary explains the change
- sensitive data boundary is respected
- no direct push to main occurred
- human approval remains in control
