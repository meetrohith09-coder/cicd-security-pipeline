# Tool Configuration Guide

## Secret Scanning (Gitleaks)

**What it does:** Scans git history for secrets (API keys, passwords, tokens)

**Tools used:** Gitleaks via GitHub Actions

**How it's configured:**
- Runs on every push and PR
- Uses Gitleaks patterns for AWS, GitHub, Slack tokens, etc.
- Blocks the pipeline if secrets found

**Configuration:**
```yaml
- name: Secret Scanning
  uses: gitleaks/gitleaks-action@v2
```

**If you have a false positive:**
1. Document why it's not a secret
2. Add exception to `.gitleaksignore`

---

## SAST (Static Analysis Security Testing)

**What it does:** Analyzes code for vulnerabilities without running it

**Tools used:** Semgrep

**Rules included:**
- OWASP Top 10 vulnerabilities
- CWE Top 25 (Common Weakness Enumeration)
- AWS security best practices
- Python/JavaScript-specific security issues

**Configuration:**
```yaml
- name: SAST - Semgrep
  uses: returntocorp/semgrep-action@v1
  with:
    config: >-
      p/security-audit
      p/owasp-top-ten
      p/cwe-top-25
```

**Example findings:**
- SQL injection
- Command injection
- Hardcoded secrets
- XXE (XML External Entity)
- Insecure randomness

---

## Dependency Scanning

**What it does:** Checks libraries for known vulnerabilities

**Tools used:** Trivy

**How it works:**
1. Scans `requirements.txt`, `package.json`, `go.mod`, etc.
2. Compares against CVE databases
3. Reports vulnerabilities with severity

**Example findings:**
- `requests==2.20.0` has CVE-2023-32681 (medium)
- `django==2.2.0` has CVE-2023-31047 (high)

---

## IaC Scanning (Terraform)

**What it does:** Checks infrastructure code for misconfigurations

**Tools used:** Checkov

**What it finds:**
- S3 buckets with public access
- Security groups open to 0.0.0.0/0
- Unencrypted databases
- Missing backups
- Missing logging

**Example findings:**
- `aws_s3_bucket.data` has ACL set to "public-read"
- `aws_security_group.app` allows inbound on port 3306 from 0.0.0.0/0

---

## Container Scanning

**What it does:** Scans Dockerfile and built images for issues

**Tools used:** Trivy

**What it finds:**
- Base image vulnerabilities
- Running as root
- Using :latest tags
- Missing health checks

---

## Block vs Warn Policy

### Always Block (Pipeline Fails)
- ✗ Any secrets detected
- ✗ Critical vulnerabilities with known exploits
- ✗ S3 public access
- ✗ Security group open to 0.0.0.0/0 on ports 22, 3306, 5432

### Warn (Let Pipeline Continue)
- ⚠️ Medium-severity vulnerabilities
- ⚠️ Code quality issues
- ⚠️ Informational findings
- ⚠️ Known false positives (documented)

