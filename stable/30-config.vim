" Here comes all the custom things

" Tags
set tags=./.tags;,.tags

" leader key
let mapleader=","
let maplocalleader="\\"

" wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.db,*.sqlite,*~,*.pkl,*.npy
set wildignore+=*.o,*.obj,.git,.svn,.hg,*.rbc,*.pyc,__pycache__

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call <SID>VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Setup path and some executables, especially ctags
" Add all folders under ~/.vim/bin to path.
if has('win32')
    let s:vim_bin = expand('~/vimfiles/bin')
else
    let s:vim_bin = expand('~/.vim/bin')
endif
let s:bin_paths_to_add 
    \ = filter(globpath(s:vim_bin, '*', 0, 1), 'isdirectory(v:val)') + [s:vim_bin]
if has('win32')
    let $PATH = join(s:bin_paths_to_add, ';').';'.$PATH
    if !has('python') || isdirectory('C:\\Python27')
        let $PATH = 'C:\\Python27'.';'.$PATH
    endif
else
    let $PATH = join(s:bin_paths_to_add, ':').':'.$PATH
endif

" Define a global variable for probject root
let g:leoyolo_project_root = [
    \ '.git', 'git/',
    \ '.root', '.idea', '.svn/', '.hg/', '.project', '.ropeproject',
    \ '.bzr', 'Makefile', 'CMakeLists.txt'
    \ ]


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
