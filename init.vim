if get(s:, 'leoyolo_vimrc_loaded', 0) != 0
    finish
else
    let s:leoyolo_vimrc_loaded = 1
endif

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exec 'set rtp+='.s:home

function! s:LoadScript(p) abort
    " The path p is assumed to be full path
    exec 'so '.a:p
    return ""
endfunction

let s:stable_scripts = globpath(s:home.'/stable', '*.vim', 0, 1)
call sort(s:stable_scripts)
call map(s:stable_scripts, '<SID>LoadScript(v:val)')
if isdirectory(s:home.'/experimental')
    let s:experimental_scripts = globpath(s:home.'/experimental', '*.vim', 0, 1)
    call sort(s:experimental_scripts)
    call map(s:experimental_scripts, '<SID>LoadScript(v:val)')
endif
