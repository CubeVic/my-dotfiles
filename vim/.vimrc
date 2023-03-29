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
syntax on

" Let NERDTree see dotfiles
let NERDTreeShowHidden=1

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set foldlevelstart=20

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

" Call the .vimrc.plug file
if filereadable(expand("~/.vim/.vimrc.plug"))
	source ~/.vim/.vimrc.plug
endif
