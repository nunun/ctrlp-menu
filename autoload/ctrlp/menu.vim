if exists('g:loaded_ctrlp_menu') && g:loaded_ctrlp_menu
  finish
endif
let g:loaded_ctrlp_menu = 1

let s:config_file = get(g:, 'ctrlp_menu_file', '~/.ctrlp-menu')

let s:menu_var = {
\  'init':   'ctrlp#menu#init()',
\  'exit':   'ctrlp#menu#exit()',
\  'accept': 'ctrlp#menu#accept',
\  'lname':  'menu',
\  'sname':  'menu',
\  'type':   'path',
\  'sort':   0,
\  'nolim':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:menu_var)
else
  let g:ctrlp_ext_vars = [s:menu_var]
endif

function! ctrlp#menu#init()
  let file = fnamemodify(expand(s:config_file), ':p')
  let s:list = filereadable(file) ? filter(map(readfile(file), 'split(iconv(v:val, "utf-8", &encoding), "\\t\\+")'), 'len(v:val) > 0 && v:val[0]!~"^#"') : []
  let s:list += [["--edit-menu--", printf("split %s", s:config_file)]]
  return map(copy(s:list), 'v:val[0]')
endfunc

function! ctrlp#menu#accept(mode, str)
  let lines = filter(copy(s:list), 'v:val[0] == a:str')
  call ctrlp#exit()
  redraw!
  if len(lines) > 0 && len(lines[0]) > 1
    let s:cmd = lines[0][1]
    execute "normal \<plug>(ctrlp-menu-launch)"
  endif
endfunction

function! ctrlp#menu#launch()
  if s:cmd =~ '^?'
    return s:cmd[1:]
  elseif s:cmd =~ '^!'
    silent exe s:cmd
  else
    exe s:cmd
  endif
  return ''
endfunction

function! ctrlp#menu#exit()
  if exists('s:list')
    unlet! s:list
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#menu#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
