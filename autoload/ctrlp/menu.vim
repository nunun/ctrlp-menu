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

let s:select = "default"
function! ctrlp#menu#select(...)
  let s:select = (a:0 <= 0)? "default" : a:1
endfunc

function! ctrlp#menu#init()
  let menu = []
  for item in g:ctrlp_menu[s:select]
    if !exists("item[2]") || item[2]
      call add(menu, item[0])
    endif
  endfor
  return menu
endfunc

function! ctrlp#menu#accept(mode, str)
  let filter = 'v:val[0] == a:str && (!exists("v:val[2]") || v:val[2])'
  let lines  = filter(copy(g:ctrlp_menu[s:select]), filter)
  call ctrlp#exit()
  redraw!
  if len(lines) > 0 && len(lines[0]) > 1
    let s:mode = a:mode
    let s:str  = a:str
    let s:cmd  = lines[0][1]
    if type(s:cmd) == 2
      let s:cmd = s:cmd(s:mode, s:str)
    endif
    if s:cmd =~ '^@'
      let s:cmd = s:cmd[1:]
      call feedkeys("\<plug>(ctrlp-menu-launch)")
    elseif s:cmd =~ '^!'
      silent exe s:cmd
    else
      exe s:cmd
    endif
  endif
endfunction

function! ctrlp#menu#launch()
  return s:cmd
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
