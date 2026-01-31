# Dotfiles

![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Homebrew](https://img.shields.io/badge/Homebrew-FBB040?style=for-the-badge&logo=homebrew&logoColor=black)
![last-commit](https://img.shields.io/github/last-commit/CubeVic/my-dotfiles/main?style=for-the-badge&logo=github&logoColor=white&color=9900FF)
![repo-size](https://img.shields.io/github/repo-size/CubeVic/my-dotfiles?style=for-the-badge&color=9900FF)
![Made with Love](https://img.shields.io/badge/Made%20with-❤️-red?style=for-the-badge)

Personal macOS development environment. One command to set up a new machine.

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/CubeVic/my-dotfiles/main.svg)](https://results.pre-commit.ci/latest/github/CubeVic/my-dotfiles/main)
---

## Quick Start

```bash
# Clone the repo
git clone https://github.com/CubeVic/my-dotfiles.git ~/.dotfiles

# Run the installer
cd ~/.dotfiles && ./install.sh
```

That's it. The script handles everything automatically.

---

## Installation Options

| Command | Description |
|---------|-------------|
| `./install.sh` | Full install (Homebrew + packages + symlinks) |
| `./install.sh --links` | Symlinks only (skip package installation) |
| `./install.sh --dry-run` | Preview changes without modifying anything |

**Note:** Existing files are backed up to `~/.dotfiles-backup/[timestamp]` before being replaced.

---

## What Gets Installed

### Package Manager
- **Homebrew** — installs all packages below

### CLI Tools
- **Shell:** zsh with Oh-My-Zsh, starship prompt, autosuggestions, syntax highlighting
- **Navigation:** zoxide (smart cd), fzf (fuzzy finder), yazi (file browser)
- **File tools:** bat (cat), eza (ls), fd (find), ripgrep
- **Git:** git, gh (GitHub CLI), lazygit, pre-commit
- **Utilities:** jq, tldr, tree, wget, neovim, tmux

### Development
- **Languages:** Node.js, Python 3.13, Java 21 (via mise)
- **Version management:** mise, pyenv
- **Mobile:** iOS tools (ios-deploy, simulator utils), Android tools (scrcpy)
- **Containers:** Docker CLI completions, k9s (Kubernetes)

### Editors & Terminals
- **VS Code** with 50+ extensions (Git, Python, Docker, Remote, AI)
- **kitty** and **wezterm** terminal emulators
- **Nerd Fonts** (56 fonts for dev icons)

### Security
- 1Password CLI

---

## Configurations Included

| Config | Purpose |
|--------|---------|
| `.zshrc` | Shell config with aliases, plugins, tool integrations |
| `starship.toml` | Modern shell prompt with git status, languages, battery |
| `mise/` | Tool versions (Java, Node) and automation tasks |
| `kitty/` | Terminal theme and settings |
| `vim/` | Vim configuration |
| `brew/Brewfile` | All Homebrew packages and casks |

---

## Useful Commands After Install

### Shell
```bash
szsh        # Reload shell config
c           # Clear terminal
```

### Git Shortcuts
```bash
gst         # git status
gcb <name>  # git checkout -b (new branch)
gpush       # git push
gpull       # git pull
gl          # git log (graph view)
```

### Navigation
```bash
z <dir>     # Smart cd (zoxide)
yy          # File browser (yazi)
```

### Mobile Dev (via mise tasks)
```bash
mise run ios-list       # List iOS simulators
mise run android-list   # List Android emulators
mise run mobile-check   # Validate mobile environment
```

---

## Updating

```bash
# Update all packages
mise run update

# Just Homebrew
mise run update-brew

# Backup current Brewfile
mise run backup-brew
```

---

## Requirements

- macOS (Apple Silicon or Intel)
- Internet connection
- Xcode Command Line Tools (installer will prompt if missing)

---

## Troubleshooting

**Symlink conflicts:** The installer backs up existing files. Check `~/.dotfiles-backup/` if something seems wrong.

**Permission issues:** Run the installer from your user account, not with sudo.

**Missing tools after install:** Close and reopen your terminal, or run `source ~/.zshrc`.
