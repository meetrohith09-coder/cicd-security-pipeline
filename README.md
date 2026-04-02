# CI/CD Pipelines With Security Built In

![Security](https://img.shields.io/badge/Security-Automated-green)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-blue)
![Terraform](https://img.shields.io/badge/Terraform-Scanned-orange)

## What Is This?

A **production-grade CI/CD pipeline** that automatically scans code, infrastructure, and containers for vulnerabilities **before they reach production**.

Think of it like a security checkpoint that developers pass through every time they push code. If something dangerous is detected, the pipeline blocks the deployment and tells them how to fix it.

---

## What Gets Scanned?

| Type | Tool | When | Blocks Pipeline? |
|------|------|------|-----------------|
| **Secrets** | Gitleaks | Every push | ✅ YES |
| **Code** | Semgrep | Every push | ✅ YES (critical) |
| **Dependencies** | Trivy | Every push | ✅ YES (critical CVE) |
| **Terraform** | Checkov | IaC changes | ✅ YES (misconfig) |
| **Containers** | Trivy | Dockerfile changes | ⚠️ WARN |

---

## How It Works
```
Developer → Push Code → GitHub Actions → Security Scans → Pass/Block
                              ↓
                    5 Security Checks:
                    • Secrets (Gitleaks)
                    • Code (Semgrep)
                    • Dependencies (Trivy)
                    • Infrastructure (Checkov)
                    • Containers (Trivy)
```

---

## Quick Start

### 1. View the Workflows

Go to: **Actions** tab in GitHub

### 2. Trigger a Workflow

1. Click **Security Scan** workflow
2. Click **Run workflow**
3. Watch it run (2-5 minutes)

### 3. See Results

- Green ✅ = All checks passed
- Red ❌ = Issues found (see details)

---

## Project Structure
```
.github/
├── workflows/
│   ├── security-scan.yml       # Main security pipeline
│   ├── terraform-check.yml     # IaC scanning
│   └── container-scan.yml      # Container scanning

docs/
├── tool-configuration.md       # How each tool works
├── adding-exceptions.md        # How to request exceptions
└── escalation-process.md       # What to do when blocked

sample-app/
├── app.py                      # Vulnerable Python app
├── Dockerfile                  # Bad Dockerfile
└── main.tf                     # Misconfigured Terraform

policies/
├── semgrep-rules/              # Custom SAST rules
├── checkov-config/             # IaC policies
└── exceptions/                 # Documented exceptions
```

---

## The Tools

### Gitleaks (Secret Scanning)
**Finds:** API keys, passwords, tokens, AWS credentials

**Example block:** ❌ AWS key AKIA... detected

### Semgrep (Code Analysis - SAST)
**Finds:** SQL injection, command injection, XXE, hardcoded secrets

**Example block:** ❌ SQL injection at line 42

### Trivy (Dependency Scanning)
**Finds:** Known vulnerabilities in libraries

**Example block:** ❌ requests 2.20.0 has CVE-2023-32681 (high)

### Checkov (IaC Scanning)
**Finds:** S3 public, security groups wide open, no encryption

**Example block:** ❌ S3 bucket has public-read ACL

---

## Key Learnings

### 1. Shift-Left Security
Catch issues early in development ($100 to fix) vs in production ($1M+ to fix)

### 2. Automation Over Manual
Security shouldn't rely on humans remembering. Let tools do the checking.

### 3. Developer Experience Matters
- Clear error messages
- Links to documentation
- Easy exception process
- Don't make security "the enemy"

### 4. Block Wisely
- **Block:** Secrets, critical vulnerabilities, obvious misconfigs
- **Warn:** Medium/low findings, informational alerts
- Too strict = developers bypass
- Too lenient = vulnerabilities slip through

### 5. Policy as Code
Security rules are code - can version control, review, and track changes

---

## Real-World Usage

This exact pattern is used by:
- ✅ GitHub (Dependabot)
- ✅ Google (Forseti)
- ✅ Netflix (custom tools)
- ✅ AWS (Security Hub)
- ✅ Most enterprises

---

## Documentation

- **[Tool Configuration](docs/tool-configuration.md)** - How each security tool works
- **[Adding Exceptions](docs/adding-exceptions.md)** - How to request security exceptions
- **[Escalation Process](docs/escalation-process.md)** - What to do when pipeline blocks

---

## What This Demonstrates

✅ **Cloud Security** - Understanding infrastructure security
✅ **DevSecOps** - Security is everyone's job
✅ **Automation** - Don't do manual security reviews
✅ **Risk Management** - Catch issues early
✅ **Developer Velocity** - Enable speed through automation

---

## Interview Talking Points

"I built a CI/CD security pipeline using GitHub Actions. It automatically scans every code push for:
- Secrets (hardcoded API keys)
- Code vulnerabilities (SQL injection, etc.)
- Vulnerable dependencies
- Infrastructure misconfigurations
- Container issues

The key insight is **shift-left security**—catch issues early in development when they're cheap to fix, not after deployment when they're expensive.

The pipeline blocks on critical findings but warns on medium/low, so it doesn't slow developers down. I also documented how to request exceptions, so security doesn't become 'the enemy.'"

---

## License

MIT - Use this as a template for your own secure pipelines

---

**Built with:** GitHub Actions, Gitleaks, Semgrep, Trivy, Checkov
**For:** Teams that want security automated, not manual
