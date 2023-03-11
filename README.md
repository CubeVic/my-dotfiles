# my-dotfiles
These are my dotfiles. 
It is a mixture of the files use in my work mac and my personal mac, mostly related to cosmetic changes and 0h-my-zsh plug-in.


## What is `git clone --depth 1`
> This is use in the oh-my-zsh plug-in for autocomplete
```shell
% cd ~/Git  # ...or wherever you keep your Git repos/Zsh plugins
% git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
```
When developers perform a `git clone --depth 1` operation, the only thing they pull back from the remote repository is the latest commit on the specific git branch of interest. 
