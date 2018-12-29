" Python specific options.

" Set pyls, but use jedi for completion.
let g:LanguageClient_serverCommands.python = ['pyls']
if get(g:, 'leoyolo_prefer_ncm2', 0) == 1
    call ncm2#override_source('LanguageClient_python', {'enable': 0})
endif

" ale-python
let g:ale_linters.python = ['pylint', 'pycodestyle']
let g:ale_python_pylint_use_global = 0
let g:ale_python_pycodestyle_use_global = 0
let g:ale_python_pylint_options =
    \ '--disable=invalid-name,bare-except,too-many-arguments --extension-pkg-whitelist=torch,cv2'
let g:ale_python_pycodestyle_options = '--ignore=E501,E226,E265'
