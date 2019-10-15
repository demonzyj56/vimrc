" disable tex conceal
let g:tex_conceal = ''

" Force detecting all types of .tex file as tex filetype.
" https://superuser.com/questions/208177/vim-and-tex-filetypes-plaintex-vs-tex
let g:tex_flavor = 'latex'

" Vimtex specific settings.
" If you don't have vimtex, why bother to use vim for tex files?
if !has_key(g:plugs, 'vimtex')
    finish
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
" This requires neovim-remote.
" Install with
"   (sudo /usr/bin/python3 -m) pip install neovim-remote
if executable('nvr')
    let g:vimtex_compiler_progname = 'nvr'
endif

let g:ale_linters['tex'] = ['chktex']

" vim-polyglot
" Prefer vimtex to latexbox.
let g:polyglot_disabled = ['latex']

" indentLine
let g:indentLine_fileTypeExclude = ['tex']

" airline
let g:airline#extensions#vimtex#enabled = 1

" ycm
if get(g:, 'leoyolo_prefer_ycm', 0) != 0
    let g:ycm_semantic_triggers['tex'] = g:vimtex#re#youcompleteme
endif

" ncm2
if get(g:, 'leoyolo_prefer_ncm2', 0) != 0
    " Configs for vimtex
    augroup leoyolo_ncm2_for_vimtex_setup
        autocmd!
        autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-cmds',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'prefix', 'key': 'word'},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
        autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-labels',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'substr', 'key': 'word'},
                \               {'name': 'substr', 'key': 'menu'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#labels,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
        autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-files',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'abbrfuzzy', 'key': 'word'},
                \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#files,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
        autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'bibtex',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'prefix', 'key': 'word'},
                \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                \               {'name': 'abbrfuzzy', 'key': 'menu'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
    augroup END

endif
