call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree',             { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf',                    { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-rooter'
Plug 'neoclide/coc.nvim',               {'branch': 'release'}
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'APZelos/blamer.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'inkarkat/vim-CursorLineCurrentWindow'
Plug 'voldikss/vim-floaterm'
Plug 'ryanoasis/vim-devicons'


call plug#end()

" -----General settings-----

syntax enable                              " Enable syntax highlighting
set encoding=utf-8                         " Use an encoding that supports unicode
set number                                 " Show line numbers
set ruler                                  " Show line and column number
set nowrap                                 " Don't wrap lines
set list                                   " Show invisible characters
set backspace=indent,eol,start             " Backspace through everything in insert mode
set visualbell                             " Quitar beep de los cojones
set shell=/bin/zsh                         " External commands shell
set backupdir^=~/.config/nvim/_backup//    " Backup files
set directory^=~/.config/nvim/_temp//      " Swap files
set background=dark                        " Default color maps for dark background
set laststatus=2                           " Always display the status bar
set cursorline
set foldmethod=indent
set nofoldenable
set foldlevel=2

" Indentation options
set autoindent                             " New lines inherit the indentation of previous lines
set tabstop=2                              " A tab is two spaces
set shiftwidth=2                           " An autoindent (with <<) is two spaces
set expandtab                              " Use spaces, not tabs

" Search options
set hlsearch                               " Highlight matches
set incsearch                              " Incremental searching
set ignorecase                             " Searches are case insensitive...
set smartcase                              " ... unless they contain at least one capital letter

" Mouse support
set mouse=a                                " Enable the use of the mouse

" List chars
set listchars=""                           " Reset the listchars
set listchars=tab:\ \                      " A tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.                     " Show trailing spaces as dots
set listchars+=extends:>                   " The character to show in the last column when wrap is
                                           " off and the line continues beyond the right of the screen
set listchars+=precedes:<                  " The character to show in the last column when wrap is

" Ignore files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem               " Disable output and VCS files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz                           " Disable archive files
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*      " Ignore bundler and sass cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*  " Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*      " Ignore rails temporary asset caches
set wildignore+=*.swp,*~,._*                                                      " Disable temp and backup files
set wildignore+=*/node_modules/*                                                  " Ignore node modules

" Activa true colors en la terminal
set termguicolors

" Activa tema onedark
colorscheme onedark

" permite copiar al clipboard
set clipboard+=unnamedplus


" -----Custom mappings-----

"" Leader key
let mapleader = ","

" Reselect visual block after indent/outdent
vmap < <gv
vmap > >gv

" Use jk as <Esc>
imap jk <Esc>

" Save with ,s
noremap <Leader>s :w<CR>

" Save all with ,a
noremap <Leader>a :wa<CR>

" Save and exit with ,w
noremap <Leader>w :wq<CR>

" Close window with ,q
noremap <Leader>q :q<CR>

" Exit with ,e
noremap <Leader>e :qa<CR>

" Open new tab with ,t
noremap <Leader>t :tabe<CR>

" Close tab with ,c
noremap <Leader>c :tabc<CR>

" Move on popups with j and k

function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent> <C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent> <C-k> <C-R>=OmniPopup('k')<CR>





" -----Custom settings for plugins-----

" Nerdtree
  " Open nerdtree with Ñ
  nmap t :NERDTree <CR>
  let NERDTreeShowHidden=1

  " Open file in nerdtree
  nmap <Leader>f :NERDTreeFind <CR>

" Nerdcommenter
  " Comment out the current line or text selected in visual mode with ñ
  map ; :call nerdcommenter#Comment(0, "toggle") <CR>
  let g:NERDSpaceDelims = 1
  let g:NERDTrimTrailingWhitespace = 1

" splitjoin.vim
  nmap <Leader>gs gS<CR>
  nmap <Leader>gj gJ<CR>

  " floaterm
  nmap <c-t> :FloatermNew --autoclose=2 tmux<CR>

" Fzf
  " Open file finder
  nmap <c-p> :Files<CR>
  " Open file history
  nmap <c-h> :History<CR>
  " Open ag
  nmap <Leader>ag :Ag<CR>
  " Open git files
  nmap <Leader>g :GFiles?<CR>
  " Blamer
  let g:blamer_enabled = 1
  nmap <Leader>b :Git blame<CR>
  " Buffers
  let g:fzf_buffers_jump = 1
  nmap <c-space> :Buffers<CR>

  " https://github.com/junegunn/fzf#respecting-gitignore
  " let $FZF_DEFAULT_COMMAND = 'ag -g ""'

  " Fzf configurations
  let g:fzf_action = {
              \ 'ctrl-t': 'tab split',
              \ 'ctrl-s': 'split',
              \ 'ctrl-v': 'vsplit' }

  let g:fzf_colors = {
              \ 'border':  ['fg', 'Comment'],
              \ 'hl':      ['fg', 'Comment'],
              \ 'info':    ['fg', 'PreProc'] }


" Undotree
  " Open undo tree
  nnoremap <F5> :UndotreeToggle<CR>

" Vim-multiple-cursors
  " https://github.com/terryma/vim-multiple-cursors#gmulti_cursor_insert_maps-default-
  let g:multi_cursor_insert_maps={'j':1}

  " Cargar fuente Powerline y símbolos (ver nota)
  let g:airline_powerline_fonts = 1

  set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)

" Unimpaired
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

" Coc.nvim
  " Map for document filetypes so the server could handle current document as another filetype
  let g:coc_filetype_map = {
        \ 'svelte': 'javascript',
        \ }

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

" Polyglot
  " Svelte files as html
  "autocmd BufNewFile,BufRead *.svelte set filetype=html

" Vim-airlane
  let g:airline_theme='bubblegum'
  let g:airline_powerline_fonts = 1
  let g:airline_section_x = ''
  let g:airline_section_y = ''
  let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.linenr = '  '
  let g:airline_symbols.colnr = '  '
  let g:airline_symbols.maxlinenr = ''

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_close_button = 0

" Tmuxline
  "let g:tmuxline_preset = 'powerline'
  let g:tmuxline_preset = {
      \'b'    : '%c',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'y'    : ['MEMORY: #(tmux-mem-cpu-load -a 0 -g 0 -m 2 --only-memory)', 'CPU: #(tmux-mem-cpu-load -a 0 -g 0 -m 2 --only-cpu)']}

" Indent-lines
  let g:indentLine_char = '⎸'
  let g:indentLine_color_term = 66

  " Format on save
  "au BufWritePre * call CocAction('format')

  " ruby host
  " let g:ruby_host_prog = '/home/adrian/.rvm/gems/ruby-2.6.6/bin/neovim-ruby-host'

  " solargraph
  let g:coc_global_extensions = ['coc-solargraph']
  let g:coc_disable_startup_warning = 1

" -----References-----
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" https://github.com/carlhuda/janus/blob/f285edf1533eaecf526dabe0962dcd5107319af7/janus/vim/core/before/plugin/
" Script to print colors: https://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal/821163#821163
