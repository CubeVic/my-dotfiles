#Alias for the scripts
#

alias path-vars='zsh $HOME/.dotfiles/zsh/scripts/path-vars.zsh'
# Quick note-taking function - appends timestamped entry to scratch file
n() {
    nf="$HOME/Desktop/scratch.md"
    dates=$(date +'%n## %Y-%m-%d %H:%M:%S')
    echo "$dates" >> $nf
    echo -e ">\n " >> $nf
    vim + $nf  # Open at end of file
}
