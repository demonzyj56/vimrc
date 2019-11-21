nmap j gj
nmap k gk
if has_key(g:plugs, 'vimtex')
    nmap <F5> <plug>(vimtex-compile)
    nmap K <plug>(vimtex-doc-package)
endif
let b:AutoPairs = g:AutoPairs
let b:AutoPairs['$'] = '$'

