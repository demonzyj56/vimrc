" leader key
let mapleader=","
let maplocalleader="\\"

" My custom keymaps
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader><cr> :nohl<cr>
nnoremap <silent> <leader>. :lcd %:p:h<cr> <bar> :pwd<cr>
nnoremap <C-h> <C-w>=<C-w>h
nnoremap <C-j> <C-w>=<C-w>j
nnoremap <C-k> <C-w>=<C-w>k
nnoremap <C-l> <C-w>=<C-w>l
nnoremap <silent> <leader>l :bnext<cr>
nnoremap <silent> <leader>h :bprevious<cr>
nnoremap <silent> <leader>bd :bd<cr>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call <SID>VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

function! s:VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
