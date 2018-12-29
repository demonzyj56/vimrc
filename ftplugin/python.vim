
" Port from pymode
setlocal nowrap
setlocal commentstring=#%s
setlocal define=^\s*\\(def\\\\|class\\)
if exists('+colorcolumn')
    setlocal colorcolumn=80
endif
