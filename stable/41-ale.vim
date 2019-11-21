" All ALE related configs.

" ale
let g:ale_linters = {
    \'cpp': ['clangtidy', 'cppcheck', 'clang', 'g++'],
    \'python': ['pylint', 'pycodestyle'],
    \'rust': ['rls'],
    \'tex': ['chktex'],
\}
let g:ale_linters_explicit = 1
" let g:ale_completion_delay = 500
" let g:ale_echo_delay = 20
" let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_insert_leave = 1
let g:ale_use_global_executables = 1
let g:ale_disable_lsp = 1

" ale-python
let g:ale_python_pylint_executable =
    \ fnamemodify(g:python3_host_prog, ':h:p').'/pylint'
let g:ale_python_pycodestyle_executable =
    \ fnamemodify(g:python3_host_prog, ':h:p').'/pycodestyle'
let g:ale_python_pylint_options =
    \ '--disable=invalid-name,bare-except,too-many-arguments --extension-pkg-whitelist=torch,cv2'
let g:ale_python_pycodestyle_options = '--ignore=E501,E226,E265'

" ale-rust
let g:ale_rust_rls_toolchain = 'stable'

" ale-tex
let g:ale_writegood_options = '--no-passive'
let g:leoyolo_writer_linters = ['alex', 'redpen-leoyolo', 'write-good']

" Define redpen linter with custom configs
call ale#linter#Define('tex', {
    \ 'name': 'redpen-leoyolo',
    \ 'executable': 'redpen',
    \ 'command': 'redpen -f latex -r json -c '.g:leoyolo_home.'/configs/redpen-conf-en.xml %t',
    \ 'callback': 'ale#handlers#redpen#HandleRedpenOutput',
    \ })

" additionally add linters
if has_key(g:plugs, 'vimtex')
    nmap <silent> <F3> :call <SID>TexWriterModeToggle()<cr>
endif

" Toggle writer mode on and off
function! s:TexWriterModeToggle()
    setlocal spell! spelllang=en
    if !exists('s:leoyolo_tex_writer_mode_toggled') || !s:leoyolo_tex_writer_mode_toggled
        let s:leoyolo_tex_writer_mode_toggled = 1
        let g:ale_linters['tex'] += g:leoyolo_writer_linters
    else
        let s:leoyolo_tex_writer_mode_toggled = 0
        let g:ale_linters['tex']
            \ = filter(g:ale_linters['tex'], 'get(g:leoyolo_writer_linters, v:val, v:true) == v:true')
    endif
    execute('ALELint')
endfunction
