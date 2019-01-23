" Plugins with settings.

" Install vim-plug automatically if not exists
if has('win32') && empty(glob('~/vimfiles/autoload/plug.vim'))
    echohl Error
    echo "Error: Cannot find vim-plug. You have to install manually."
    echohl None
    finish
elseif !has('win32') && empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! UnmanagedPlugins(name) abort
    if has('win32')
        let l:prefix = '~/vimfiles/unmanaged/'
    else
        let l:prefix = '~/.vim/unmanaged/'
    endif
    return l:prefix.a:name
endfunction

" This should be the last resort when you configure for some autoload function
" but the plugin is not yet loaded.
" See:
" https://github.com/junegunn/vim-plug/issues/432
" https://github.com/tony/vim-config-framework/blob/master/plugin_loader.vim
function! PlugOnLoad(name, source)
    if !has_key(g:plugs, a:name)
        return 1
    endif
    if has_key(g:plugs[a:name], 'on') || has_key(g:plugs[a:name], 'for')
        exec 'autocmd! User' a:name a:source
    else
        exec 'autocmd VimEnter *' a:source
    endif
    return 0
endfunction

call plug#begin()

" NVIM support
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'roxma/nvim-yarp'

Plug 'hachy/eva01.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'justinmk/vim-dirvish'
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'easymotion/vim-easymotion', {'on': ['<PLug>(easymotion-prefix)', '<Plug>(easymotion-overwin-f2)']}
Plug 'airblade/vim-rooter'
Plug 'skywind3000/asyncrun.vim'
Plug 'mileszs/ack.vim', {'on': ['Ack', 'Ack!']}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'kassio/neoterm'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/echodoc.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-sleuth'
Plug 'Yggdroot/indentLine'
" FIXME(leoyolo): temporary block Denite for vim8.
if has('nvim')
    Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'Shougo/neomru.vim'
    Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
endif

" FZF is managed outside vim/nvim.
" TODO(leoyolo): compatible with windows.
if executable('fzf')
    Plug expand('~/.fzf')
    Plug 'junegunn/fzf.vim'
endif

if !has('win32')
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
else
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
        \ }
endif

if get(g:, 'leoyolo_prefer_ycm', 0) != 0
    if has('win32')
        Plug UnmanagedPlugins('YouCompleteMe')
    else
        Plug 'Valloric/YouCompleteMe'
    endif
else
    let g:leoyolo_prefer_ncm2 = 1

    " ncm2 completion framework
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'fgrsnau/ncm2-otherbuf', {'branch': 'ncm2'}
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
    Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
endif

call plug#end()


" default colorscheme
try
    colorscheme gruvbox
catch
    colorscheme desert
endtry

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:alrline#extensions#ale#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#languageclient#enabled = 1
let g:airline#extensions#vimtex#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
    \ '0': '0:',
    \ '1': '1:',
    \ '2': '2:',
    \ '3': '3:',
    \ '4': '4:',
    \ '5': '5:',
    \ '6': '6:',
    \ '7': '7:',
    \ '8': '8:',
    \ '9': '9:'
    \}
nmap <M-1> <Plug>AirlineSelectTab1
nmap <M-2> <Plug>AirlineSelectTab2
nmap <M-3> <Plug>AirlineSelectTab3
nmap <M-4> <Plug>AirlineSelectTab4
nmap <M-5> <Plug>AirlineSelectTab5
nmap <M-6> <Plug>AirlineSelectTab6
nmap <M-7> <Plug>AirlineSelectTab7
nmap <M-8> <Plug>AirlineSelectTab8
nmap <M-9> <Plug>AirlineSelectTab9


" NERDTree
let g:NERDTreeHijackNetrw = 0
nnoremap <silent> <leader>nt :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdcommenter recommended settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Git
nnoremap <silent> <F9> :Gstatus<cr>

" CTags related: gutentags, tagbar
let g:gutentags_project_root = g:leoyolo_project_root
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
nnoremap <silent> <leader>tb :TagbarToggle<cr>

" gundo
nnoremap <silent> <leader>gu :GundoToggle<cr>
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" auto-pairs
" unmap everything
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''
au FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '`':'`'}


" vim-multiple-cursors
" use tab for multiple selection
" TODO(leoyolo): more sensible mappings
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<leader>mw'
let g:multi_cursor_select_all_word_key = '<leader>mW'
let g:multi_cursor_start_key           = '<leader>mk'
let g:multi_cursor_select_all_key      = '<leader>mK'
let g:multi_cursor_next_key            = '<leader>mn'
let g:multi_cursor_prev_key            = '<leader>mp'
let g:multi_cursor_skip_key            = '<leader>ms'
let g:multi_cursor_quit_key            = '<Esc>'


" easymotion
map <Leader><Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-overwin-f2)

" vim-rooter
let g:rooter_patterns = g:leoyolo_project_root
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_use_lcd = 1

" Code dispatcher: asyncrun
let g:asyncrun_status = ''
let g:airline_section_error = g:airline#section#create_right(['%{g:asyncrun_status}'])
let g:asyncrun_open = 16
let g:asyncrun_rootmarks = g:leoyolo_project_root
nnoremap <silent> <F10> :call asyncrun#quickfix_toggle(g:asyncrun_open)<cr>

" Grepper:
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    " Define custom search using ag
    function! s:Search(string) abort
        let saved_pipeline = &shellpipe
        let &shellpipe = '>'
        try
            execute 'Ack!' shellescape(a:string, 1)
        finally
            let &shellpipe = saved_pipeline
        endtry
    endfunction
    " Set function into command
    command! -nargs=* -complete=file Search call <SID>Search(<q-args>)
    " bind # to grep word under cursor
    nnoremap # :Search <C-R><C-W><CR>
endif

" snippets, using ycm as completer
let g:UltiSnipsExpandTrigger = '<m-e>'
let g:UltiSnipsListSnippets = '<m-l>'
let g:UltiSnipsJumpForwardTrigger = '<m-n>'
let g:UltiSnipsJumpBackwardTrigger = '<m-p>'
if has('python')
    let g:UltiSnipsUsePythonVersion = 2
endif


" ale
let g:ale_linters = {
    \'cpp': ['clangtidy', 'cppcheck', 'clang', 'g++'],
    \'tex': ['chktex'],
\}
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_insert_leave = 1

" vimtex
if has('win32')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
        \ . ' -inverse-search "gvim --servername ' . v:servername
        \ . ' --remote-send \"^<C-\^>^<C-n^>'
        \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
        \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
endif
let g:vimtex_quickfix_mode = 0
" This requires neovim-remote.
" Install with
"   (sudo /usr/bin/python3 -m) pip install neovim-remote
if executable('nvr')
    let g:vimtex_compiler_progname = 'nvr'
endif
augroup leoyolo_vimtex
    autocmd!
    autocmd FileType tex nmap <silent> <F3> :call <SID>TexWriterModeToggle()<cr>
    autocmd FileType tex nmap <F5> <plug>(vimtex-compile)
augroup END

" Toggle writer mode on and off
function! s:TexWriterModeToggle()
    setlocal spell! spelllang=en
    " Optionally if a tex file, set/unset alex/write-good linters
    if !has_key(g:ale_linters, 'tex')
        let g:ale_linters['tex'] = []
    endif
    if !exists('s:leoyolo_tex_writer_mode_toggled') || !s:leoyolo_tex_writer_mode_toggled
        let s:leoyolo_tex_writer_mode_toggled = 1
        let g:ale_linters['tex'] += ['alex', 'write-good']
    else
        let s:leoyolo_tex_writer_mode_toggled = 0
        let g:ale_linters['tex']
            \ = filter(g:ale_linters['tex'], 'v:val !~ "alex" && v:val !~ "write-good"')
    endif
    execute('ALELint')
endfunction


" FZF
" Set prefix for FZF commands
let g:fzf_command_prefix = 'Fzf'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :AgWithPreview  - Start fzf with hidden preview window that can be enabled with "?" key
"   :AgWithPreview! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* AgWithPreview
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <M-p> :<C-u>AgWithPreview<cr>


" vim-polyglot
" Prefer vimtex to latexbox.
let g:polyglot_disabled = ['latex']

" LanguageClient
let g:LanguageClient_serverCommands = {}
" Use ALE instead.
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_rootMarkers = g:leoyolo_project_root
nnoremap <silent> <F4> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Trim whitespace
nnoremap <silent> <leader><space> :StripWhitespace<CR>

" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" vim-sleuth
let g:sleuth_automatic = 1

" fruzzy
let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 0
