
" -----------------------------------------------------------------
" ---------------- Kate's Vimrc -----------------------------------
" ---------------- Kate's Vimrc -----------------------------------
" ---------------- Kate's Vimrc -----------------------------------
" ---------------- Kate's Vimrc -----------------------------------
" ---------------- Kate's Vimrc -----------------------------------
" ---------------- Kate's Vimrc -----------------------------------
" -----------------------------------------------------------------
"
"
" TABLE OF CONTENTS
"
" 1. Setting up Vundle
"   1.a Plugin List
"   1.b Plugin Settings
" 2. Map Commands
"   2.a Auto Commands
" 3. Quality of Life
" 4. Global Commands
"
"
" -----------------------------------------------------------------
" 1 ---------------- SETUP VUNDLE ---------------------------------
"
" # Vundle is a plugin manager in vim. And is used to install
"   and remove plugins for your vim.


" Vundle - https://github.com/VundleVim/Vundle.vim
"
" Install Vundle
"  git config --global core.autocrlf input
"  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"  :PluginInstall (inside vim)
"
" Install New Plugins
"  Add new plugin
"  Restart vim
"  :PluginInstall
"

" Required
set nocompatible
filetype off

" Initialize Vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

let g:ale_disable_lsp = 1 " disable lsp to ale for COC

" Required
Plugin 'VundleVim/Vundle.vim'


" 1.a ---------------- PLUGIN LIST ---------------------------------

" # Add your plugins here :)
"   checkout https://vimawesome.com/ for vim plugins

" ---- Basic Tools ----

Plugin 'scrooloose/nerdtree'              " file explorer
Plugin 'jistr/vim-nerdtree-tabs'          " nerdtree improved
Plugin 'mileszs/ack.vim'                  " search tool
Plugin 'tpope/vim-fugitive'               " git wrapper
"Plugin 'oinksoft/npm.vim'                 " npm wrapper

" ---- Productivity ----

Plugin 'airblade/vim-gitgutter'            " display git diff while editing
"Plugin 'terryma/vim-multiple-cursors'      " multiple cursor
Plugin 'dense-analysis/ale'
Plugin 'neoclide/coc.nvim'                 " async linter
Plugin 'prettier/vim-prettier'             " auto-format
"Plugin 'feross/standard'                  " standard lint
"Plugin 'yannickcr/eslint-plugin-react'    " react eslint
Plugin 'tpope/vim-surround'               " quoting and parenthesizing

" ---- Aesthetics ----

"Plugin 'flazz/vim-colorschemes'           " colorschemes -- required for solarized
Plugin 'dracula/vim'                      " dracula color duuuhhh
Plugin 'vim-airline/vim-airline'          " fancy menu (has prerequisite installation for symbols)
Plugin 'vim-airline/vim-airline-themes'   " vim-airline themes
Plugin 'yggdroot/indentline'              " indent line
Plugin 'pangloss/vim-javascript'          " required for vim-jsx
Plugin 'mxw/vim-jsx'                      " react highlighting
Plugin 'leafgarland/typescript-vim'       " typescript highlighting
"Plugin 'ryanoasis/vim-devicons'           " fancy nerdtree with icons

" Required
call vundle#end()
filetype plugin indent on


" 1.b ---------------- PLUGIN SETTINGS ---------------------------------

" # Here is where we customize our plugins


" ----------- Plugin - vim-nerdtree-tabs ---------------------------

" Auto Open Nerd Tree Tabs
let g:nerdtree_tabs_open_on_console_startup = 1

" Show hidden files
let NERDTreeShowHidden = 1

" Ignore the following files
let NERDTreeIgnore = ['\.git$', '\.pyc', '\.sw[a-p]$']


" ----------- Plugin - ack.vim -------------------------------------

" Use ag instead of ack (sudo apt-get install silversearcher-ag -y)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" ----------- Plugin - vim-gitgutter -------------------------------

" Auto suppress gitgutter when there are too many signs
let g:gitgutter_max_signs = 500  " default value

" Show diff markers quickly
set updatetime=100


" ----------- Plugin - vim-airline ---------------------------------

" Default Theme (:AirlineTheme <TAB> to show other themes)
let g:airline_theme = 'dracula'

" Add fancy symbols to your airline tab
" but has prerequisite installation
" sudo apt-get install fonts-powerline
let g:airline_powerline_fonts = 1


" ----------- Plugin - async linter (ale) --------------------------

" Define lint to use
let b:ale_linters = {
\   'javascript': ['eslint', 'typescript'],
\   'typescript': ['eslint', 'typescript', 'typecheck'],
\   'css': ['stylelint']
\}

" Define lint to use
let b:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'css': ['prettier','stylelint'],
\}

" Enable lint error to show in airline
let g:airline#extensions#ale#enabled = 1

" Enable fix on save
let g:ale_fix_on_save = 1

" Completion
" Turn off when using other completion plugins
let g:ale_completion_enabled = 0
"set omnifunc=ale#completion#OmniFunc

" Auto Import
let g:ale_completion_autoimport = 1

" Sign customization
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Keeping the sign column always active
let  g:ale_sign_column_always = 1

" Fast navigation through errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ----------- Plugin - COC--------------------------
"
"" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8
"
" TextEdit might fail if hidden is not set.
set hidden
"
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2
"
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
" " Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction
"
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
"
" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
"
" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
"
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
"
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
"
" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)
"
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
"
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" --------------------------------------------------------------------
" 2 ---------------- MAP COMMANDS ------------------------------------

" # Here is where we add custom commands for our vim.
"   Mostly shorhand commands for more efficient development.

" -------------------------------------
"        Usablity Map Commands
" -------------------------------------

" <Ctrl+a> Toggle NTT on all tabs
nnoremap <C-a> :NERDTreeTabsToggle<CR>
inoremap <C-a> <Esc>:NERDTreeTabsToggle<CR>

" <CTRL+t> New tab
nnoremap <C-t> :tabnew<CR><C-w><Left>
inoremap <C-t> <Esc>:tabnew<CR><C-w><Left>

" <CTRL+h> Previous tab
nnoremap <C-h> :tabprevious<CR>
inoremap <C-h> <Esc>:tabprevious<CR>

" <CTRL+l> Next tab
nnoremap <C-l> :tabnext<CR>
inoremap <C-l> <Esc>:tabnext<CR>

" :,ev Edit .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>

" \tm0 Move current tab to first position
nnoremap <leader>tm0 :tabmove 0<CR>

" -------------------------------------
"           Git Map Commands
" -------------------------------------

" \gs Git status
nnoremap <leader>gs :Git<CR>

" \gc Git commit
nnoremap <leader>gc :Git commit<CR>

" \gd Git diff
nnoremap <leader>gd :Gdiff<CR>

" \gb Git blame
nnoremap <leader>gb :Gblame<CR>

" \go Git checkout
nnoremap <Leader>go :Git checkout<Space>

" \gp Git push
nnoremap <Leader>gp :Git push origin<Space>

" \gl Git pull
nnoremap <Leader>gl :Git pull origin<Space>

" \gr Git rebase
nnoremap <Leader>gr :Git rebase origin/

" \gg Git log
nnoremap <Leader>gr :Git log <CR>

" -------------------------------------
"         Plugin Map Commands
" -------------------------------------

" Ack will use Ack! instead
" (Ack! will not jump to first result automatically)
cnoreabbrev Ack Ack!

" \a Ack! search
nnoremap <Leader>a :Ack!<Space>

" -------------------------------------
"         Others Map Commands
" -------------------------------------

" FORCE hjkl
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>


" 2.a ---------------- AUTO COMMANDS ---------------------------------
"
" Set Tabs to 2 when opening .js or .jsx files
augroup javascript
  autocmd BufReadPost,BufNewFile *.js,*.jsx,*.ts,*.tsx set shiftwidth=2
  autocmd BufReadPost,BufNewFile *.js,*.jsx,*.ts,*.tsx set softtabstop=2
  autocmd BufReadPost,BufNewFile *.js,*.jsx,*.ts,*.tsx set tabstop=2
augroup end


" ------------------------------------------------------------------
" 3 ----------------- QUALITY OF LIFE -------------------------------

" Enable syntax highlighting
syntax enable

" Colorscheme
set t_Co=256
set background=dark
colorscheme dracula

" Interface
set number          " Shows line numbers
set numberwidth=3   " Set line number width (default=4)
set ruler           " Shows line and character position (lower right)
set showcmd         " Shows currently typed commands (lower right)
set wildmenu        " Shows completable commands when pressing <TAB>
                    "  i.e. :colorscheme <TAB>

" Beeps and Flashes
set noerrorbells    " Disable beeping sound
set novisualbell    " Disable flashing screen part1
set t_vb=           " Disable flashing screen part2

" Command Timeouts
set notimeout       " Disable command timeout part1
set ttimeout        " Disable command timeout part2

" Safety First!
set confirm         " Executing :q without saving will show a confirm prompt

" Search
set hlsearch        " Search results will be highlighted
set ignorecase      " Case insensitive search
set incsearch       " Go to next match while typing search
set smartcase       " Searching with uppercase letters will make search case sensitive

" Speed
set lazyredraw      " Buffer screen updates (helpful in complex recordings)

" Tabs
set expandtab       " Pressing tab will use spaces instead
set shiftwidth=4    " Indentation spaces when using << or >>
set softtabstop=4   " Always use the specified number of spaces
set tabstop=4       " The number of characters the tab character will use

" Split
set splitright      " Cursor will appear on right split when using vsplit
" set splitbelow      " Cursor will appear on bottom split when using split

" Folding
set foldmethod=indent " Easiest foldmethod to work with
set foldlevelstart=1  " Start folding at X level
set foldnestmax=2     " Only fold X levels deep
"set nofoldenable     " Don't automatically fold (commented out to always enable folding at file open)

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif



" ------------------------------------------------------------------
" 4 ---------------- GLOBAL COMMANDS -------------------------------

" # these are commands to override vim commands


" :W will force save a read-only file
command W w !sudo tee % > /dev/null

" Removes auto-indent when pasting (Removes the need to use ':set paste')
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
mrc
"
endfunction

" ------------------------------------------------------------------
" ------------------------------------------------------------------
