# --- General --------------
alias szsh="source ~/.zshrc | echo 'sourcing .zshrc'"
alias c="clear"
alias ..="cd .."
alias ...="cd ../../"
alias usage="du -ah -c -I .git"
alias topten="history | sort -rn | head -15"
alias dir="dirs -v | head "


# --- Git ---------------
# Functions
gitNewBranch() {
	git checkout -b "$1" origin/main
	echo "New branch '$1' base on origin/main"
}

# General
alias g="git "

# Status
alias gst="git status"

# Switch
alias gswmain="git switch main"
alias gswm="git switch master"
alias gswd="git switch develop"
alias gsw="git switch "

# Merge
alias gmd="git merge develop"
alias gmc="git merge --continue"

# Log
alias gl="git log --all --oneline --graph --decorate"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset --%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset %Cgreen<-%Creset <%cn>' --abbrev-commit --branches --decorate"

# Add & Commit
alias ga="git add "
alias gco="git commit -m"
alias gcoa\!="git commit --amend"
alias gcoa="git commit --amend --no-edit"

# Push
alias gpush="git push "
alias gpush\!="git push -f | echo 'executing git push -f'"
alias gpushup="git push -u origin "

# Pull
alias gpull="git pull"
alias gpullf="git pull -f"
alias gfa="git fetch --all"

# Branches
alias gcb="git chechout -b"
alias gnewb="gitNewBranch "
alias gb="git branch"
alias gdelete="git branch --delete "
alias grmain="git rebase origin/main"

# Stash
alias gsthm="git stash save -m"
alias gsthpop="git stash pop"
alias gsthl="git stash list"

# Diff
alias gdiff="git diff "

# --- Define program to handle extensions
# YAML
alias -s {.ymal, .yml}=code

eval "$(op completion zsh)"
compdef _op op

#---------------------------------------------
