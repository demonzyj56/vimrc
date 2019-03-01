nmap j gj
nmap k gk
if has_key(g:plugs, 'vimtex')
    nmap <silent> <F3> :call <SID>TexWriterModeToggle()<cr>
    nmap <F5> <plug>(vimtex-compile)
    nmap K <plug>(vimtex-doc-package)
    nnoremap <leader>dv :<C-u>Denite vimtex<cr>
endif
let b:AutoPairs = g:AutoPairs
let b:AutoPairs['$'] = '$'

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
