# Custom Aliases

Aliases defined in `zsh/aliases.zsh`. For oh-my-zsh plugin aliases, see their upstream docs.

## General

| Alias | Command | Notes |
|-------|---------|-------|
| `szsh` | `source ~/.zshrc` | Reload shell config |
| `c` | `clear` | |
| `..` | `cd ..` | |
| `...` | `cd ../..` | |
| `usage` | `du -ah -c --exclude=.git` | Directory size |
| `topten` | `history \| sort -rn \| head -10` | Top commands |
| `dir` | `dirs -v \| head` | Directory stack |

## Git

### General

| Alias | Command | Notes |
|-------|---------|-------|
| `g` | `git` | |
| `gst` | `git status` | |

### Branching

| Alias | Command | Notes |
|-------|---------|-------|
| `gcb` | `git checkout -b` | |
| `gb` | `git branch` | |
| `gnewb` | `gitNewBranch()` | Creates branch from `origin/main` |
| `gdelete` | `git branch --delete` | |
| `grmain` | `git rebase origin/main` | |

### Switching

| Alias | Command | Notes |
|-------|---------|-------|
| `gsw` | `git switch` | |
| `gswmain` | `git switch main` | |
| `gswm` | `git switch master` | |
| `gswd` | `git switch develop` | |

### Merging

| Alias | Command | Notes |
|-------|---------|-------|
| `gmd` | `git merge develop` | |
| `gmc` | `git merge --continue` | |

### Log

| Alias | Command | Notes |
|-------|---------|-------|
| `gl` | `git log --all --oneline --graph --decorate` | |
| `glog` | `git log --color --graph --pretty=format:...` | Detailed log |

### Add & Commit

| Alias | Command | Notes |
|-------|---------|-------|
| `ga` | `git add` | |
| `gco` | `git commit -m` | |
| `gcoa` | `git commit --amend --no-edit` | |
| `gcoa!` | `git commit --amend` | Edit message |

### Push & Pull

| Alias | Command | Notes |
|-------|---------|-------|
| `gpush` | `git push` | |
| `gpush!` | `git push -f` | Force push |
| `gpushup` | `git push -u origin` | Set upstream |
| `gpull` | `git pull` | |
| `gpullf` | `git pull -f` | |
| `gfa` | `git fetch --all` | |

### Stashing

| Alias | Command | Notes |
|-------|---------|-------|
| `gsthm` | `git stash save -m` | |
| `gsthpop` | `git stash pop` | |
| `gsthl` | `git stash list` | |

### Diff

| Alias | Command | Notes |
|-------|---------|-------|
| `gdiff` | `git diff` | |

## Tools

| Alias | Command | Notes |
|-------|---------|-------|
| `gcs` | `gh copilot suggest` | GitHub Copilot CLI |
| `gce` | `gh copilot explain` | GitHub Copilot CLI |
| `appiumL` | `appium --allow-insecure chromedriver_autodownload --allow-cors` | Local Appium server |

## File Associations

| Extension | Opens With |
|-----------|------------|
| `.yaml`, `.yml` | VS Code |

## Aliases in .zshrc

These are defined directly in `.zshrc`, not `aliases.zsh`:

| Alias | Command | Notes |
|-------|---------|-------|
| `ls` | `eza --icons=always` | Better ls with icons |
| `cd` | `z` | Zoxide smart cd |
| `fzfp` | `fzf --preview 'bat ...'` | fzf with bat preview |
| `y` | `yazi` function | File manager with cd on exit |
