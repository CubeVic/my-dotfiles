
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZHS Theme
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

VSCODE=code

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

# adding poetry to the path 
export PATH=$PATH:${HOME:-Users/vktor}/.local/bin/poetry

# Configuration for verify commmit using gpg keys
export GPG_TTY=$(tty)

#--------- Appium

# Java location
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home
# Android location
export ANDROID_HOME=$HOME/Library/Android/sdk
#adding to the PATH
export PATH=$JAVA_HOME:$PATH
export PATH="$HOME/Library/Android/sdk/platform-tools":$PATH
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH

# export OPENCV$NODEJS_DISABLE_AUTOBUILD=1

# Created by `pipx` on 2023-03-07 07:28:20
export PATH="$PATH:/Users/vktor/.local/bin"

# to use fzf plug-in
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Configuration for auto complete 1password
eval "$(op completion zsh)"; compdef _op op

# Only run when a new terminal is open.
# source components 
for conf in "$HOME/.dotfiles/zsh/"*.zsh; do
    source "${conf}"
done
unset conf

# other change


# make sure the PATHs are unique
typeset -U PATH

# --------This most be at the end of the file ---------------------#
# Configuration for zhs syntax highlighting
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
