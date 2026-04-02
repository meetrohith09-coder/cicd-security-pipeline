# Adding Security Exceptions

## When You Need an Exception

Only in these cases:
1. **False positive** - The finding isn't actually a security issue
2. **Documented risk** - You accept the risk for legitimate business reasons
3. **Technical limitation** - The fix would break something critical

## How to Request an Exception

### Step 1: Document the Exception

Create a file: `policies/exceptions/EXCEPTION-{date}-{tool}.md`

Example: `policies/exceptions/EXCEPTION-2024-02-15-semgrep.md`
```markdown
# Exception Request

**Tool:** Semgrep
**Finding:** SQL Injection - CWE-89
**File:** src/database.py:42
**Date:** 2024-02-15
**Requested By:** Your Name

## Why This Exception?

[Explain why this is acceptable]

## Evidence

[Show that the risk is mitigated by other controls]

## Expiration

This exception expires on 2024-05-15. Review quarterly.

## Approval

- [ ] Team Lead Approval
- [ ] Security Team Approval
```

### Step 2: Add to Exception List
```bash
# For Semgrep, add to semgrep rules
echo "... your exception config ..." >> policies/semgrep-rules/exceptions.yaml
```

### Step 3: Create Pull Request

1. Push your exception and code changes
2. Create PR with exception request
3. Wait for approvals
4. Once approved, pipeline passes

---

## Time-Bound Exceptions

**All exceptions must have an expiration date:**
```markdown
**Expires:** 2024-05-15

Reason: Awaiting upstream patch. Will remove exception when
library version is updated to 2.0.0+
```

## Reviewing Exceptions

**Quarterly (every 3 months):**
1. Review all active exceptions
2. Are they still valid?
3. Extend or resolve

