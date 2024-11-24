" emacs key bindings (put at the bottom because of C-K)
noremap <C-P> <Up>
noremap <C-N> <Down>
noremap <C-B> <Left>
noremap <C-F> <Right>
noremap <C-E> $
noremap <C-A> ^
" no c-k and c-d for normal

" on mac, use it with "Use Option as Meta Key" OFF, unfortunately it breaks emacs
" <M-F>
inoremap ƒ <Right><Esc>wi
" <M-B>
inoremap ∫ <Right><Esc>bi
inoremap <C-P> <Up>
inoremap <C-N> <Down>
inoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-E> <Esc>A
inoremap <C-A> <Esc>I
inoremap <C-_> <Esc>ui " <C-/> redo
inoremap <C-R> <Esc><C-R>i
inoremap <C-K> <Right><Esc>d$
" instead of C-D
inoremap <C-X> <Right><backspace>
" scroll half page
inoremap <C-U> <Esc><C-U>zzi
inoremap <C-D> <Esc><C-D>zzi

" syntax highlighting
syntax on

" Add header automatically when a .c file is created
au BufNewFile *.c,*.h,*.cpp call Headerr()

" Insert function comment
function! FuncComment()
	:.-1read ~/.funccmt
endfunction
:command Fc :call FuncComment()

" Insert a comment template
function! Comment()
	:.-1read ~/.cmt
endfunction
:command C :call Comment()

" Insert license header
function! Hd()
	:.-1read ~/.headerr
endfunction
:command Headerr :call Headerr()

" All modes in block
" set guicursor=n-v-c-sm-i-ci-ve-r-cr-o:block

" \-g: rg the word under the cursor
nnoremap <leader>g :exe "RG " . expand("<cWORD>")<cr>

" emacs save
inoremap <C-X><C-S> <Esc>:w<CR>i

" next match centered
nmap n nzz
nmap N Nzz

" indent cpp with 2 spaces
autocmd FileType cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set relativenumber
nnoremap <silent> <S-L> :call ToggleRelativeNumber()<CR>
function! ToggleRelativeNumber()
    if &relativenumber == 1
	set norelativenumber
    else
	set relativenumber
    endif
endfunction

" paste without yanking the deleted text
vnoremap p P

" disable C-X for tmux
noremap <C-X> <Nop>

" jump to line start/end
noremap <S-S> ^
noremap <S-D> $

" disable auto commenting
autocmd FileType * setlocal formatoptions-=cro

" quick yank all
nnoremap <C-Y> :%y*<CR>

" fuzzy suggest window navigate
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" arrow key to switch tab
nnoremap <C-Left> gT
nnoremap <C-Right> gt

" encoding
"set bomb
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

" highlight current line
set cursorline

" use , to duplicate command-line commands (use it with normal)
nmap , @:

" fix backspace not working
set backspace=indent,eol,start

set hlsearch
set ignorecase
set ruler
set number

set nowrap

set mouse=a

" auto indentation
" a tab is <length of doing shiftwidth> % <tabstop>
set autoindent
set tabstop=8  " how many columns count as a tab(\t).
set shiftwidth=8 " how many columns to shift when a TAB key is pressed

set wildmenu

" match parenthesis
set showmatch
set autoread

" map quick yank
noremap <S-Y> "+y

nnoremap <S-W> :call ToggleMouse()<CR>
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        echo "Mouse OFF"
    else
        set mouse=a
        echo "Mouse ON"
    endif
endfunction

nnoremap <C-W>w :call ToggleWrap()<CR>
function! ToggleWrap()
	if (&wrap == 1)
		set nowrap
		echo "Wrap OFF"
	else
		set wrap
		echo "Wrap ON"
	endif
endfunction

" find and replace (press * first)
nnoremap <Leader>r :%s///g<Left><Left>

" toggle auto command
nnoremap <S-C> :call ToggleComment()<CR>
function! ToggleComment()
	if stridx(&formatoptions, 'c') != -1
		set formatoptions-=cro
		echo "Auto comment OFF"
	else
		set formatoptions+=cro
		echo "Auto comment ON"
	endif
endfunction

" indenting while not losing visual selection
vnoremap < <gv
vnoremap > >gv

" vim plug
call plug#begin()
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'jonathanfilip/vim-lucius'
call plug#end()

" ==== fzf start ====

" ctrl-p to toggle preview window
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['hidden','ctrl-p']
let g:fzf_layout = { 'window': { 'width': 1, 'height': 1, 'relative': v:true } }

" ctrl-e search file (Ctrl-Entry)
nnoremap <silent> <Leader>f :Files<CR>

" ctrl-s search
nnoremap <silent> <C-S> :RG<CR>

" Disable :Rg
command! -bang Rg call NoRg()
function! NoRg()
	echo "Don't use Rg, use RG instead!"
endfunction

" ==== fzf end ====

" easy-align plugin
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" quotation mark as delimiter
let g:easy_align_delimiters = {
\ 	'"': { 'pattern': '"', 'ignore_groups': ['Comment'] },
\ 	'\': { 'pattern': '\\', }
\ }

" need to be after vim plug
colorscheme lucius
