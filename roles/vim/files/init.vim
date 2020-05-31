set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'
" Keep Plugin commands between vundle#begin/end.
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
set ruler
set number relativenumber
set showcmd
let g:neocomplete#enable_at_startup = 1

let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd vimenter * if !argc() | NERDTree | endif

" Closes NERDTree if it ist last open buffer"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Searches for a hook script localted in $HOME/.local/vimhooks/x.hook", the
" filename gets specified in the 2nd line in the file as a comment
function! RunSaveHook()
	let file = "~/.local/vimhooks/runHook " . expand("%:p")
	echo file
	execute "!" . file
endfunction

" Runs hook on save, if present"
au BufWritePost ~/.config/* call RunSaveHook()
au BufWritePost ~/.homesick/*/home/.config/* call RunSaveHook()
au BufWritePost *.service silent! execute "!systemctl --user daemon-reload" | redraw!

autocmd BufEnter * lcd %:p:h
