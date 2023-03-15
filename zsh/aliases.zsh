# ----------------------
# Alias   --------------
alias szsh="source ~/.zshrc | echo 'sourcing .zshrc'"

### git Alias ---------------

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
#----VPN Alias -------------------------------
connectVPN(){
tunnelblickctl connect openvpn-testonly
password=$(op item get "Test only VPN - qa06 - Victor" --vault "QA VPN - SportyBet" --fields label=password)
password_NO_TRAIL_SPACE="$(echo -e "${password}" | xargs )"
echo $password_NO_TRAIL_SPACE | tr -d "\n" | pbcopy
}

alias ovpn=connectVPN
