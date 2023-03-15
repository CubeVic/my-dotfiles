#  General Alias   --------------
alias szsh="source ~/.zshrc | echo 'sourcing .zshrc'"
alias c="clear"

## remap exa to ls
alias l="exa -l"
alias ls="exa -l -a"
alias ls-i="exa -l -a --icons"


# suffix to define application handler base in extension 
alias -s {.ymal, .yml}=code

# git Alias ---------------

alias gsw="git switch main"
alias gsw!="git switch "

alias gst="git status"
alias gl="git log --all --oneline --graph --decorate"
alias ga="git add "
alias gco="git commit -m"
alias gcoa\!="git commit --amend"
alias gcoa="git commit --amend --no-edit"
alias gpush="git push "
alias gpush\!="git push -f | echo 'executing git push -f'"
alias gpushup="git push -u origin "
alias gpull="git pull"
alias gcb="git chechout -b"

gitNewBranch(){
    git checkout -b $1 origin/main
    echo "New branch '$1' base on origin/main"
}

alias gnewb="gitNewBranch "
alias gb="git branch"
alias gdelete="git branch --delete "
alias grmain="git rebase origin/main"

alias gshm="git stash save -m"
alias gshpop="git stash pop"
alias gshl="git stash list"

eval "$(op completion zsh)"; compdef _op op

#---------------------------------------------

