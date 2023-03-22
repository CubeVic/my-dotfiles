# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# --- ZHS Themes --------------------------------
#
# ZHS Theme
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# --- VSCODE ------------------------------------
# set the edition/type of VSCODE
VSCODE=code

# --- Plugins -----------------------------------
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

# --- ZSH running oh-my-zsh -----------------------
source "$ZSH"/oh-my-zsh.sh

# --- Brew -----------------------------------------
export BREW=/opt/homebrew/bin
export PATH="$BREW":"$PATH"

# --- Pyenv ----------------------------------------
# Configuration for pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Config to activate virtual env automatically after navigate to folder
eval "$(pyenv virtualenv-init -)"

# --- Starship prompt -------------------------------
# Start starship shell prompt
eval "$(starship init zsh)"

# --- Poetry -----------------------------------------
# adding poetry to the path
export PATH="$PATH":"${HOME:-Users/vktor}"/.local/bin/poetry

# --- GPG keys ----------------------------------------
# Configuration for verify commmit using gpg keys
export GPG_TTY=$(tty)

# --- APPIUM -------------------------------------------
# PATH Variables for Appium

# Java location
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home

export PATH=$JAVA_HOME:"$PATH"

# Android location
export ANDROID_HOME="$HOME"/Library/Android/sdk
export ANDROID_PLATFORM_TOOLS="$ANDROID_HOME"/platform-tools
export ANDROID_EMULATOR="$ANDROID_HOME"/emulator
export ANDROID_TOOLS="$ANDROID_HOME"/tools
export ANDROID_TOOLS_BIN="$ANDROID_TOOLS"/bin

export PATH="$PATH":"$ANDROID_HOME"
export PATH="$PATH":"$ANDROID_PLATFORM_TOOLS"
export PATH="$PATH":"$ANDROID_EMULATOR"
export PATH="$PATH":"$ANDROID_TOOLS"
export PATH="$PATH":"$ANDROID_TOOLS_BIN"

# export OPENCV$NODEJS_DISABLE_AUTOBUILD=1

# --- PIPX --------------------------------
# Created by `pipx` on 2023-03-07 07:28:20
export PATH="$PATH:/Users/vktor/.local/bin"

# --- Fuzzy finder
# shellcheck source=$HOME/.zsh/
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh

# --- OP or 1Password command line -------------
# Configuration for auto complete 1password
eval "$(op completion zsh)"
compdef _op op

# --- Custom alias or scripts -------------------
# source components
for conf in "$HOME/.dotfiles/zsh/"*.zsh; do
	# shellcheck source=$HOME/.dotfiles/zsh/
	source "${conf}"
done
unset conf

# --- Extras --------------------------------------
# make sure the PATHs are unique
typeset -U PATH

# --------This most be at the end of the file ---------------------#
# Configuration for zhs syntax highlighting
source "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source "$HOME"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
