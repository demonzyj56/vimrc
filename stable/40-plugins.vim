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
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'easymotion/vim-easymotion', {'on': ['<PLug>(easymotion-prefix)', '<Plug>(easymotion-overwin-f2)']}
Plug 'airblade/vim-rooter'
Plug 'skywind3000/asyncrun.vim'
Plug 'Yggdroot/LeaderF'
Plug 'mileszs/ack.vim', {'on': ['Ack', 'Ack!']}
Plug 'SirVer/ultisnips', {'on': []}
Plug 'honza/vim-snippets', {'on': []}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
Plug 'junegunn/vim-emoji'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'kassio/neoterm'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'

" FZF is managed outside vim/nvim.
" TODO(leoyolo): compatible with windows.
if executable('fzf')
    Plug expand('~/.fzf')
    Plug 'junegunn/fzf.vim'
endif

" TODO(leoyolo): figure out how to use.
Plug 'skywind3000/vim-preview', {'on': []}

" Unmanaged plugins
" On windows I managed it manually.  Otherwise I use vim-plug to manage
" but build it manually.
if has('win32')
    Plug UnmanagedPlugins('YouCompleteMe'), {'on': ['YcmCompleter']}
else
    Plug 'Valloric/YouCompleteMe', {'on': ['YcmCompleter']}
endif

call plug#end()

" https://github.com/junegunn/vim-plug/wiki/tips
augroup load_us_ycm
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets', 'YouCompleteMe')
        \| autocmd! load_us_ycm
augroup END


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
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#branch#enabled = 1

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

" auto-pair
" unmap everything
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''


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
let g:asyncrun_open = 10
let g:asyncrun_rootmarks = g:leoyolo_project_root
nnoremap <silent> <F10> :call asyncrun#quickfix_toggle(g:asyncrun_open)<cr>

" Navigation: leaderf
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <m-p> :LeaderfFunction!<cr>
noremap <c-n> :LeaderfMru<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = g:leoyolo_project_root
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.cache/leaderf')
let g:Lf_ShowRelativePath = 0
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_NormalMap = {
	\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
	\ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
	\ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
	\ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
	\ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
	\ }

" Grepper: 
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    " Define custom search using ag
    function Search(string) abort
        let saved_pipeline = &shellpipe
        let &shellpipe = '>'
        try
            execute 'Ack!' shellescape(a:string, 1)
        finally
            let &shellpipe = saved_pipeline
        endtry
    endfunction
    " Set function into command
    command! -nargs=* -complete=file Search call Search(<q-args>)
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

" YouCompleteMe
" from https://zhuanlan.zhihu.com/p/33046090
" TODO(leoyolo): config for correct path
if has('win32') && has('python')
    let g:ycm_server_python_interpreter = 'C:\\Python27\\python.exe'
endif
let g:ycm_python_binary_path = 'python'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
nnoremap <silent> <leader>g :YcmCompleter GoTo<cr>
noremap <c-z> <NOP>
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
let g:ycm_semantic_triggers =  {
  \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
  \ 'cs,lua,javascript': ['re!\w{2}'],
  \ 'tex': g:vimtex#re#youcompleteme,
  \ }

" ale
let g:ale_linters = {
    \'cpp': ['clangtidy', 'cppcheck', 'clang', 'g++'],
    \'python': ['pylint', 'pycodestyle'],
    \'tex': ['chktex'],
\}
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_insert_leave = 1
" ale-pylint
let g:ale_python_pylint_use_global = 0
let g:ale_python_pylint_executable = 'pylint'
let g:ale_python_pylint_options = 
    \ '--disable=invalid-name,bare-except,too-many-arguments --extension-pkg-whitelist=torch,cv2'
let g:ale_python_pycodestyle_options = '--ignore=E501,E226,E265'

" pymode
" This should act as a sensible configs for python code
" so use only minimal configurations.
let g:pymode_run = 0
let g:pymode_breakpoint = 1
let g:pymode_folding = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
let g:pymode_lint = 0
let g:pymode_doc = 0
let g:pymode_rope = 0
let g:pymode_motion = 1
" Choose python version supported by vim, preferably python3.
if has('python3')
    let g:pymode_python = 'python3'
else
    let g:pymode_python = 'python'
endif

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
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* FzfAg
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir FzfFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
