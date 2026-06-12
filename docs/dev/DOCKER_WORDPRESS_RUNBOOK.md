# Docker WordPress Runbook

## Start the stack

```bash
./scripts/dev-up.sh
```

## Stop the stack

```bash
./scripts/dev-down.sh
```

## View containers

```bash
docker compose ps
```

## View all logs

```bash
docker compose logs -f
```

## View one service log

```bash
docker compose logs -f wordpress
docker compose logs -f db
```

## Enter the WordPress container

```bash
docker compose exec wordpress bash
```

## Soft restart

```bash
docker compose restart
```

## Rebuild

```bash
docker compose up -d --build
```

## Full reset

```bash
./scripts/dev-reset.sh
```

Use full reset only when the local database can be deleted.
