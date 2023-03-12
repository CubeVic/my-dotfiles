
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZHS Theme
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/

plugins=(
colorize
dotenv
ruby
poetry
vscode
pip
adb
web-search
history
jsontools
git-auto-fetch
macos
zsh-autosuggestions
zsh-interactive-cd
zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# Configuration for pyenv

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Config to activate virtual env automatically after navigate to folder 
eval "$(pyenv virtualenv-init -)"

# Start starship shell prompt
eval "$(starship init zsh)"

# Configuration for verify commmit using gpg keys
export GPG_TTY=$(tty)

# Configuretion for Appium
# Java location
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home
# Android location
export ANDROID_HOME=/Users/vktor/Library/Android/sdk
#adding to the PATH
export PATH=$JAVA_HOME:$PATH
export PATH="/Users/vktor/Library/Android/sdk/platform-tools":$PATH
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH

export OPENCV$NODEJS_DISABLE_AUTOBUILD=1

# Created by `pipx` on 2023-03-07 07:28:20
export PATH="$PATH:/Users/vktor/.local/bin"

# to use fzf plug-in
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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

# --------This most be at the end of the file ---------------------#
# Configuration for zhs syntax highlighting
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
