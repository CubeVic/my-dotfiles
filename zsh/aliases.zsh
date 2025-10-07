# --- General ---
alias szsh="source ~/.zshrc && echo 'Reloaded .zshrc'"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias usage="du -ah -c --exclude=.git"
alias topten="history | sort -rn | head -15"
alias dir="dirs -v | head"

# --- Git ---------------
# Functions
gitNewBranch() {
	git checkout -b "$1" origin/main
	echo "New branch '$1' base on origin/main"
}

# --- Git ---
# General
alias g="git"
alias gst="git status"

# Branching
alias gcb="git checkout -b"
alias gb="git branch"
alias gnewb="gitNewBranch"
alias gdelete="git branch --delete"
alias grmain="git rebase origin/main"

# Switching
alias gsw="git switch"
alias gswmain="git switch main"
alias gswm="git switch master"
alias gswd="git switch develop"

# Merging
alias gmd="git merge develop"
alias gmc="git merge --continue"

# Log
alias gl="git log --all --oneline --graph --decorate"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset --%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"

# Add & Commit
alias ga="git add"
alias gco="git commit -m"
alias gcoa="git commit --amend --no-edit"
alias gcoa!="git commit --amend"

# Push & Pull
alias gpush="git push"
alias gpush!="git push -f && echo 'Forced push executed'"
alias gpushup="git push -u origin"
alias gpull="git pull"
alias gpullf="git pull -f"
alias gfa="git fetch --all"

# Stashing
alias gsthm="git stash save -m"
alias gsthpop="git stash pop"
alias gsthl="git stash list"

# Diff
alias gdiff="git diff"

#copilot
alias gcs="gh copilot suggest"
alias gce="gh copilot explain"

#appium
alias appiumL='appium --allow-insecure chromedriver_autodownload --allow-cors' 

# --- Define program to handle extensions
# YAML
alias -s {.ymal, .yml}=code

#---------------------------------------------
