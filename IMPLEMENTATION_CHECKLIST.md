# Mise Migration Implementation Checklist

## Phase 0: Backup & Safety ✅

- [ ] **Create backup branch**
  ```bash
  cd ~/.dotfiles
  git checkout -b backup-pre-mise-$(date +%Y%m%d)
  git add -A
  git commit -m "Backup before mise migration"
  git push -u origin backup-pre-mise-$(date +%Y%m%d)
  ```

- [ ] **Tag current working state**
  ```bash
  git tag -a pre-mise-backup -m "Working state before mise migration"
  git push --tags
  ```

- [ ] **Create restore script**
  - Location: `~/.dotfiles/restore-pre-mise.sh`
  - Should restore .zshrc, remove mise configs
  - Test that you can roll back

- [ ] **Backup current Brewfile**
  ```bash
  cp ~/.dotfiles/brew/Brewfile ~/.dotfiles/brew/Brewfile.backup
  brew bundle dump --force --file=~/.dotfiles/brew/Brewfile
  git diff brew/Brewfile  # Review changes
  ```

---

## Phase 1: Create Mise Configuration Files 📝

- [ ] **Create mise config directory**
  ```bash
  mkdir -p ~/.config/mise
  mkdir -p ~/.dotfiles/mise
  ```

- [ ] **Create `~/.dotfiles/mise/config.toml`**
  - Define tool versions: Java 21, Ruby latest
  - Set JAVA_HOME via `_.java.JAVA_HOME = "{{MISE_INSTALL_PATH}}"` (required for Appium)
  - Set ANDROID_HOME for convenience
  - Configure mise behavior (auto_install, legacy_version_file)

- [ ] **Create `~/.dotfiles/mise/mise.tasks.toml`**
  - Android SDK setup tasks (android-setup, android-install-tools, android-accept-licenses, android-create-avd)
  - iOS/Xcode validation tasks (ios-setup, ios-check-xcode, ios-install-tools, ios-boot-simulator)
  - Appium setup and management tasks (appium-setup, appium-start, appium-doctor with correct syntax)
  - System setup automation tasks (setup, brew-install, symlink-dotfiles)
  - Validation/check tasks (check, check-tools, check-versions, check-paths, mobile-check)
  - Maintenance tasks (update, update-brew, update-mise, backup-brew)

- [ ] **Symlink mise configs from dotfiles repo**
  ```bash
  ln -sf ~/.dotfiles/mise/config.toml ~/.config/mise/config.toml
  ln -sf ~/.dotfiles/mise/mise.tasks.toml ~/.config/mise/mise.tasks.toml
  ls -la ~/.config/mise/  # Verify symlinks
  ```

---

## Phase 2: Refactor .zshrc 🔧

- [ ] **Create backup of current .zshrc**
  ```bash
  cp ~/.dotfiles/.zshrc ~/.dotfiles/.zshrc.backup
  ```

- [ ] **Remove from .zshrc:**
  - [ ] Hardcoded `JAVA_HOME` (lines 49-50)
  - [ ] Pyenv initialization (lines 31-39) - Keep for system Python
  - [ ] Duplicate PATH entries (line 29 vs 61)
  - [ ] Manual Android PATH additions (lines 51-57)
  - [ ] Manual Poetry PATH (line 29 - handled by pipx)

- [ ] **Keep in .zshrc:**
  - [ ] Oh-My-Zsh configuration
  - [ ] Starship prompt
  - [ ] Homebrew in PATH (for global Python/Node)
  - [ ] Pyenv for system Python
  - [ ] Custom aliases/functions (zsh/*.zsh sourcing)
  - [ ] FZF, eza, zoxide
  - [ ] Mise activation (already at line 119)
  - [ ] History configuration
  - [ ] Yazi function
  - [ ] Plugin sources (autosuggestions, syntax-highlighting)

- [ ] **Add mise-managed environment note**
  ```zsh
  # --- Mise Managed Tools ---
  # Java, Ruby, and project-specific tools managed by mise
  # See ~/.config/mise/config.toml for versions
  ```

- [ ] **Verify mise activation is at the end**
  - Should be after pyenv but before the final section

---

## Phase 3: Install Mise-Managed Tools 🛠️

- [ ] **Install Java via mise**
  ```bash
  mise install java@21
  mise use --global java@21
  ```

- [ ] **Verify Java installation**
  ```bash
  mise exec -- java -version
  echo $JAVA_HOME  # Should be mise-managed path like ~/.local/share/mise/installs/java/21.x.x
  # Verify Appium can find Java
  mise exec -- sh -c 'echo "JAVA_HOME=$JAVA_HOME"'
  ```

- [ ] **Install Ruby via mise**
  ```bash
  mise install ruby@latest
  mise use --global ruby@latest
  ```

- [ ] **Verify Ruby installation**
  ```bash
  mise exec -- ruby --version
  which ruby  # Should point to mise shims
  ```

---

## Phase 4: Test on Current Machine ✅

- [ ] **Reload shell configuration**
  ```bash
  exec zsh  # or source ~/.zshrc
  ```

- [ ] **Run mise doctor**
  ```bash
  mise doctor
  ```

- [ ] **Verify tool versions**
  ```bash
  java -version     # Should show JDK 21.x
  ruby --version    # Should show mise-managed Ruby
  python3 --version # Should show Homebrew Python 3.13.x
  node --version    # Should show Homebrew Node 23.x
  ```

- [ ] **Check PATH for duplicates**
  ```bash
  mise tasks run check-paths
  # Or manually: echo "$PATH" | tr ':' '\n' | sort | uniq -d
  ```

- [ ] **Test Android SDK setup task**
  ```bash
  mise tasks run android-setup
  ```

- [ ] **Verify Android environment**
  ```bash
  which adb
  adb --version
  mise tasks run android-create-avd
  ```

- [ ] **Test iOS validation**
  ```bash
  mise tasks run ios-check-xcode
  ```

- [ ] **Test Appium setup and Java integration**
  ```bash
  mise tasks run appium-setup
  appium driver list
  # Test that Appium can find mise-managed Java
  appium driver doctor uiautomator2
  appium driver doctor xcuitest
  # Verify JAVA_HOME is set correctly for Appium
  echo "Appium will use JAVA_HOME: $JAVA_HOME"
  ```

- [ ] **Test custom scripts still work**
  ```bash
  path-vars  # Should run without errors
  y          # Test yazi function
  ```

- [ ] **Test git aliases**
  ```bash
  gst        # git status
  gl         # git log
  ```

---

## Phase 5: Update Documentation 📚

- [ ] **Update README.md**
  - Add mise installation instructions
  - Document new setup process
  - Add troubleshooting section

- [ ] **Create MIGRATION.md**
  - Document changes made
  - Include rollback instructions
  - List breaking changes

- [ ] **Update Brewfile if needed**
  - Remove any packages now managed by mise
  - Add any new dependencies discovered

---

## Phase 6: Commit Changes 💾

- [ ] **Review all changes**
  ```bash
  git status
  git diff
  ```

- [ ] **Stage new files**
  ```bash
  git add mise/
  git add .zshrc
  git add IMPLEMENTATION_CHECKLIST.md
  git add claude.md
  git add MIGRATION.md
  git add README.md
  ```

- [ ] **Create detailed commit**
  ```bash
  git commit -m "Migrate to mise for tool version management

  - Add mise config for Java 21 and Ruby
  - Create mise tasks for Android/iOS/Appium setup
  - Refactor .zshrc to remove hardcoded paths
  - Keep Homebrew Python/Node for system-wide use
  - Add automated setup tasks for mobile development
  - Document migration process and rollback procedure

  Refs: #[issue-number] (if applicable)"
  ```

- [ ] **Create migration tag**
  ```bash
  git tag -a mise-migration-v1 -m "Mise migration completed"
  ```

---

## Phase 7: Test on Fresh/Second Machine 🖥️

- [ ] **Clone dotfiles on test machine**
  ```bash
  git clone <your-repo> ~/.dotfiles
  cd ~/.dotfiles
  ```

- [ ] **Run full setup**
  ```bash
  mise tasks run setup
  ```

- [ ] **Verify all tools installed**
  ```bash
  mise tasks run check
  mise tasks run mobile-check
  ```

- [ ] **Test development workflow**
  - [ ] Start Android emulator (verify JAVA_HOME accessible)
  - [ ] Start Appium server (verify it finds mise Java)
  - [ ] Check Appium recognizes devices
  - [ ] Run sample test (if applicable)

- [ ] **Document any issues encountered**

---

## Phase 8: Finalize & Cleanup 🧹

- [ ] **Remove backup files if everything works**
  ```bash
  rm ~/.dotfiles/.zshrc.backup
  rm ~/.dotfiles/brew/Brewfile.backup
  ```

- [ ] **Push to remote**
  ```bash
  git push origin main
  git push --tags
  ```

- [ ] **Update other machines**
  - Document process in README

- [ ] **Delete backup branch** (after confirming everything works)
  ```bash
  git branch -D backup-pre-mise-YYYYMMDD
  git push origin --delete backup-pre-mise-YYYYMMDD
  ```

- [ ] **Archive this checklist**
  ```bash
  mkdir -p docs/archive
  mv IMPLEMENTATION_CHECKLIST.md docs/archive/
  git add docs/archive/IMPLEMENTATION_CHECKLIST.md
  git commit -m "Archive implementation checklist"
  ```

---

## Rollback Procedure 🔙

If something goes wrong:

```bash
# Option 1: Restore from backup branch
git checkout backup-pre-mise-YYYYMMDD
cp .zshrc ~/.zshrc
cp brew/Brewfile ~/.dotfiles/brew/Brewfile
source ~/.zshrc

# Option 2: Restore from tag
git checkout pre-mise-backup
# Follow same steps as Option 1

# Option 3: Manual restore
bash ~/.dotfiles/restore-pre-mise.sh
```

---

## Success Criteria ✨

- [ ] All tools show correct versions
- [ ] No PATH duplicates
- [ ] JAVA_HOME correctly set by mise (Appium requirement)
- [ ] Android emulator can be created and started via mise tasks
- [ ] Appium starts without errors and finds Java
- [ ] Appium driver doctor passes for both uiautomator2 and xcuitest
- [ ] All existing aliases/functions work
- [ ] New machine can be setup with single command
- [ ] Documentation is clear and complete
- [ ] Rollback procedure tested and works

---

## Notes & Issues 📝

(Add any issues, blockers, or notes during implementation here)

---

**Status**: Not Started
**Created**: 2025-10-12
**Owner**: vktor
**Estimated Time**: 2-3 hours
