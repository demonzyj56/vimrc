nmap j gj
nmap k gk
if has_key(g:plugs, 'vimtex')
    nmap <silent> <F3> :call <SID>TexWriterModeToggle()<cr>
    nmap <F5> <plug>(vimtex-compile)
    nmap K <plug>(vimtex-doc-package)
endif
let b:AutoPairs = g:AutoPairs
let b:AutoPairs['$'] = '$'

" Define redpen linter with custom configs
call ale#linter#Define('tex', {
    \ 'name': 'redpen-leoyolo',
    \ 'executable': 'redpen',
    \ 'command': 'redpen -f latex -r json -c '.g:leoyolo_home.'/configs/redpen-conf-en.xml %t',
    \ 'callback': 'ale#handlers#redpen#HandleRedpenOutput',
    \ })

" write-good customization
let g:ale_writegood_options = '--no-passive'

let b:leoyolo_writer_linters = ['alex', 'redpen-leoyolo', 'write-good']

" Toggle writer mode on and off
function! s:TexWriterModeToggle()
    setlocal spell! spelllang=en
    " Optionally if a tex file, set/unset linters.
    if !has_key(g:ale_linters, 'tex')
        let g:ale_linters['tex'] = []
    endif
    if !exists('s:leoyolo_tex_writer_mode_toggled') || !s:leoyolo_tex_writer_mode_toggled
        let s:leoyolo_tex_writer_mode_toggled = 1
        let g:ale_linters['tex'] += b:leoyolo_writer_linters
    else
        let s:leoyolo_tex_writer_mode_toggled = 0
        let g:ale_linters['tex']
            \ = filter(g:ale_linters['tex'], 'get(b:leoyolo_writer_linters, v:val, v:true) == v:true')
    endif
    execute('ALELint')
endfunction
