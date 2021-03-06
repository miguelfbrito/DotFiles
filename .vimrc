" Ubuntu Setup: vim-gnome package to get ubuntu support for clipboard copy

" Colorscheme
" highlight visual mode
highlight Visual cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40 

set nocompatible
set hlsearch
filetype plugin indent on
syntax on 

let mapleader="\<Space>"
" Markdown-preview
nnoremap <leader>md :MarkdownPreview<CR>

" Vimwiki
nnoremap <leader>wn :VimwikiDiaryNext<CR>
nnoremap <leader>wp :VimwikiDiaryPrevDay<CR>

inoremap jk <Esc>
nnoremap J <C-d>
nnoremap K <C-u>
nnoremap H gT
nnoremap L gt

" Append date at end of line
nnoremap <F5> A<C-r>=strftime(" `(%H:%M %d/%m/%y)`")<CR><Esc>

" save on <c-s>
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a
vnoremap <c-s> <Esc>:w<CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set number relativenumber
set autoindent
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

set showcmd
set encoding=utf-8
set laststatus=2
set autoindent 
set smartindent
set clipboard=unnamedplus
set ignorecase
set linebreak

set ttymouse=xterm2
set mouse=a

set matchpairs+=<:>
hi MatchParen ctermfg=red ctermbg=black  guifg=red guibg=black 
syntax on

nnoremap <C-left> :vertical resize +5<cr>
nnoremap <C-right> :vertical resize -5<cr>
nnoremap <C-up> :resize -5<cr>
nnoremap <C-down> :resize +5<cr>

cnoremap sudow w !sudo tee % > /dev/null

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    autocmd VimEnter * PlugInstall | q
endif

" Plugins
Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install -all'}
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vimwiki/vimwiki'
Plug 'itchyny/calendar.vim'
Plug 'lervag/vimtex'
Plug 'scrooloose/nerdtree'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
call plug#end()

" Vimwiki ✗○◐●✓
let g:vimwiki_list = [{'path': '~/nextcloud/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_listsyms = ' ○◐●✓'
" let g:vimwiki_folding='expr'
autocmd BufRead,BufNewFile *.md setlocal shiftwidth=2 tabstop=2
"autocmd FileType md setlocal shiftwidth=2 tabstop=2
" nnoremap <silent> <leader>wt :e ~/vimwiki/todos.md<CR>

" Opens new Vimwiki diary page from calendar
autocmd FileType calendar nmap <buffer> <CR> :<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V")<CR>
" Creates a new diary page based on a template
au BufNewFile ~/vimwiki/diary/*.md :silent 0r !~/scripts/generate-vimwiki-diary-template.sh '%'

" Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" UltiSnips
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" fzf
"
nnoremap <C-p> :Files<CR>
inoremap <C-p> <Esc>:Files<CR>
