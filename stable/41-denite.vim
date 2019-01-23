" My configs for denite

" Check whether we have denite, above all.
" FIXME(leoyolo): temporary block Denite for nvim.
" I seldomly use it, though.
if !has_key(g:plugs, 'denite.nvim') || !has('nvim')
    finish
endif

" Setup default options for all buffers.
call denite#custom#option("_", {
  \ 'auto_accel': v:true,
  \ 'root_markers': g:leoyolo_project_root,
  \ 'updatetime': 0,
  \ 'highlight_matched_char': 'Function',
  \ 'highlight_matched_range': 'None',
  \ })
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
  \ split(&wildignore, ","))
call denite#custom#source('_', 'matchers',
  \ ['matcher/fruzzy'])
call denite#custom#source('_', 'sorters', ['sorter/sublime'])

" Ag for file/rec
call denite#custom#alias('source', 'file/rec/ag', 'file/rec')
call denite#custom#var('file/rec/ag', 'command',
  \ ['ag', '-f', '-U', '--nocolor', '--nogroup', '--hidden', '-g', ''])


" Change mappings.
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-x>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')


" default mapping for denite
nnoremap <leader>dg :<C-u>Denite grep<cr>
nnoremap <leader>db :<C-u>Denite buffer<cr>
nnoremap <leader>df :<C-u>Denite file/rec<cr>
nnoremap <leader>dm :<C-u>Denite file_mru<cr>
nnoremap <leader>dd :<C-u>Denite directory_mru<cr>
nnoremap <leader>dh :<C-u>Denite help<cr>
nnoremap <C-p> :<C-u>Denite file/rec/ag<cr>
nnoremap <C-n> :<C-u>Denite file_mru<cr>

" Defx settings
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
