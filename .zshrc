# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# --- ZSH Themes ---
ZSH_THEME="robbyrussell"

# --- Plugins (reduced from 13 to 8 for faster startup) ---
# Removed: colorize, ruby, poetry, web-search, git-auto-fetch, zsh-interactive-cd
plugins=(
  dotenv              # Load .env files automatically
  vscode              # VS Code CLI shortcuts
  pip                 # Python pip completions
  history             # History search aliases
  jsontools           # JSON manipulation (pp_json, etc.)
  macos               # macOS utilities (ofd, cdf, etc.)
  zsh-autosuggestions # Command suggestions
  zsh-syntax-highlighting # Must be last
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

# --- Fuzzy Finder ---
[ -f ~/.dotfiles/zsh/.fzf.zsh ] && source ~/.dotfiles/zsh/.fzf.zsh
alias fzf="fzf --preview 'bat --style=numbers --color=always {}'"

# --- 1Password CLI (lazy loaded for faster startup) ---
op() {
  unfunction op
  eval "$(command op completion zsh)"
  compdef _op op
  command op "$@"
}

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

# --- Mise (Tool Version Manager) ---
# Manages: Java, Ruby | Sets: JAVA_HOME, ANDROID_HOME, etc.
if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# --- Android SDK PATH (after mise sets ANDROID_HOME) ---
if [[ -n "$ANDROID_HOME" && -d "$ANDROID_HOME" ]]; then
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  export PATH="$PATH:$ANDROID_HOME/emulator"
  export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
fi

# --- Extras --------------------------------------
# make sure the PATHs are unique
typeset -U PATH

#--------- K9S ----------------------------------------------------#
export KUBECONFIG=$PWD/sporty-pub-prod-codebuild.yaml
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
