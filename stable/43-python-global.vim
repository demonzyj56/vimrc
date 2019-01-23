" Python specific options.

let g:LanguageClient_serverCommands.python = ['pyls']

" ale-python
let g:ale_linters.python = ['pylint', 'pycodestyle']
let g:ale_python_pylint_use_global = 0
let g:ale_python_pycodestyle_use_global = 0
let g:ale_python_pylint_options =
    \ '--disable=invalid-name,bare-except,too-many-arguments --extension-pkg-whitelist=torch,cv2'
let g:ale_python_pycodestyle_options = '--ignore=E501,E226,E265'
