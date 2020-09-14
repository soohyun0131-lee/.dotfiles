set number
set ai
set si
set cindent
set shiftwidth=2
set ts=2
set sts=2
set laststatus=2
set showmatch
set smartcase
set smarttab
set smartindent
set hlsearch
set expandtab
set background=dark
set nocompatible
set fileencodings=utf-8,euc-kr
set bs=indent,eol,start
set history=100
set ruler
set title
set showmatch
set wmnu
set termguicolors " 24-bit color 쓰기
set updatetime=500

if has("syntax")
  syntax on
endif

"
" vim-plug
"
call plug#begin('~/.vim/plugged')

" 여기에 플러그인을 나열해주세요
Plug 'vim-airline/vim-airline'
Plug 'ayu-theme/ayu-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-sources', {'do': 'yarn install --frozen-lockfile', 'rtp': 'packages/emoji'}
if executable('clangd')
  Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
endif
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'ervandew/supertab'
Plug 'junegunn/fzf'
Plug 'preservim/nerdtree'
call plug#end()

" ayu
let ayucolor = 'dark'
colorscheme ayu

" coc.nvim
let g:coc_disable_startup_warning = 1

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" fzf
nnoremap <F5> :call <SID>lsp_menu()<CR>
function! s:lsp_menu()
  call fzf#run({
        \ 'source': [
        \   'rename',
        \   'jumpDefinition',
        \   'jumpDeclaration',
        \   'jumpImplementation',
        \   'jumpTypeDefinition',
        \   'jumpReferences',
        \   'diagnosticInfo',
        \   'diagnosticNext',
        \   'diagnosticPrevious',
        \   'format',
        \   'openLink',
        \   'doQuickfix',
        \   'doHover',
        \   'refactor',
        \ ],
        \ 'sink': function('CocActionAsync'),
        \ 'options': '+m',
        \ 'down': 10 })
endfunction

" coc-highlight
augroup vimrc_highlight
  autocmd!
  autocmd CursorHold * silent call <SID>highlight()
augroup END
function! s:highlight()
  if exists('*CocActionAsync')
    call CocActionAsync('highlight')
  endif
endfunction
highlight CocHighlightText guibg=#232b32

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" nerdtree
noremap <silent> <C-n> :NERDTreeToggle<CR>
function! s:nerdtree_startup()
  if exists('s:std_in') || argc() != 1 || !isdirectory(argv()[0])
    return
  endif
  execute 'NERDTree' argv()[0]
  wincmd p
  enew
  execute 'cd '.argv()[0]
  NERDTreeFocus
endfunction
augroup vimrc_nerdtree
  autocmd!

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * call s:nerdtree_startup()
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
