if get(s:, 'leoyolo_vimrc_loaded', 0) != 0
    finish
else
    let s:leoyolo_vimrc_loaded = 1
endif

let g:leoyolo_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exec 'set rtp+='.g:leoyolo_home

function! s:load_script(p) abort
    " The path p is assumed to be full path
    exec 'so '.a:p
    return 0
endfunction

function! s:load_all_from(p) abort
    " Load all the scripts from a specific folder.
    let l:scripts = globpath(a:p, '*.vim', 0, 1)
    call sort(l:scripts)
    call map(l:scripts, '<SID>load_script(v:val)')
    return 0
endfunction

function! s:load_all_scripts() abort
    call <SID>load_all_from(g:leoyolo_home.'/stable')
    if isdirectory(g:leoyolo_home.'/experimental')
        call <SID>load_all_from(g:leoyolo_home.'/experimental')
    endif
    return 0
endfunction

command! -nargs=0 SO call <SID>load_all_scripts()
call <SID>load_all_scripts()
