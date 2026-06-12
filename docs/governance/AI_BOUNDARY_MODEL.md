# AI Boundary Model

## Principle

AI is assistive, not autonomous.

AI can support development, documentation and troubleshooting, but it must not independently control delivery, production access or sensitive data movement.

## Allowed

AI may assist with:

- documentation drafts
- local troubleshooting
- explaining logs
- generating test ideas
- summarizing architecture
- suggesting scripts
- reviewing non-sensitive configuration
- helping with local development workflows

## Not allowed

AI must not independently:

- deploy
- merge to protected branches
- create release tags
- archive repositories
- modify production controls
- receive secrets
- receive raw production data
- receive local anonymized datasets through external SaaS tools without approval
- bypass governance review

## Local AI

Local models may be used for lower-risk development support when data remains on the developer machine.

Recommended local tools:

- Ollama
- Open WebUI
- local coding models

## External AI

External AI services must be treated as third-party processors.

Do not paste:

- secrets
- customer data
- production dumps
- anonymized datasets
- tenant-specific data
- confidential internal architecture

unless explicitly approved through governance review.
