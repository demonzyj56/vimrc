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

command! -nargs=+ -complete=help HH :help <args>
command! -nargs=+ -complete=help VH :vertical help <args>
