" Compatibility mode
set nocompatible

" set wrap text
set wrap

" Encoding
set encoding=UTF-8

" Set line numbers
set number

" Set status bar
set laststatus=2

" Set syntax
syntax enable

" Let NERDTree see dotfiles
let NERDTreeShowHidden=1

" Call the .vimrc.plug file
if filereadable(expand("~/.vim/.vimrc.plug"))
	source ~/.vim/.vimrc.plug
endif
