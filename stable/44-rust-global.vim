" Rust settings
let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']
let g:ale_linters.rust = ['rls']
let g:ale_rust_rls_toolchain = 'stable'
let g:leoyolo_project_root += ['Cargo.toml']
