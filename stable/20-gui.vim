" GUI setting. For gvim.
if !has('gui_running')
    finish
endif
set background=dark
set guioptions-=T
set guioptions-=e
set guioptions-=m

set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
if has("unix")
    try
        set guifont=Hack\ 10
    catch
    endtry
elseif has("win32")
    try
        set guifont=Hack:h10
        set rop=type:directx,renmode:5
    catch
    endtry
endif
