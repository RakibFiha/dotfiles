let g:neomake_python_python_exe = 'python3'
let g:neomake_c_enabled_makers = ['clang']
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_python_provider = 1
let g:spacevim_enable_guicolors = 0
let g:jedi#force_py_version = 3

function! myspacevim#before() abort
  let g:neomake_python_python_exe = 'python3'
  "" nnoremap jk <Esc>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

endfunction

function! myspacevim#after() abort
  "" iunmap jk
  " copy stuff to clipboard
  set clipboard=unnamedplus
  " change dir automatically
  set autochdir
endfunction
