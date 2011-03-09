" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if (exists('g:loaded_visualctrlg') && g:loaded_visualctrlg) || &cp
    finish
endif
let g:loaded_visualctrlg = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


vnoremap <silent> <Plug>(visualctrlg-verbosely) :<C-u>call visualctrlg#report_verbosely()<CR>
vnoremap <silent> <Plug>(visualctrlg-briefly)   :<C-u>call visualctrlg#report_briefly()<CR>


if !exists('g:visualctrlg_no_default_keymappings')
\   || !g:visualctrlg_no_default_keymappings
    silent! vmap <unique> g<C-g> <Plug>(visualctrlg-verbosely)
    silent! vmap <unique> <C-g>  <Plug>(visualctrlg-briefly)
endif


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
