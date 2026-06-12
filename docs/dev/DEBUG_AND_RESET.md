# Debug and Reset

## First checks

```bash
docker compose ps
docker compose logs --tail=100
```

## WordPress not opening

Check that the WordPress container is running:

```bash
docker compose ps wordpress
```

Check logs:

```bash
docker compose logs -f wordpress
```

## Database not healthy

Check database logs:

```bash
docker compose logs -f db
```

Run health check:

```bash
docker compose exec db mariadb-admin ping -h localhost -uroot -p"${MYSQL_ROOT_PASSWORD:-root}"
```

## Mail not visible

Open Mailpit:

```text
http://localhost:8025
```

## Safe reset path

1. Stop the stack.
2. Confirm whether local data can be deleted.
3. Run the reset script.
4. Validate services with `docker compose ps`.

```bash
./scripts/dev-reset.sh
```
