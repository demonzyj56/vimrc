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
