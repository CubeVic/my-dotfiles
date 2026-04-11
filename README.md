
# my-dotfiles

![badge-last-commit](https://img.shields.io/github/last-commit/CubeVic/my-dotfiles/main?style=for-the-badge&logo=github&logoColor=white&color=9900FF)

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/CubeVic/my-dotfiles/main.svg)](https://results.pre-commit.ci/latest/github/CubeVic/my-dotfiles/main)

These are my dotfiles.
It is a mixture of the files use in my work mac and my personal mac, mostly related to cosmetic changes and 0h-my-zsh plug-in.

---

# `.zshrc`

## Plugins

> Optimized from 16 to 8 plugins for faster shell startup

```shell
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
```

### dotenv

:house: repo: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dotenv>

"Automatically load your project ENV variables from .env file when you cd into project root directory."-repo README.md

### vscode

:house: repo: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode>

"This plugin provides useful aliases to simplify the interaction between the command line and VS Code or VSCodium editor."-repo README.md

#### vscode Aliases

##### Common aliases

| Alias               | Command      | Description                                                                                    |
| ------------------- | ------------ | ---------------------------------------------------------------------------------------------- |
| vsc                 | code .       | Open the current folder in VS code                                                             |
| vsca `dir`          | code --add `dir`           | Add folder(s) to the last active window                                          |
| vscd `file` `file`  | code --diff `file` `file`  | Compare two files with each other.                                               |
| vscg `file:line[:char]` | code --goto `file:line[:char]` | Open a file at the path on the specified line and character position.    |
| vscn                    | code --new-window              | Force to open a new window.                                              |

##### Extensions aliases

| Alias                   | Command                                                          | Description                       |
| ----------------------- | ---------------------------------------------------------------- | --------------------------------- |
| vsced `dir`             | code --extensions-dir `dir`                                      | Set the root path for extensions. |
| vscie `id or vsix-path` | code --install-extension `extension-id> or <extension-vsix-path` | Installs an extension.            |
| vscue `id or vsix-path` | code --uninstall-extension `id or vsix-path`                     | Uninstalls an extension.          |

#### Other options

| Alias        | Command             | Description                                                                                       |
| ------------ | ------------------- | ------------------------------------------------------------------------------------------------- |
| vscv         | code --verbose      | Print verbose output (implies --wait).                                                            |
| vscl `level` | code --log `level`  | Log level to use. Default is 'info'. Allowed values are 'critical', 'error', 'warn', 'info', 'debug', 'trace', 'off'. |
| vscde        | code --disable-extensions | Disable all installed extensions.                                                           |

### pip

:house: repo: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip>

"This plugin adds completion for pip, the Python package manager."-repo README.md

#### pip Aliases

| Alias    | Description                                   |
| :------- | :-------------------------------------------- |
| pipi     | Install packages                              |
| pipig    | Install package from GitHub repository        |
| pipigb   | Install package from GitHub branch            |
| pipigp   | Install package from GitHub pull request      |
| pipu     | Upgrade packages                              |
| pipun    | Uninstall packages                            |
| pipgi    | Grep through installed packages               |
| piplo    | List outdated packages                        |
| pipreq   | Create requirements file                      |
| pipir    | Install packages from `requirements.txt` file |
| pipupall | Update all installed packages                 |
| pipunall | Uninstall all installed packages              |

### History

:house: repo: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history>

"Provides a couple of convenient aliases for using the history command to examine your command line history."-repo README.md

#### History Aliases

| Alias | Command              | Description                                                      |
|-------|----------------------|------------------------------------------------------------------|
| `h`   | `history`            | Prints your command history                                      |
| `hs`  | `history \| grep`    | Use grep to search your command history                          |
| `hsi` | `history \| grep -i` | Use grep to do a case-insensitive search of your command history |

### jsontools

:house: repo: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jsontools>

"Handy command line tools for dealing with json data."-repo README

#### commands

|  Commands        | Description                                          |
|------------------|------------------------------------------------------|
| `pp_json`        | pretty prints json.                                  |
| `is_json`        |returns true if valid json; false otherwise.          |
| `urlencode_json` |returns a url encoded string for the given json.      |
| `urldecode_json` |returns decoded json for the given url encoded string.|

### macos

:house: repo: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos>

"This plugin provides a few utilities to make it more enjoyable on macOS (previously named OSX)."-repo README.md

#### Commands

Here some of the commands

| Command       | Description                                              |
| :------------ | :------------------------------------------------------- |
| `tab`         | Open the current directory in a new tab                  |
| `split_tab`   | Split the current terminal tab horizontally              |
| `vsplit_tab`  | Split the current terminal tab vertically                |
| `ofd`         | Open the current directory in a Finder window            |
| `pfd`         | Return the path of the frontmost Finder window           |
| `pfs`         | Return the current Finder selection                      |
| `cdf`         | `cd` to the current Finder directory  (formorst window)  |
| `quick-look`  | Quick-Look a specified file                              |
| `man-preview` | Open man pages in Preview app                            |
| `spotify`     | Control Spotify and search by artist, album, track…      |
| `rmdsstore`   | Remove .DS_Store files recursively in a directory        |
| `btrestart`   | Restart the Bluetooth daemon                             |
| `freespace`   | Erases purgeable disk space with 0s on the selected disk |

### zsh-autosuggestions

:house: repo: <https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md>

### zsh-syntax-highlighting

:house: repo: <https://github.com/zsh-users/zsh-syntax-highlighting>

"Fish shell-like syntax highlighting for Zsh."-repo README.md

---
## What is `git clone --depth 1`

> This is use in the oh-my-zsh plug-in for autocomplete

```shell
% cd ~/Git  # ...or wherever you keep your Git repos/Zsh plugins
% git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
```

When developers perform a `git clone --depth 1` operation, the only thing they pull back from the remote repository is the latest commit on the specific git branch of interest.

Change log
---- 1
