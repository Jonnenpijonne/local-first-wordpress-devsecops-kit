# Data Anonymization Guide

## Principle

Anonymization reduces risk, but anonymized development data is still treated as confidential.

## Minimum process

1. Review data classification.
2. Export only required tables.
3. Replace personal data.
4. Remove sensitive configuration values.
5. Preserve referential consistency where needed.
6. Round timestamps where appropriate.
7. Scan output for sensitive patterns.
8. Record evidence.

## Stable pseudonymization

Random replacement is not always enough.

For relational data, the same source value should map to the same pseudonym across tables.

```python
def stable_pseudonym(value: str) -> str:
    import hashlib
    return hashlib.sha256(f"project_seed_{value}".encode()).hexdigest()[:12]
```

## Validation

After anonymization, review the resulting dataset before importing it into the local stack.

```bash
./scripts/scan-secrets.sh anonymized_dump.sql
```

If matches are found, fix the anonymization process and regenerate the dataset.

## Evidence

Record each anonymization run in:

```text
docs/evidence/ANONYMIZATION_LOG_TEMPLATE.md
```
