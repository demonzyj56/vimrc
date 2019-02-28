" For completion plugins.
if get(g:, 'leoyolo_prefer_ycm', 0) != 0
    let g:airline#extensions#ycm#enabled = 1
    " YouCompleteMe
    " from https://zhuanlan.zhihu.com/p/33046090
    " TODO(leoyolo): config for correct path
    if has('win32') && has('python')
        let g:ycm_server_python_interpreter = 'C:\\Python27\\python.exe'
    endif
    let g:ycm_python_binary_path = 'python'
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_server_log_level = 'info'
    let g:ycm_min_num_identifier_candidate_chars = 2
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_complete_in_strings=1
    let g:ycm_key_invoke_completion = '<c-z>'
    nnoremap <silent> <leader>g :YcmCompleter GoTo<cr>
    noremap <c-z> <NOP>
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_semantic_triggers =  {
      \   'c' : ['->', '.'],
      \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
      \             're!\[.*\]\s'],
      \   'ocaml' : ['.', '#'],
      \   'cpp,objcpp' : ['->', '.', '::'],
      \   'perl' : ['->'],
      \   'php' : ['->', '::'],
      \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
      \   'ruby' : ['.', '::'],
      \   'lua' : ['.', ':'],
      \   'erlang' : [':'],
      \ }
    let g:ycm_semantic_triggers =  {
      \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
      \ 'cs,lua,javascript': ['re!\w{2}'],
      \ }
endif

" ncm2 and language server configs
if get(g:, 'leoyolo_prefer_ncm2', 0) != 0
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
    set shortmess+=c
    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new
    " line.
    " Use <TAB> to select the popup menu:
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


endif
