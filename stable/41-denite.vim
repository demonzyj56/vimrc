" My configs for denite

" Check whether we have denite, above all.
if !has_key(g:plugs, 'denite.nvim')
    finish
endif

if executable('ag')
    call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', '']
        \ )
	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'default_opts',
		\ ['-i', '--vimgrep']
        \ )
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
endif
call denite#custom#option('default', 'statusline', v:false)
" default mapping for denite
nnoremap <leader>dg :Denite grep<cr>
nnoremap <leader>db :Denite buffer<cr>
nnoremap <leader>df :Denite file_rec<cr>
nnoremap <leader>dm :Denite file_mru<cr>
nnoremap <leader>dd :Denite directory_mru<cr>
