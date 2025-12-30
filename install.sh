#!/bin/bash
# =============================================================================
# Dotfiles Installation Script
# =============================================================================
# Usage: ./install.sh
# This script creates symlinks from dotfiles repo to home directory
# Existing files are backed up to ~/.dotfiles-backup/
# =============================================================================

set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Backup and symlink a file
link_file() {
    local src="$1"
    local dest="$2"

    # Skip if already correctly linked
    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
        info "Already linked: $dest"
        return 0
    fi

    # Backup existing file/symlink
    if [[ -e "$dest" || -L "$dest" ]]; then
        mkdir -p "$BACKUP_DIR"
        warn "Backing up: $dest -> $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Create symlink
    ln -sf "$src" "$dest"
    info "Linked: $src -> $dest"
}

echo "============================================="
echo "       Dotfiles Installation Script"
echo "============================================="
echo ""

# Check if dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
    error "Dotfiles directory not found: $DOTFILES_DIR"
    exit 1
fi

# =============================================================================
# Shell Configuration
# =============================================================================
info "Setting up shell configuration..."
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# =============================================================================
# Starship Prompt
# =============================================================================
info "Setting up Starship prompt..."
link_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

# =============================================================================
# Mise (Tool Version Manager)
# =============================================================================
info "Setting up Mise configuration..."
link_file "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
link_file "$DOTFILES_DIR/mise/mise.tasks.toml" "$HOME/.config/mise/mise.tasks.toml"

# =============================================================================
# Vim Configuration
# =============================================================================
info "Setting up Vim configuration..."
link_file "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/vim/.vimrc.plug" "$HOME/.vimrc.plug"

# =============================================================================
# Summary
# =============================================================================
echo ""
echo "============================================="
echo "       Installation Complete!"
echo "============================================="

if [[ -d "$BACKUP_DIR" ]]; then
    warn "Backups saved to: $BACKUP_DIR"
fi

echo ""
info "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Install Homebrew packages: brew bundle --file=$DOTFILES_DIR/brew/Brewfile"
echo "  3. Install mise tools: mise install"
echo ""
