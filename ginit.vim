" GUI setting. For gvim.
set guioptions-=T
set guioptions-=e
set guioptions-=m
set guioptions-=L
set guioptions-=r

set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
if has('nvim')
    try
        GuiFont! Hack:h11
        GuiTabline 0
    catch
    endtry
else
    if has("unix")
        try
            set guifont=Hack\ 11
        catch
        endtry
    elseif has("win32")
        try
            set guifont=Hack:h11
            set rop=type:directx,renmode:5
        catch
        endtry
    endif
endif
