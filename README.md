# my-dotfiles
These are my dotfiles. 
It is a mixture of the files use in my work mac and my personal mac, mostly related to cosmetic changes and 0h-my-zsh plug-in.

# `.zshrc`

## Plugins

```shell
...
plugins=(
git
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

### git

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






## What is `git clone --depth 1`

> This is use in the oh-my-zsh plug-in for autocomplete
```shell
% cd ~/Git  # ...or wherever you keep your Git repos/Zsh plugins
% git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
```
When developers perform a `git clone --depth 1` operation, the only thing they pull back from the remote repository is the latest commit on the specific git branch of interest. 
