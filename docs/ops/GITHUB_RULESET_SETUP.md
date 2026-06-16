# GitHub Ruleset Configuration

## Step-by-Step: Create Branch Protection Ruleset

### 1. Go to Repository Settings

- Navigate to: `https://github.com/YOUR-USERNAME/local-first-wordpress-devsecops-kit/settings/rules`
- Or: **Repository → Settings → Rules → Rulesets**

### 2. Create New Ruleset

Click **"New ruleset"** → **"New branch ruleset"**

### 3. Configure Ruleset Settings

#### A. Ruleset Name & Scope
```
Name: "Main Branch Protection"
Enforcement: Enabled
Target: Branches
Include patterns: main
Exclude patterns: (leave empty)
```

#### B. Bypass List (WHO CAN BYPASS)
```
Admins can bypass: [checked]
Allow specified actors to bypass: [checked]

Bypass for:
- Users: Your GitHub username (only you can force-push during emergencies)
- Teams: (leave empty or add team leads)
```

#### C. Rules to Enable

**1. Require Branches to be Up to Date Before Merging**
```
✓ Enable
  - Dismiss stale pull request approvals when new commits are pushed
```

**2. Require Status Checks to Pass Before Merging**
```
✓ Enable

Required status checks:
  - DevSecOps CI / docker-compose-validate
  - DevSecOps CI / docker-runtime
  - DevSecOps CI / secret-scan
  - Security Scanning / container-scanning (optional but recommended)
```

**3. Require Code Reviews Before Merging**
```
✓ Enable
  - Required number of approvals: 1 (or 2 for stricter control)
  - Dismiss stale pull request approvals when new commits are pushed: [checked]
  - Require review from code owners: [unchecked] (unless you have CODEOWNERS)
```

**4. Require Conversation Resolution Before Merging**
```
✓ Enable
  - All conversations must be resolved before merge
```

**5. Require Commits to be Signed**
```
✓ Enable (optional but recommended for security)
  - Requires all commits to be GPG or SSH signed
```

**6. Restrict Force Pushes**
```
✓ Enable
  - Only allow specified actors to force push
  - Admins can force push: [checked]
```

**7. Lock Branch**
```
✗ Disable (leave unchecked - you still need to work on it)
```

#### D. Completion Settings
```
Click: "Create"
```

---

## Visual Checklist

When creating the ruleset, enable these boxes:

```
BRANCH PROTECTION RULESET
═══════════════════════════════════════

Ruleset Name: "Main Branch Protection"
Target: main

REQUIRED CHECKS:
  ✓ docker-compose-validate
  ✓ docker-runtime  
  ✓ secret-scan

REVIEW REQUIREMENTS:
  ✓ Require 1 approval before merge
  ✓ Dismiss stale reviews on new commits
  ✓ Resolve all conversations

OTHER:
  ✓ Require branches up to date
  ✓ Require signed commits (optional)
  ✓ Restrict force pushes (admin bypass only)
  ✗ Do not lock branch
```

---

## What This Means

Once the ruleset is active:

### ✅ ALLOWED
- Create pull requests anytime
- Push to feature branches
- Request code reviews

### ❌ BLOCKED (Until conditions met)
- Merge PR if any status check failed
- Merge PR without at least 1 approval
- Merge PR with unresolved conversations
- Force push to main (only admins can)

### Result
```
Pull Request Flow:
─────────────────

1. Create PR from feature branch → main
   ↓
2. GitHub runs CI automatically
   ├─ DevSecOps CI (9 jobs)
   ├─ Security Scanning (7 jobs)
   └─ Container Publish (build only, no push)
   ↓
3. Checks status shows:
   ├─ ✓ docker-compose-validate
   ├─ ✓ docker-runtime
   ├─ ✓ secret-scan
   ├─ ✓ (all other jobs)
   └─ Awaiting review...
   ↓
4. You (or teammate) review code
   ↓
5. Reviewer approves
   ↓
6. ALL conditions met:
   ├─ All checks pass ✓
   ├─ At least 1 approval ✓
   └─ Branch up to date ✓
   ↓
7. "Merge" button becomes ENABLED
   ↓
8. You click Merge → code goes to main
   ↓
9. Container Publish workflow runs
   ├─ Builds image
   └─ Pushes to GHCR (published)
```

---

## Required Status Checks Explained

### DevSecOps CI / docker-compose-validate
- **What**: Verifies docker-compose.yml syntax is valid
- **Why**: Prevents broken configurations from reaching main
- **Fail if**: YAML syntax error, missing services

### DevSecOps CI / docker-runtime
- **What**: Actually starts the stack and tests it
- **Why**: The most important check - catches real runtime problems
- **Fail if**: Containers won't start, WordPress doesn't respond, database fails

### DevSecOps CI / secret-scan
- **What**: Scans for passwords, API keys, credentials
- **Why**: Prevents credential leaks to repository
- **Fail if**: Any secrets patterns detected

### Security Scanning / container-scanning (optional)
- **What**: Scans image for known vulnerabilities (Trivy)
- **Why**: Catches vulnerable packages before production
- **Fail if**: Critical/High severity CVEs found

---

## After Ruleset is Created

### First time merging to main:

1. Push workflows first:
   ```bash
   git add .github/ docs/ops/GITHUB_ACTIONS_CI_CD.md
   git commit -m "chore: add CI/CD workflows"
   git push
   ```

2. Create a PR (to test the ruleset):
   ```bash
   git checkout -b test-ci
   echo "# Test" >> README.md
   git add README.md
   git commit -m "test: verify CI works"
   git push origin test-ci
   ```

3. On GitHub: **Create Pull Request** → `test-ci` → `main`

4. Watch the checks run in the PR:
   - GitHub Actions will trigger automatically
   - Wait for all checks to complete (5-10 minutes)
   - Once all green ✓, you can approve and merge

5. Cleanup test branch:
   ```bash
   git checkout main
   git pull
   git branch -d test-ci
   ```

---

## Troubleshooting Ruleset Issues

### "I can't merge - checks keep failing"

Common causes:
- Secrets detected: remove them, commit again
- Docker compose syntax error: fix YAML, commit again
- Stack won't start: check docker logs, fix Dockerfile/config
- Branch not up to date: pull latest main, rebase, push again

### "I need to emergency merge (bypass ruleset)"

Only as admin:
1. Go to PR
2. Click **"Merge without waiting"** (if enabled for admins)
3. Document why in commit message

### "How do I require approval from specific people?"

Use `CODEOWNERS` file:

Create `.github/CODEOWNERS`:
```
# Root ownership
* @your-username

# Specific areas
/scripts/ @your-username @team-ops
/docs/governance/ @your-username @security-lead
```

Then enable "Require review from code owners" in ruleset.

---

## Key Points Summary

| Item | Setting |
|------|---------|
| **Ruleset name** | "Main Branch Protection" |
| **Target branch** | `main` |
| **Required checks** | docker-compose-validate, docker-runtime, secret-scan |
| **Reviews required** | 1 minimum |
| **Up-to-date required** | Yes |
| **Signed commits** | Yes (recommended) |
| **Force push allowed** | Admin bypass only |
| **Conversations** | Must resolve all |

---

## Next: Push Workflows & Test

Once ruleset is created on GitHub:

```bash
# 1. Commit workflows
git add .github/ docs/ops/GITHUB_ACTIONS_CI_CD.md
git commit -m "chore: add GitHub Actions CI/CD pipelines"

# 2. Push to main (first push, no PR needed yet)
git push origin main

# 3. Go to Actions tab - watch them run
# https://github.com/YOUR-USERNAME/local-first-wordpress-devsecops-kit/actions

# 4. Create test PR to verify ruleset works
git checkout -b test-ruleset
echo "test" >> README.md
git add README.md
git commit -m "test: verify ruleset enforcement"
git push origin test-ruleset

# 5. Create PR on GitHub and watch checks run
# Once all pass + approved, test the merge
```

---

## Visual: Ruleset in GitHub UI

```
Repository Settings
  ↓
Rules
  ↓
Rulesets
  ↓
New ruleset → Branch ruleset
  ↓
Name: "Main Branch Protection"
Target: main
  ↓
Enable rules:
  ✓ Require branches up to date
  ✓ Require status checks (select your 3 jobs)
  ✓ Require 1 approval
  ✓ Require conversations resolved
  ✓ Require signed commits
  ✓ Restrict force pushes
  ↓
Save
```
