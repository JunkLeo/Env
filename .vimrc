call plug#begin('~/.vim/plugged')
"Appearance
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'mechatroner/rainbow_csv'
"File Tree
Plug 'scrooloose/nerdtree'
"Syntax Highlight
Plug 'sheerun/vim-polyglot'
"AutoPairs
Plug 'jiangmiao/auto-pairs'
"Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
"Comment
Plug 'scrooloose/nerdcommenter'
"Highlight Word
Plug 'itchyny/vim-cursorword'
Plug 'lfv89/vim-interestingwords'
"Format
Plug 'Chiel92/vim-autoformat'
"Function Parameter
Plug 'tenfyzhong/CompleteParameter.vim'
"IndentLine
Plug 'Yggdroot/indentLine'
"Search
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  }
"YouCompleteMe
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'
Plug 'mattn/emmet-vim'
call plug#end()
filetype plugin indent on


if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

set ambiwidth=double
set backspace=2
set nocompatible
set t_Co=256
syntax on
set number
set ts=4
set expandtab
set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4
set cursorline
set cmdheight=2
set laststatus=2
set mouse=a
set selection=inclusive
set selectmode=mouse,key
set encoding=utf-8
set fileencodings=utf-8,gb18030,gb2312


let g:polyglot_disabled = ['csv']


let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


" set background=dark
colorscheme gruvbox
set background=dark

"vim-airline Options
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline_theme= 'base16_eighties'


"nerdtree Options
" autocmd vimenter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc','\~$','\.swp','__pycache__']
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1


"rainbow Options
let g:rainbow_active = 1


"nerdcommenter Options
let g:NERDSpaceDelims = 1


let g:SuperTabDefaultCompletionType = '<tab>'
let g:UltiSnipsExpandTrigger = "<C-n>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"vim-autoformat Options
let g:formatter_yapf_style = 'pep8'
let g:formatdef_leo = '"clang-format -style=file"'
let g:formatters_c = ['leo']
let g:formatters_cpp = ['leo']
let g:autoformat_verbosemode=1
noremap <F3> :Autoformat<CR>


"CompleteParameter.vim Options
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter))
let g:complete_parameter_use_ultisnips_mapping = 0
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>


"Leaderf keyMap
noremap <leader>w :LeaderfLine<CR>
noremap <leader>u :LeaderfFunction<CR>


"Python Header
autocmd BufNewFile *.py exec ":call SetTitle()"
func SetTitle()
	if &filetype == "python"
		call setline(1, "# -* - coding: UTF-8 -* -")
		call setline(2, "import os")
		call setline(3, "import sys")
	endif
endfunc


"KeyMap
nnoremap <leader>] :bn<CR>
nnoremap <leader>[ :bp<CR>
inoremap <C-]> <Esc>o
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>
nnoremap <c-z> :u<CR>
inoremap <c-z> <Esc>:u<CR>
nnoremap <leader>h <Esc>:nohl<CR>
nnoremap <leader>p <Esc>:set paste<CR>
nnoremap <leader>q <Esc>:set nopaste<CR>
nnoremap <leader>l <Esc>:IndentLinesToggle<CR>
nnoremap <leader>m <Esc>:set nonumber<CR>
nnoremap <leader>n <Esc>:set number<CR>
nmap <leader>g <Esc>:call CocActionAsync('jumpDefinition')<CR>
nmap <leader>t <Esc>:call CocActionAsync('doHover')<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')


"Run Command
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!clang -std=c11 % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!clang++ -std=c++11 % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'python'
		exec "!time python3.6 %"
	elseif &filetype == 'go'
		exec "!time go run %"
	endif
endfunc


map <F6> :call RunPython3()<CR>
func! RunPython3()
	exec "w"
	if &filetype == 'python3'
		exec "!time python3 %"
	endif
endfunc
