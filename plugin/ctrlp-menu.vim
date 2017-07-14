command! CtrlPMenu cal ctrlp#init(ctrlp#menu#id())

if !exists("g:ctrlp_menu")
    let g:ctrlp_menu = []
endif

nnoremap <plug>(ctrlp-menu) :<c-u>CtrlPMenu<cr>

nnoremap <expr> <plug>(ctrlp-menu-launch) ctrlp#menu#launch()
