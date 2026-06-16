# GitHub Actions CI/CD Workflows

This project includes three GitHub Actions workflows designed for local-first DevSecOps development.

## Workflows

### 1. **DevSecOps CI** (`ci.yml`)

Runs on every push and pull request to validate the stack locally.

**Jobs:**
- `docker-compose-validate` — Validates `docker-compose.yml` syntax and service definitions
- `secret-scan` — Uses TruffleHog and custom patterns to detect credentials
- `shell-lint` — Lints all shell scripts in `scripts/` with ShellCheck
- `python-lint` — Validates Python scripts (Black, isort, Flake8, Pylint)
- `env-validate` — Ensures `.env` is properly configured and `.gitignored`
- `docker-build` — Builds WordPress and MariaDB images locally
- `docker-runtime` — Spins up the full stack and validates health checks
- `docs-validate` — Checks README and documentation structure
- `governance-check` — Verifies governance and evidence templates exist

**When it runs:**
- On every `push` to `main` or `develop`
- On every `pull_request` to `main` or `develop`
- Weekly scheduled scan (2 AM UTC Sunday)

**Example output:**
```
✓ docker-compose.yml is valid
✓ All expected services defined
✓ No obvious secrets detected
✓ All shell scripts pass linting
✓ WordPress image builds successfully
✓ Services running
✓ WordPress endpoint responding
```

---

### 2. **Container Build & Publish** (`container-publish.yml`)

Builds and publishes container images to GitHub Container Registry (GHCR).

**Jobs:**
- `build-and-publish` — Builds WordPress image and optionally pushes to GHCR
  - On PR: builds only (does not push)
  - On push to `main`: builds and pushes
  - On tags (`v*.*.*`): builds and publishes with semantic version tags

**When it runs:**
- On pull requests to `main`
- On pushes to `main`
- On git tags matching `v*.*.*` (e.g., `v1.0.0`)

**Images published to:**
```
ghcr.io/YOUR-USERNAME/local-first-wordpress-devsecops-kit:main
ghcr.io/YOUR-USERNAME/local-first-wordpress-devsecops-kit:v1.0.0
ghcr.io/YOUR-USERNAME/local-first-wordpress-devsecops-kit:sha-abc123def456
```

**Prerequisites:**
- Repository must allow GitHub Container Registry access (automatic with public repos)
- For private repos, ensure `GITHUB_TOKEN` has `packages:write` permission

---

### 3. **Security Scanning** (`security-scan.yml`)

Runs comprehensive security checks on code, containers and dependencies.

**Jobs:**
- `container-scanning` — Scans built image with Trivy for known vulnerabilities
- `dependency-check` — Validates Python dependencies
- `dockerfile-lint` — Checks Dockerfile best practices with Hadolint
- `sast-scan` — Static analysis on Python with Bandit
- `git-secrets` — Scans git history for secrets patterns
- `license-check` — Verifies LICENSE file and compliance
- `composition-audit` — Audits docker-compose for security misconfigurations

**When it runs:**
- On every push and pull request
- Weekly scheduled scan (3 AM UTC Sunday)

**Results uploaded to:**
- GitHub Security tab (SARIF format) for container scan findings
- Workflow logs for SAST, dependency and composition audits

---

## How to use

### 1. Enable workflows

Workflows are automatically enabled when you push the `.github/workflows/` directory.

Verify in GitHub repository:
- Go to **Actions** tab
- You should see: `DevSecOps CI`, `Container Build & Publish`, `Security Scanning`

### 2. View workflow runs

```bash
# In GitHub UI:
Repository → Actions → Select workflow → View run details
```

### 3. Add branch protection rules (recommended)

Go to **Settings → Branches → Branch protection rules**:

Add rule for `main`:
- ✓ Require status checks to pass before merging
- ✓ Require code reviews before merging
- ✓ Require branches to be up to date before merging
- ✓ Require approval from code owners

Select required checks:
- `DevSecOps CI / docker-compose-validate`
- `DevSecOps CI / secret-scan`
- `DevSecOps CI / docker-runtime`

---

## Environment variables & secrets

### GitHub Secrets (optional)

If you want to push to Docker Hub instead of GHCR, add:

**Settings → Secrets and variables → Actions → New repository secret**

```
DOCKERHUB_USERNAME = your-dockerhub-username
DOCKERHUB_TOKEN = your-dockerhub-token
```

Then modify `container-publish.yml` to use:
```yaml
- uses: docker/login-action@v3
  with:
    username: ${{ secrets.DOCKERHUB_USERNAME }}
    password: ${{ secrets.DOCKERHUB_TOKEN }}
```

---

## Docker-specific recommendations

### Multi-stage builds

If you have a custom Dockerfile, use multi-stage builds for smaller images:

```dockerfile
# Build stage
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Runtime stage
FROM python:3.11-slim
COPY --from=builder /root/.local /root/.local
COPY . .
CMD ["python", "app.py"]
```

### Caching strategy

Workflows use GitHub Actions cache automatically:
```yaml
cache-from: type=gha
cache-to: type=gha,mode=max
```

This caches Docker layers across workflow runs, speeding up builds.

### Image scanning results

Trivy scan results appear in **Security → Code scanning**:
- Critical/High findings require review before merge
- You can dismiss false positives with explanations

---

## Troubleshooting

### Workflow fails: "docker compose: command not found"

Ensure you're on Ubuntu 22.04+ which includes Docker Compose v2:
```yaml
runs-on: ubuntu-latest
```

### Workflow timeout: Docker runtime validation

If stack takes >5 min to start, increase timeout:
```yaml
- name: Start stack with timeout
  timeout-minutes: 10  # Increase from 5
```

### TruffleHog false positives

Configure exceptions in `.github/workflows/ci.yml`:
```yaml
extra_args: --debug --json --exclude-paths=docs/evidence/
```

### Trivy scan finds vulnerabilities in base images

Update base images regularly:
```bash
# In your docker-compose.yml
image: wordpress:latest  # Use specific tags instead
```

Better:
```bash
image: wordpress:6.4-php8.2-apache  # Specific version
```

---

## Integration with GitHub projects

### Linking workflow failures to issues

Add to your issue templates (`.github/ISSUE_TEMPLATE/`):

```markdown
## CI Status

Check [latest workflow runs](../../actions) for build status.
```

### Automatic PR checks

All workflows run automatically on pull requests. Status shows as:
- ✓ Passing
- ✗ Failing
- ⏳ In progress

Block merges until all checks pass (via branch protection rules).

---

## Security scanning details

### Secret patterns detected

The workflows scan for:
- AWS credentials (keys, tokens)
- Database passwords
- API keys and tokens
- Private SSH/PGP keys
- SMTP credentials
- License keys

### Container vulnerability levels (Trivy)

- **CRITICAL** — CVE with active exploits or high impact
- **HIGH** — Significant risk, should patch
- **MEDIUM** — Notable risk, plan to patch
- **LOW** — Minimal risk, optional

---

## Next steps

1. **Commit workflows:**
   ```bash
   git add .github/workflows/
   git commit -m "chore: add GitHub Actions CI/CD pipelines"
   git push
   ```

2. **Monitor first run** in **Actions** tab

3. **Configure branch protection** in **Settings → Branches**

4. **Add team notifications** (optional):
   ```yaml
   - name: Notify Slack
     if: failure()
     run: |
       # Add Slack webhook for failures
   ```

5. **Enable SBOM generation** (optional for compliance):
   - Uncomment syft step in `container-publish.yml`
   - Generates Software Bill of Materials for auditing

---

## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Setup Buildx Action](https://github.com/docker/setup-buildx-action)
- [Trivy Container Scanner](https://aquasecurity.github.io/trivy/)
- [TruffleHog Secret Detection](https://trufflesecurity.com/)
- [ShellCheck](https://www.shellcheck.net/)
- [Hadolint Dockerfile Linter](https://github.com/hadolint/hadolint)
