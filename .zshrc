# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# --- ZSH Themes ---
ZSH_THEME="robbyrussell"

# --- Plugins ---
plugins=(
  colorize
  dotenv
  ruby
  poetry
  vscode
  pip
  web-search
  history
  jsontools
  git-auto-fetch
  macos
  zsh-autosuggestions
  zsh-interactive-cd
  zsh-syntax-highlighting
)

# Load Oh-My-Zsh
source "$ZSH/oh-my-zsh.sh"

# --- PATH ---
export PATH="/opt/homebrew/bin:$HOME/.local/bin/poetry:$HOME/.local/bin:$PATH"

# --- Pyenv ---
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv >/dev/null 2>&1; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  if command -v pyenv-virtualenv-init >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# --- Starship Prompt ---
eval "$(starship init zsh)"

# --- GPG Keys ---
export GPG_TTY=$(tty)

# --- APPIUM -------------------------------------------

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home
export PATH=$JAVA_HOME:"$PATH"
export ANDROID_HOME="$HOME"/Library/Android/sdk
export ANDROID_PLATFORM_TOOLS="$ANDROID_HOME"/platform-tools
export ANDROID_EMULATOR="$ANDROID_HOME"/emulator
export ANDROID_TOOLS="$ANDROID_HOME"/tools
export ANDROID_TOOLS_BIN="$ANDROID_TOOLS"/bin
export PATH="$PATH:$ANDROID_HOME:$ANDROID_PLATFORM_TOOLS:$ANDROID_EMULATOR:$ANDROID_TOOLS:$ANDROID_TOOLS_BIN"

# --- PIPX ---
# Added by pipx
export PATH="$HOME/.local/bin:$PATH"

# --- Fuzzy Finder ---
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh
alias fzf="fzf --preview 'bat --style=numbers --color=always {}'"

# --- 1Password CLI ---
eval "$(op completion zsh)"
compdef _op op

# --- Custom Scripts ---
if [ -d "$HOME/.dotfiles/zsh" ] && compgen -G "$HOME/.dotfiles/zsh/*.zsh" > /dev/null; then
  for conf in "$HOME/.dotfiles/zsh/"*.zsh; do
    source "${conf}"
  done
fi
unset conf

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# --- Extras --------------------------------------
# make sure the PATHs are unique
typeset -U PATH

# --------This most be at the end of the file ---------------------#

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# --- yazi conf ----
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
} # start yazi with y and close with q
# Configuration for zhs syntax highlighting
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
