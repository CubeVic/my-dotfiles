# my-dotfiles

![badge-last-commit](https://img.shields.io/github/last-commit/CubeVic/my-dotfiles/main?style=for-the-badge&logo=github&logoColor=white&color=9900FF)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/CubeVic/my-dotfiles/main.svg)](https://results.pre-commit.ci/latest/github/CubeVic/my-dotfiles/main)

Personal dotfiles for macOS.

## What's Included

- **Shell** — zsh + oh-my-zsh with custom aliases
- **Tools** — mise (Java, Ruby), pyenv, fzf, zoxide
- **Prompt** — Starship
- **Editor** — Vim config, VS Code extensions
- **Packages** — Homebrew Brewfile

## Prerequisites

- macOS
- [Xcode Command Line Tools](https://developer.apple.com/xcode/resources/): `xcode-select --install`
- [Homebrew](https://brew.sh): `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

## Setup

```bash
# Clone
git clone https://github.com/CubeVic/my-dotfiles.git ~/.dotfiles

# Run install script (creates symlinks, backs up existing files)
~/.dotfiles/install.sh

# Install Homebrew packages
brew bundle install --file=~/.dotfiles/brew/Brewfile

# Install mise-managed tools
mise install

# Reload shell
source ~/.zshrc
```

### Manual Symlinks (if not using install.sh)

```bash
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/.dotfiles/mise/config.toml ~/.config/mise/config.toml
ln -sf ~/.dotfiles/vim/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/vim/.vimrc.plug ~/.vimrc.plug
```

## Docs

- [Custom Aliases](docs/ALIASES.md) — shell shortcuts
- [Mise Tasks](docs/TASKS.md) — automation commands
- [Security Notes](docs/SECURITY.md) — audit findings and recommendations
