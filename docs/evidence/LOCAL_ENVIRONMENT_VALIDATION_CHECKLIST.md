# Local Environment Validation Checklist

## Runtime

- [ ] Docker Compose is installed
- [ ] Repository cloned successfully
- [ ] Environment file created from example
- [ ] Stack starts with docker compose up -d
- [ ] WordPress container is running
- [ ] Database container is healthy
- [ ] Mailpit container is running

## Access

- [ ] WordPress opens at http://localhost:8080
- [ ] Mailpit opens at http://localhost:8025
- [ ] Exposed ports are bound to localhost

## Recovery

- [ ] dev-health script runs successfully
- [ ] dev-down script stops the stack
- [ ] dev-up script starts the stack again
- [ ] Reset process is documented and understood

## Governance

- [ ] Development data rules reviewed
- [ ] AI boundary model reviewed
- [ ] Local-only principle reviewed
