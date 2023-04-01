#Alias for the scripts
#

alias path-vars='zsh $HOME/.dotfiles/zsh/scripts/path-vars.zsh'
n() {
    nf="$HOME/Desktop/scratch.md"

    dates=$(date +'%n## %Y-%m-%d %H:%M:%S')
    echo "$dates" >> $nf
    echo -e  ">\n " >> $nf
    vim + -c :$o $nf

}
