# Development Data Rules

## Mandatory rules

1. No raw production data in local development.
2. No secrets in repositories, chats or AI prompts.
3. Anonymized datasets remain confidential.
4. Old local datasets must be deleted after refresh.
5. Upload folders are not copied from production by default.
6. External AI tools must not receive local development datasets unless explicitly approved.
7. Dataset handling must leave an evidence trail.

## Local dataset lifecycle

```text
request -> classification review -> minimized extract -> anonymization -> scan -> local import -> validation -> destruction after replacement
```

## Destruction

When local data is no longer needed, remove local volumes and obsolete dumps.

```bash
docker compose down -v
```

Record the action in the relevant evidence log when dataset handling has governance relevance.
