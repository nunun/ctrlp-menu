command! CtrlPMenu cal ctrlp#init(ctrlp#menu#id())

"function s:Test(mode, str)
"    return "@:vimgrep "
"endfunc
"let g:ctrlp_menu = [["Test", function("s:Test")]]

if !exists("g:ctrlp_menu")
    let g:ctrlp_menu = []
endif

nnoremap <plug>(ctrlp-menu) :<c-u>CtrlPMenu<cr>

nnoremap <expr> <plug>(ctrlp-menu-launch) ctrlp#menu#launch()

nmap <C-p><C-p><C-p> :CtrlPMenu<CR>
