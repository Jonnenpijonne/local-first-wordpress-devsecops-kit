# Change Control

## Principle

Small local development changes do not need enterprise bureaucracy, but they still need clarity.

## Risk classes

### Class 1 — documentation-only

Examples:

- README edits
- comments
- non-operational documentation
- spelling fixes

Required:

- clear commit message

### Class 2 — local workflow or development runtime change

Examples:

- docker-compose changes
- script changes
- anonymization process changes
- AI boundary updates
- local development tooling

Required:

- change summary
- test command or validation note
- rollback note

### Class 3 — production-impacting or sensitive control change

Examples:

- production deployment
- tenant isolation logic
- authentication and authorization controls
- secrets handling
- release process
- data export/import controls

Required:

- formal review
- risk assessment
- rollback plan
- evidence trail
- approval before merge
