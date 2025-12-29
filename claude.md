# .dotfiles - Claude Code Memory

## Project Overview

**Repository**: Personal dotfiles for cross-machine development environment consistency
**Owner**: vktor
**Purpose**: Automated setup of development tools, shell configuration, and mobile development environment (Android/iOS + Appium)
**Status**: In migration to mise-en-place for tool version management

---

## Current State (as of 2025-10-12)

### Repository Structure
```
.dotfiles/
├── .zshrc                      # Main shell config (121 lines, needs refactoring)
├── starship.toml               # Cross-shell prompt configuration
├── brew/
│   └── Brewfile                # 267 formulas + 71 casks + VSCode extensions
├── vim/
│   ├── .vimrc                  # Vim configuration
│   └── .vimrc.plug             # Vim plugins
├── zsh/
│   ├── aliases.zsh             # Git aliases, general shortcuts
│   ├── scripts.zsh             # Custom functions (note-taking)
│   ├── .fzf.zsh                # Fuzzy finder config
│   └── scripts/
│       └── path-vars.zsh       # PATH display utility
└── mise/                       # (TO BE CREATED) Mise configuration
    ├── config.toml             # Tool versions and environment
    └── mise.tasks.toml         # Automated setup tasks
```

### Installed Tools (System State)

**Package Managers**:
- Homebrew: 267 formulas, 71 casks
- pipx: 4 packages (fb-idb, poetry 2.1.2, pokemon-terminal, ruff 0.11.13)
- mise: 2025.10.7 (installed, activated in .zshrc:119, but NOT configured yet)

**Language Runtimes**:
- Python: 3.13.5 (Homebrew) + pyenv (virtualenv: wap_esther)
- Node: v23.7.0, npm 10.9.2 (Homebrew)
- Java: JDK 21.0.8 at `/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home`
- Ruby: system (/usr/bin/ruby)

**Mobile Development**:
- Android SDK: ~/Library/Android/sdk (manually installed, NOT via Android Studio)
  - Command-line tools v19.0
  - Platform-tools v36.0 (adb)
  - Build-tools v36.0.0
  - Android API 36 platform
  - Emulator v35.6.11
  - System image: ARM64 Google Play
  - Working AVD: "Medium_Phone_API_36.0"
- Xcode: 16.2 (Build 16C5032a)
  - Command Line Tools at /Applications/Xcode.app/Contents/Developer
  - ios-deploy, carthage (Homebrew)

**Shell**:
- zsh with Oh-My-Zsh (robbyrussell theme, but overridden by Starship)
- Starship prompt (configured via starship.toml)
- Plugins: zsh-autosuggestions, zsh-syntax-highlighting

---

## Key Problems Identified

### 1. Configuration Drift
- Hardcoded `JAVA_HOME` breaks on machines with different Java versions/paths (.zshrc:49)
- Android SDK paths hardcoded, no validation if directories exist (.zshrc:51-57)
- No version locking for Node, Python, Java - machines drift over time

### 2. PATH Management Issues
- `$HOME/.local/bin` added twice (.zshrc:29 and :61)
- Multiple redundant Android PATH additions
- No deduplication until line 89 (`typeset -U PATH`)

### 3. Tool Version Management
- Java: Hardcoded to JDK 21 path
- Python: Conflict between pyenv and Homebrew installations
- Node/Ruby: No version management
- No `.tool-versions` or similar for reproducibility

### 4. Mise Paradox
- Mise installed and activated (.zshrc:119)
- `~/.config/mise/` directory doesn't exist
- No mise configuration files
- Not managing any tools yet

---

## Migration Plan: Mise-en-place

### Design Decisions

**What Mise Will Manage**:
- ✅ Java: Version 21.x (mise auto-detects latest 21.x patch)
  - **Critical**: Mise must set `JAVA_HOME` environment variable for Appium compatibility
  - Config: `_.java.JAVA_HOME = "{{MISE_INSTALL_PATH}}"`
  - Path: `~/.local/share/mise/installs/java/21.x.x/`
- ✅ Ruby: Latest stable
- ✅ Project-specific tool versions (future use)

**What Stays with Homebrew**:
- ✅ Python 3.13.x (system-wide, needed for pipx, global tools)
- ✅ Node 23.x (system-wide, needed for global npm packages like Appium)
- ✅ All other formulas/casks (eza, bat, fzf, etc.)
- Reason: Dotfiles are for whole system, not project-specific

**Android SDK Strategy**:
- ❌ Android Studio NOT required (bloated, unnecessary)
- ✅ Use Homebrew `android-commandlinetools` cask
- ✅ Install to: `/opt/homebrew/share/android-commandlinetools/` (Homebrew standard)
- ✅ Symlink to: `~/Library/Android/sdk` (Appium expects this)
- ✅ Use `sdkmanager` CLI for all SDK component management

**iOS/Xcode Strategy**:
- ⚠️ Xcode MUST be installed manually from App Store (no CLI install available)
- ✅ Mise task validates Xcode is present
- ✅ Automated install of ios-deploy, carthage via Homebrew

**Appium Setup**:
- ✅ Install via npm globally: `npm install -g appium`
- ✅ Mise tasks install drivers: `appium driver install uiautomator2 xcuitest`
- ✅ Correct doctor syntax: `appium driver doctor uiautomator2` (not old `appium-doctor --android`)
- ⚠️ **Critical**: Appium requires `JAVA_HOME` environment variable to be set

### Mise Tasks Architecture

**Task Categories**:
1. **System Setup** (`setup`, `brew-install`, `symlink-dotfiles`, `setup-shell`)
2. **Android** (`android-setup`, `android-install-tools`, `android-accept-licenses`, `android-create-avd`)
3. **iOS** (`ios-setup`, `ios-check-xcode`, `ios-install-tools`, `ios-boot-simulator`)
4. **Appium** (`appium-setup`, `appium-start`, `appium-doctor`)
5. **Validation** (`check`, `check-tools`, `check-versions`, `check-paths`, `mobile-check`)
6. **Maintenance** (`update`, `update-brew`, `update-mise`, `backup-brew`)

**Single File Approach**:
- All tasks in `~/.config/mise/mise.tasks.toml`
- Easier to maintain for personal dotfiles
- Can split later if grows too large

### Refactored .zshrc Structure

**Target: ~60 lines** (down from 121)

```
1. Oh-My-Zsh initialization
2. Homebrew PATH (for system Python/Node)
3. Pyenv setup (for system Python management)
4. Starship prompt
5. GPG TTY
6. Pipx PATH (single entry)
7. FZF integration
8. 1Password CLI
9. Custom scripts sourcing (zsh/*.zsh)
10. Modern CLI tools (eza, zoxide)
11. Mise activation (manages Java, Ruby)
12. PATH deduplication
13. History configuration
14. Yazi function
15. Plugin sources (autosuggestions, syntax-highlighting)
```

**Removed**:
- Hardcoded JAVA_HOME
- Android SDK PATH manipulation
- Duplicate PATH entries
- Poetry PATH (handled by pipx)

---

## Implementation Status

**Phase**: Planning Complete
**Next Action**: Execute Phase 0 of IMPLEMENTATION_CHECKLIST.md
**Estimated Time**: 2-3 hours total

**Checklist Progress**: 0/8 phases complete
See: `IMPLEMENTATION_CHECKLIST.md`

---

## Testing Strategy

### Phase 1: Current Machine (Extra Careful)
1. Create backup branch: `backup-pre-mise-$(date +%Y%m%d)`
2. Create git tag: `pre-mise-backup`
3. Test each phase incrementally
4. Verify all existing workflows still work
5. Can rollback at any point

### Phase 2: Second Machine
1. Test clean install from mise-migrated dotfiles
2. Validate `mise tasks run setup` works end-to-end
3. Document any issues found

### Success Criteria
- ✅ All tools show correct versions
- ✅ No PATH duplicates
- ✅ Android emulator works via mise tasks
- ✅ Appium starts without errors
- ✅ Existing aliases/functions work
- ✅ New machine setup: single command
- ✅ Rollback tested and works

---

## Important Commands Reference

### Mise
```bash
mise install              # Install tools from config.toml
mise use --global <tool>  # Set global tool version
mise tasks run <task>     # Execute mise task
mise doctor               # Validate mise setup
mise ls                   # List installed tools
```

### Android SDK (without Android Studio)
```bash
# sdkmanager location
~/Library/Android/sdk/cmdline-tools/latest/bin/sdkmanager

# Install components
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"

# Accept licenses
yes | sdkmanager --licenses

# Create AVD
avdmanager create avd --name <name> --package <system-image> --device <device-id>

# List AVDs
avdmanager list avd
```

### Appium (Modern Syntax)
```bash
# Install drivers
appium driver install uiautomator2
appium driver install xcuitest

# Check driver health (NEW SYNTAX)
appium driver doctor uiautomator2
appium driver doctor xcuitest

# List drivers
appium driver list

# Start server
appium --allow-insecure chromedriver_autodownload --allow-cors
```

### Brew
```bash
brew bundle dump --force --file=~/.dotfiles/brew/Brewfile  # Update Brewfile
brew bundle install --file=~/.dotfiles/brew/Brewfile       # Install from Brewfile
```

### Git (Dotfiles)
```bash
cd ~/.dotfiles
git status
git add .
git commit -m "message"
git push origin main
```

---

## Known Issues & Gotchas

### Current Issues
1. `.zshrc` modified but not committed (git status shows `M .zshrc`)
2. Mise installed but not configured - activation line exists but no config files
3. Path duplicates not resolved yet

### Android SDK Gotchas
- **DO NOT** use `brew install android-sdk` (deprecated, broken)
- **USE** `brew install --cask android-commandlinetools`
- Emulator needs system image installed: `system-images;android-36;google_apis_playstore;arm64-v8a`
- AVD creation requires accepting licenses first

### Java & Appium Gotchas
- macOS may have multiple Java installations: `/Library/Java/JavaVirtualMachines/`
- System Java: `/usr/libexec/java_home` shows current default
- Mise-managed Java: `~/.local/share/mise/installs/java/`
- JAVA_HOME must point to `/Contents/Home` subdirectory on macOS
- **Critical for Appium**: `JAVA_HOME` environment variable MUST be set
  - Appium documentation explicitly requires this
  - Mise does NOT automatically set JAVA_HOME
  - Solution: Configure in mise config.toml using `_.java.JAVA_HOME = "{{MISE_INSTALL_PATH}}"`
  - Without this, Appium driver doctor will fail
- Current .zshrc hardcodes JAVA_HOME (line 49) - this will be replaced by mise

### Xcode Gotchas
- Must be installed from App Store (14-15GB download)
- First run: `sudo xcode-select --switch /Applications/Xcode.app`
- Accept license: `sudo xcodebuild -license accept`
- Command Line Tools separate: `xcode-select --install`

---

## Context for Future Sessions

### What This Project Does
Automates development environment setup across multiple machines. User is a mobile test engineer working with Appium (Android + iOS). Needs consistent tool versions, shell configuration, and ability to quickly setup new machines.

### Current Pain Point
Configuration has drifted between machines due to:
- Hardcoded paths (Java, Android SDK)
- No version locking
- Manual setup steps
- Different Java versions breaking .zshrc
- Appium requires JAVA_HOME but current setup hardcodes it

### Solution
Migrate to mise-en-place for:
- Declarative tool version management
- Dynamic JAVA_HOME configuration (no hardcoding)
- Automated setup via mise tasks
- Single command to setup new machine
- Validation tasks to check configuration
- Rollback capability

### Key Technical Challenge Solved
**Question**: Will mise-managed Java work with Appium?
**Answer**: YES, with proper configuration
- Appium requires `JAVA_HOME` environment variable
- Mise does NOT auto-set JAVA_HOME by default
- Solution: Add to mise config.toml: `_.java.JAVA_HOME = "{{MISE_INSTALL_PATH}}"`
- This dynamically sets JAVA_HOME to mise's Java installation path
- Eliminates hardcoded paths while satisfying Appium requirements

### User Preferences
- Conservative approach (backup everything, test carefully)
- Wants automation but not magic (understands what's happening)
- Comfortable with CLI/bash
- Values documentation
- Needs Android/iOS/Appium working reliably

### Next Steps When Resuming
1. Check IMPLEMENTATION_CHECKLIST.md for current phase
2. Review any notes in "Notes & Issues" section of checklist
3. Verify backup branch exists before making changes
4. Ask user if any issues occurred since last session

---

## File Change Log

| File | Status | Purpose |
|------|--------|---------|
| `.zshrc` | Modified (uncommitted) | Main shell config - needs refactoring |
| `IMPLEMENTATION_CHECKLIST.md` | Created (updated) | Step-by-step migration guide with JAVA_HOME notes |
| `claude.md` | Created (updated) | This file - project memory with Appium/Java solution |
| `mise/config.toml` | Not created yet | Mise tool versions + JAVA_HOME config |
| `mise/mise.tasks.toml` | Not created yet | Automated setup tasks |
| `MIGRATION.md` | Not created yet | Migration documentation |
| `restore-pre-mise.sh` | Not created yet | Rollback script |

---

## Quick Start for New Claude Session

1. **Context**: User migrating dotfiles to mise for cross-machine consistency
2. **Current Phase**: Planning complete, ready to start Phase 0 (backup)
3. **Check First**: `git status` - is backup branch created?
4. **Reference**: Read IMPLEMENTATION_CHECKLIST.md for next steps
5. **Critical Info**: Appium requires JAVA_HOME - mise config must include `_.java.JAVA_HOME = "{{MISE_INSTALL_PATH}}"`
6. **Ask**: "Should we continue with Phase 0 (creating backups)?"

---

**Last Updated**: 2025-10-12
**Claude Session**: Initial planning, analysis, and Appium/Java compatibility research
**Git Branch**: main (backup branch not yet created)
**Key Decision**: Mise will manage Java with dynamic JAVA_HOME for Appium compatibility
