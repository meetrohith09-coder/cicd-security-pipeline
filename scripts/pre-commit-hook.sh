#!/bin/bash

# Pre-commit security hook
# This runs BEFORE code is committed locally

echo "🔒 Running pre-commit security checks..."

FAILED=0

# 1. Check for secrets
echo "🔍 Checking for secrets..."
if ! command -v gitleaks &> /dev/null; then
  echo "⚠️  gitleaks not installed, skipping"
else
  gitleaks detect --source local --exit-code 1 --no-banner
  if [ $? -ne 0 ]; then
    echo "❌ BLOCKED: Secrets detected"
    FAILED=1
  fi
fi

# 2. Check for large files
echo "📦 Checking for large files..."
LARGE_FILES=$(find . -size +10M -type f)
if [ ! -z "$LARGE_FILES" ]; then
  echo "❌ ERROR: Large files detected (> 10MB)"
  echo "$LARGE_FILES"
  FAILED=1
fi

# 3. Check for common secrets in code
echo "🔐 Quick secret scan..."
SECRETS=$(git diff --cached | grep -i -E 'password|api_key|secret|token|aws_access_key' | grep -v '\.example' | grep -v 'docs/')
if [ ! -z "$SECRETS" ]; then
  echo "❌ BLOCKED: Potential secrets in code"
  echo "$SECRETS"
  FAILED=1
fi

# Summary
if [ $FAILED -eq 0 ]; then
  echo "✅ All pre-commit checks passed"
  exit 0
else
  echo "❌ Pre-commit checks failed"
  exit 1
fi
