" Setting up alt key for terminal.
" See:
" http://www.skywind.me/blog/archives/2021
" https://github.com/skywind3000/vim-init/blob/master/init/init-config.vim

set winaltkeys=no
if $TMUX != ''
    " You have to set accordingly inside .tmux.conf
    " set-option -g escape-time 30
    set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
    set ttimeoutlen=80
endif
if has('nvim') == 0 && has('gui_running') == 0
    function! s:metacode(key)
        exec "set <M-".a:key.">=\e".a:key
    endfunction
    for i in range(10)
        call s:metacode(nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(nr2char(char2nr('a') + i))
        call s:metacode(nr2char(char2nr('A') + i))
    endfor
    for c in [',', '.', '/', ';', '{', '}']
        call s:metacode(c)
    endfor
    for c in ['?', ':', '-', '_', '+', '=', "'"]
        call s:metacode(c)
    endfor
endif

function! s:key_escape(name, code)
    if has('nvim') == 0 && has('gui_running') == 0
        exec "set ".a:name."=\e".a:code
    endif
endfunction

call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')
