# Pipeline Blocked? Here's What To Do

## Step 1: Read the Error Message

GitHub shows you:
- **What failed** (secret scan, SAST, dependency scan, etc.)
- **Why it failed** (which check, what finding)
- **Where it failed** (which file, which line)

## Step 2: Understand the Finding

Click "Details" in GitHub to see:
- Full finding details
- Links to remediation docs
- Severity level

## Step 3: Fix the Issue

### Secret Found?
```bash
# Remove the secret
git rm --cached .env
echo ".env" >> .gitignore
git add .gitignore
git commit -m "Remove secrets from git history"

# If you committed a secret:
# 1. Rotate the actual secret immediately
# 2. Use BFG Repo-Cleaner to remove from history
```

### Vulnerability in Code?
- Follow Semgrep's remediation link
- Example: SQL injection → use parameterized queries
- Test your fix locally

### Vulnerable Dependency?
- Check if newer version available: `npm outdated`
- Update: `npm update package-name`
- Or downgrade to last known good version

### IaC Misconfiguration?
- Enable encryption: `encrypted = true`
- Restrict access: `cidr_blocks = ["10.0.0.0/8"]`
- Add backup retention: `backup_retention_period = 7`

## Step 4: Commit and Re-Push
```bash
git add .
git commit -m "Fix security issue: [description]"
git push
```

Pipeline automatically re-runs.

## Step 5: If You Can't Fix

**Request an exception** (see `adding-exceptions.md`)

**But first ask yourself:**
- Is this a real security issue? (Probably yes)
- Can I fix this? (Usually yes)
- Will fixing break something? (Rarely)

Don't add exceptions just to bypass security checks.

---

## Who Can Override the Pipeline?

Only if:
1. ✓ You have a documented exception
2. ✓ It's approved by team lead + security
3. ✓ It has an expiration date
4. ✓ It's in the `policies/exceptions/` folder

## Quick Reference

| Issue | Fix Time | Difficulty |
|-------|----------|-----------|
| Secret found | 5 min | Easy (remove it) |
| SQL injection | 15 min | Medium (rewrite query) |
| Vulnerable library | 10 min | Easy (update version) |
| S3 public access | 5 min | Easy (change ACL) |
| Missing encryption | 10 min | Easy (add flag) |

