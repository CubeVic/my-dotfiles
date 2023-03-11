
# my-dotfiles

![badge-last-commit](https://img.shields.io/github/last-commit/CubeVic/my-dotfiles/main?color=blue&logo=github&style=flat-square)

These are my dotfiles. 
It is a mixture of the files use in my work mac and my personal mac, mostly related to cosmetic changes and 0h-my-zsh plug-in.

---

# `.zshrc`

## Plugins

```shell
...
plugins=(
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
...
```

### vscode

### pip

### adb

### web-search

### History

repo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history

#### Aliases

| Alias | Command              | Description                                                      |
|-------|----------------------|------------------------------------------------------------------|
| `h`   | `history`            | Prints your command history                                      |
| `hs`  | `history \| grep`    | Use grep to search your command history                          |
| `hsi` | `history \| grep -i` | Use grep to do a case-insensitive search of your command history |

### jsontools

### git-auto-fetch

repo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-auto-fetch

In case we need to enable or disable it per folder:

```shell
$ cd to/your/project
$ git-auto-fetch
disabled
$ git-auto-fetch
enabled
```

### macos

### zsh-autosuggestions

### zsh-interactive-cd

### zsh-syntax-highlighting

---

## Aliases

```shell
alias szsh="source ~/.zshrc | echo 'sourcing .zshrc'"
```

### git Alias

```shell
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
```



## What is `git clone --depth 1`

> This is use in the oh-my-zsh plug-in for autocomplete
```shell
% cd ~/Git  # ...or wherever you keep your Git repos/Zsh plugins
% git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
```
When developers perform a `git clone --depth 1` operation, the only thing they pull back from the remote repository is the latest commit on the specific git branch of interest. 