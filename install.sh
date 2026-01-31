#!/bin/bash
# =============================================================================
# Dotfiles Installation Script - Full Bootstrap
# =============================================================================
# Usage:
#   ./install.sh           # Full install (Homebrew + tools + symlinks)
#   ./install.sh --links   # Symlinks only (skip package installation)
#   ./install.sh --dry-run # Show what would be done
# =============================================================================

set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Parse arguments
LINKS_ONLY=false
DRY_RUN=false
for arg in "$@"; do
    case $arg in
        --links) LINKS_ONLY=true ;;
        --dry-run) DRY_RUN=true ;;
    esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
step()  { echo -e "\n${BLUE}━━━ $1 ━━━${NC}"; }

# Backup and symlink a file
link_file() {
    local src="$1"
    local dest="$2"

    if [[ "$DRY_RUN" == true ]]; then
        echo "  [DRY-RUN] Would link: $src -> $dest"
        return 0
    fi

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

# Check if command exists
has_command() {
    command -v "$1" &>/dev/null
}

echo "============================================="
echo "       Dotfiles Installation Script"
echo "============================================="
if [[ "$DRY_RUN" == true ]]; then
    echo -e "${YELLOW}         (DRY RUN MODE)${NC}"
fi
echo ""

# Check if dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
    error "Dotfiles directory not found: $DOTFILES_DIR"
    exit 1
fi

# =============================================================================
# Step 1: Homebrew Installation
# =============================================================================
if [[ "$LINKS_ONLY" == false ]]; then
    step "Homebrew"

    if has_command brew; then
        info "Homebrew already installed"
    else
        if [[ "$DRY_RUN" == true ]]; then
            echo "  [DRY-RUN] Would install Homebrew"
        else
            info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # Add Homebrew to PATH for this session (Apple Silicon vs Intel)
            if [[ -f "/opt/homebrew/bin/brew" ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [[ -f "/usr/local/bin/brew" ]]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        fi
    fi

    # =============================================================================
    # Step 2: Brew Bundle (packages, casks, fonts)
    # =============================================================================
    step "Brew Packages"

    if [[ -f "$DOTFILES_DIR/brew/Brewfile" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            echo "  [DRY-RUN] Would run: brew bundle --file=$DOTFILES_DIR/brew/Brewfile"
        else
            info "Installing packages from Brewfile..."
            brew bundle --file="$DOTFILES_DIR/brew/Brewfile" --no-lock
        fi
    else
        warn "Brewfile not found, skipping package installation"
    fi

    # =============================================================================
    # Step 3: Mise (Tool Version Manager)
    # =============================================================================
    step "Mise Setup"

    if has_command mise; then
        info "Mise already installed"
    else
        if [[ "$DRY_RUN" == true ]]; then
            echo "  [DRY-RUN] Would install mise"
        else
            info "Installing mise..."
            curl https://mise.run | sh
            # Add mise to PATH for this session
            export PATH="$HOME/.local/bin:$PATH"
        fi
    fi
fi

# =============================================================================
# Step 4: Create Symlinks
# =============================================================================
step "Symlinks"

# Shell configuration
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Starship prompt
link_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

# Mise configuration
link_file "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
link_file "$DOTFILES_DIR/mise/mise.tasks.toml" "$HOME/.config/mise/mise.tasks.toml"

# Vim configuration
link_file "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/vim/.vimrc.plug" "$HOME/.vimrc.plug"

# Kitty terminal (entire directory)
link_file "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"

# =============================================================================
# Step 5: Install Mise Tools
# =============================================================================
if [[ "$LINKS_ONLY" == false ]]; then
    step "Mise Tools"

    if has_command mise; then
        if [[ "$DRY_RUN" == true ]]; then
            echo "  [DRY-RUN] Would run: mise install"
        else
            info "Installing mise-managed tools..."
            mise install --yes
        fi
    else
        warn "Mise not found, skipping tool installation"
    fi
fi

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
if [[ "$LINKS_ONLY" == true ]]; then
    echo "  2. Install Homebrew packages: brew bundle --file=$DOTFILES_DIR/brew/Brewfile"
    echo "  3. Install mise tools: mise install"
fi
echo ""
echo "Verify setup with: mise run check"
echo ""
