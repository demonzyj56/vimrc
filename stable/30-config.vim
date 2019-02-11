" Here comes all the custom things

" leader key
let mapleader=","
let maplocalleader="\\"

" Tags
set tags=./.tags;,.tags

" wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.db,*.sqlite,*~,*.pkl,*.npy
set wildignore+=*.o,*.obj,.git,.svn,.hg,*.rbc,*.pyc,__pycache__

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
    \ '.git', '.git/',
    \ '.root', '.idea/', '.svn/', '.hg/', '.project', '.ropeproject',
    \ '.bzr', '.github/'
    \ ]

" Display help at ease
command! -nargs=+ -complete=help HH :help <args>
command! -nargs=+ -complete=help VH :vertical help <args>

" Specify python version for nvim before loading any plugins.
if filereadable(s:vim_bin . '/python3')
    let g:python3_host_prog = s:vim_bin . '/python3'
elseif !has('win32')
    let g:python3_host_prog = '/usr/bin/python3'
else
    let g:leoyolo_python3_root = s:vim_bin.'/Python37'
    let g:python3_host_prog = g:leoyolo_python3_root.'/python.exe'
    let $PATH = g:leoyolo_python3_root.'/Scripts'.';'.$PATH
endif
if filereadable(s:vim_bin . '/python2')
    let g:python_host_prog = s:vim_bin . '/python2'
elseif !has('win32')
    let g:python_host_prog = '/usr/bin/python2'
else
    let g:python_host_prog = 'C:\\Python27\python.exe'
endif
