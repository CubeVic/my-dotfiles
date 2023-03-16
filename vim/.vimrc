" Compatibility mode
set nocompatible

" set wrap text
set wrap

" Encoding 
set encoding=utf-8

" Set line numbers 
set number

" Set status bar
set laststatus=2

" Call the .vimrc.plug file 
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif
