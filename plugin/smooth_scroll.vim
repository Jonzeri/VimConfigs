if get(g:,'loaded_smooth_scroll', 0) == 1
    finish
endif
let g:loaded_smooth_scroll = 1

if !has("reltime")
    echom "vim-smooth-scroll requires +reltime feature"
    finish
endif

" This controls how fast the window scrolls.
if !exists("g:ms_per_line")
    let g:ms_per_line=10
endif

" Replace scroll keys
if get(g:, "scroll_disable_mapping", 0) != 1
    nnoremap <silent> j :call smooth_scroll#line_down()<CR>
    nnoremap <silent> k :call smooth_scroll#line_up()<CR>
endif
