command! CtrlPMenu cal ctrlp#init(ctrlp#menu#id())

nnoremap <plug>(ctrlp-menu) :<c-u>CtrlPMenu<cr>

nnoremap <expr> <plug>(ctrlp-menu-launch) ctrlp#menu#launch()

nmap <C-p><C-p><C-p> :CtrlPMenu<CR>

