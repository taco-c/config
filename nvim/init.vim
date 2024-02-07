"       _            _
"  _ __(_)_ ____   _(_)_ __ ___
" | '__| | '_ \ \ / / | '_ ` _ \
" | |  | | | | \ V /| | | | | | |
" |_|  |_|_| |_|\_/ |_|_| |_| |_|
"


"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')
	" Required by:
	" - ThePrimeagen/harpoon
	" - nvim-telescope/telescope.nvim
	Plug 'nvim-lua/plenary.nvim'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'preservim/nerdcommenter'
	Plug 'vim-airline/vim-airline'
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'folke/zen-mode.nvim'
	Plug 'folke/todo-comments.nvim'
	"Plug 'lukas-reineke/indent-blankline.nvim'

	" Themes
	Plug 'morhetz/gruvbox'
	Plug 'plan9-for-vimspace/acme-colors'
	Plug 'andreasvc/vim-256noir'
	Plug 'fxn/vim-monochrome'
	Plug 'ntk148v/komau.vim'
	"Plug 'lunarvim/synthwave84.nvim'
	"Plug 'folke/tokyonight.nvim'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " required by junegunn/fzf.vim
	Plug 'junegunn/fzf.vim'

	Plug 'ThePrimeagen/harpoon'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
	"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'jceb/vim-orgmode'
	"Plug 'dense-analysis/ale'
	Plug 'tpope/vim-obsession'
	Plug 'mbbill/undotree'
call plug#end()

let g:coc_global_extensions = [
	\ 'coc-sh',
	\ 'coc-vimlsp',
	\ 'coc-sumneko-lua',
	\ 'coc-rust-analyzer',
	\ 'coc-clangd',
	\ 'coc-tsserver',
	\ 'coc-json',
	\ 'coc-css',
	\ 'coc-html',
	\ 'coc-phpls',
	\ 'coc-pyright',
	\ 'coc-angular',
	\ 'coc-sql',
	\ 'coc-vetur',
	\ 'coc-zls',
	\ ]


""""""""
" Sets "
""""""""

set title
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number
set norelativenumber
set noexpandtab
set tabstop=4
set shiftwidth=4
set mouse=a
set mousemodel=
set splitbelow splitright
set list                   " Show whitespace
set cursorline             " Highlight current line
set scrolloff=5
set updatetime=100

if !empty($WORK_ENV)
	autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType json setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType vue setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType php setlocal tabstop=4 shiftwidth=4 expandtab
endif

autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType org setlocal expandtab

" Theming
function! ToggleColors()
	if g:colors_name == "quiet"
		colorscheme gruvbox
	else
		colorscheme quiet
	endif

	highlight Normal guibg=NONE ctermbg=NONE

	" vim-gitgutter
	highlight GitGutterAdd          ctermfg=2 ctermbg=2
	highlight GitGutterChange       ctermfg=3 ctermbg=3
	highlight GitGutterChangeDelete ctermfg=3 ctermbg=3
	highlight GitGutterDelete       ctermfg=1 ctermbg=1
endfunction

let g:colors_name = ""
call ToggleColors()
set colorcolumn=80,100,120
command! Col set colorcolumn=80,120
command! NoCol set colorcolumn=

autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=100, on_visual=true}

" vim-airline
let g:airline_section_b = ''

" netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0

lua << EOF
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"c", "lua", "vim", "rust", "go", "javascript", "org", "zig",
		"bash", "json", "html", "php", "python", "vue",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = {'org', 'php', 'html'},
	},
}

require("zen-mode").setup {
	window = {
		width = 79,
		options = {
			signcolumn = "no",
			number = false,
			list = false,
			cursorline = false,
		}
	}
}

require("todo-comments").setup()

-- lukas-reineke/indent-blankline.nvim
vim.opt.listchars:append 'tab:→ '
--require("ibl").setup()

--require("indent_blankline").setup {
--	show_current_context = true,
--	show_current_context_start = false,
--	show_first_indent_level = true,
--	char = "▏",
--	use_treesitter = true,
--	show_trailing_blankline_indent = false,
--	disable_with_nolist = true,
--}

--require('telescope').load_extension('fzf')
EOF


""""""""""
" Remaps "
""""""""""

let mapleader = ' '
nnoremap <leader>e :!'%:p'<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>z :ZenMode<CR>
nnoremap <leader>c :call ToggleColors()<CR>
nnoremap <C-a> ggVG
nnoremap J mzJ`z
nnoremap <expr> <C-d> winheight(0)/4 . '<C-d>zz'
nnoremap <expr> <C-u> winheight(0)/4 . '<C-u>zz'
"nnoremap n nzzzv
"nnoremap N Nzzzv
nnoremap Q <nop>
nnoremap * *N
nnoremap <C-t> <cmd>silent !tmux neww tmux-sessionizer<CR>
inoremap {<cr> {}<esc>i<cr><esc>O
nnoremap / /\c

" Fix human errors
nnoremap <S-down> <down>
nnoremap <S-up> <up>
vnoremap <S-down> <down>
vnoremap <S-up> <up>
nnoremap q: <nop>
command! W w
command! Q q

" :let g:gitgutter_diff_base = 'master'

" Note management
let divider = '------------------------------------------------------------------------------'
execute 'nnoremap <space>nn /' . divider . '<CR>NVnk"ndgg0}p/ÆØÆØ<CR>'
execute 'nnoremap <space>nc gg0}o' . divider . '<CR><CR><CR><ESC>ki'
execute 'nnoremap <space>nd /' . divider . '<CR>NVnk"nd/ÆØÆØ<CR>'
execute 'nnoremap <space>np /' . divider . '<CR>k0p/ÆØÆØ<CR>'

" Replace
nnoremap <leader>rw "_diwP
nnoremap <leader>rW "_diWP
nnoremap <leader>r( "_di(P
nnoremap <leader>r[ "_di[P
nnoremap <leader>r{ "_di{P
nnoremap <leader>r" "_di"P
nnoremap <leader>r' "_di'P
nnoremap <leader>rr "_ddP

vnoremap <leader>r "_dP

" Yank and paste with system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

vnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Easier split navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Buffer management
nnoremap <leader>b :buffers<CR>
nnoremap <A-l> :bnext<CR>
nnoremap <A-h> :bprev<CR>

" Alt key for moving lines
nnoremap <A-down> :m .+1<CR>==
nnoremap <A-up> :m .-2<CR>==
inoremap <A-down> <Esc>:m .+1<CR>==gi
inoremap <A-up> <Esc>:m .-2<CR>==gi
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap <A-up> :m '<-2<CR>gv=gv
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" netrw
function! ToggleNetrw()
	if bufname("%") == "NetrwTreeListing"
		Rex
	else
		Ex .
	endif
endfunction
nnoremap <leader><tab> :call ToggleNetrw()<CR>

" vim-fugitive
nnoremap <leader>g :Git<CR>

" coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"
                             " \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" fzf.vim
let g:fzf_preview_window = ['up,50%', 'ctrl-/']

function! GFilesOrFiles()
    if isdirectory(".git") != 0
        GFiles
    else
        Files
    endif
endfunction

nnoremap <C-p> :call GFilesOrFiles()<CR>
nnoremap <leader>f :Ag<CR>

" harpoon
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>t :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <a-1> :lua require("harpoon.ui").nav_file(1)<CR>zz
nnoremap <a-2> :lua require("harpoon.ui").nav_file(2)<CR>zz
nnoremap <a-3> :lua require("harpoon.ui").nav_file(3)<CR>zz
nnoremap <a-4> :lua require("harpoon.ui").nav_file(4)<CR>zz
nnoremap <a-5> :lua require("harpoon.ui").nav_file(5)<CR>zz
nnoremap <a-6> :lua require("harpoon.ui").nav_file(6)<CR>zz
nnoremap <a-7> :lua require("harpoon.ui").nav_file(7)<CR>zz
nnoremap <a-8> :lua require("harpoon.ui").nav_file(8)<CR>zz
nnoremap <a-9> :lua require("harpoon.ui").nav_file(9)<CR>zz

" nerdcommenter
let g:NERDCreateDefaultMappings = 0
nnoremap <leader>k :call nerdcommenter#Comment('n', 'toggle')<CR>
vnoremap <leader>k :call nerdcommenter#Comment('x', 'toggle')<CR>

" undotree
nnoremap <F5> :UndotreeToggle<CR>

