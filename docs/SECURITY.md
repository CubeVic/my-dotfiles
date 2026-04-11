# Security Notes

Security audit conducted 2026-04-11. This document tracks findings and recommendations for keeping this dotfiles repo safe.

## Audit Findings

### Current Status: CLEAN

No secrets, API keys, or credentials found in committed files.

### Resolved Issues

| Issue | File | Resolution |
|-------|------|------------|
| Hardcoded username in path | `.zshrc:3` | Changed `/Users/vic` to `$HOME` |

### Sensitive Files NOT in Repo (Correct)

These files exist locally but are correctly excluded:
- SSH keys (`~/.ssh/id_*`)
- GPG keys
- `.env` files
- VS Code settings (`.vscode/`)

## .gitignore Review

### Currently Ignored (Good)

- `.env`, `.venv`, `env/`, `venv/` — environment files
- `.vscode` — editor settings
- `*.log` — log files
- `.DS_Store` — macOS metadata

### Recommended Additions

Consider adding these patterns to `.gitignore`:

```gitignore
# SSH
.ssh/

# AWS
.aws/
*credentials*
*.pem

# GPG
*.gpg
*.asc
secring.*

# 1Password
.op/

# Kubernetes
.kube/
kubeconfig*

# Cloud CLI caches
.azure/
.config/gcloud/

# Terraform
*.tfstate
*.tfstate.*
.terraform/

# General secrets
*secret*
*password*
*.key
!*.keyboard
```

## Files to NEVER Commit

| Pattern | Reason |
|---------|--------|
| `~/.ssh/*` (except config patterns) | Private keys |
| `~/.gnupg/*` | GPG private keys |
| `~/.aws/credentials` | AWS access keys |
| `*.env` files with values | API keys, passwords |
| `~/.kube/config` with tokens | Cluster credentials |
| Any file with `password`, `secret`, `token` in content | Credentials |

## SSH Config Considerations

The `~/.ssh/config` file is safe to version IF it contains only:
- Host aliases and connection settings
- Generic patterns (like `*.amazonaws.com`)
- References to key files (paths, not keys themselves)

Current SSH config references:
- `~/.ssh/id_ed25519` — path only, key not committed
- Generic AWS EC2 host pattern — safe

## Infrastructure Leak Check

### Scanned For

- IP addresses: None found
- Internal hostnames: None found
- Company/org references: None found
- Private repo URLs: None found

### Tool Configs Reviewed

| File | Status |
|------|--------|
| `starship.toml` | Clean — cosmetic only |
| `mise/config.toml` | Clean — standard paths |
| `brew/Brewfile` | Clean — public packages |
| `.pre-commit-config.yaml` | Clean — public repos |

## Recommendations

### Add Secret Detection to Pre-commit

Add to `.pre-commit-config.yaml`:

```yaml
- repo: https://github.com/gitleaks/gitleaks
  rev: v8.18.0
  hooks:
    - id: gitleaks
```

Or use detect-secrets:

```yaml
- repo: https://github.com/Yelp/detect-secrets
  rev: v1.4.0
  hooks:
    - id: detect-secrets
      args: ['--baseline', '.secrets.baseline']
```

### Before Sharing This Repo

1. Audit `.zshrc` for any work-specific aliases or paths
2. Check `brew/Brewfile` for internal/private taps
3. Review any prompt configs for identifying information
