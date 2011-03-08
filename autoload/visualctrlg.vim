" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


function! visualctrlg#load() "{{{
    " dummy function to load this script.
endfunction "}}}


function! visualctrlg#report(verbose) "{{{
    let default = 1
    let sleep_arg = v:count != 0 ? v:count : default
    let text = s:get_selected_text()

    let lines_num = getpos("'>")[1] - getpos("'<")[1] + 1
    if a:verbose
        echo printf('%d line(s), %d byte(s), %d char(s), %d width, %d display width',
        \           lines_num, strlen(text), s:strchars(text), strwidth(text), strdisplaywidth(text))
    else
        echo printf('%d line(s), %d byte(s), %d char(s)',
        \           lines_num, strlen(text), s:strchars(text))
    endif

    " Sleep to see the output in command-line.
    execute 'sleep' sleep_arg
endfunction "}}}

function! visualctrlg#report_verbosely(...) "{{{
    return call('visualctrlg#report', [1] + a:000)
endfunction "}}}

function! visualctrlg#report_briefly(...) "{{{
    return call('visualctrlg#report', [0] + a:000)
endfunction "}}}


function! s:get_selected_text() "{{{
    let save_z      = getreg('z', 1)
    let save_z_type = getregtype('z')
    try
        silent normal! gv"zy
        return @z
    finally
        call setreg('z', save_z, save_z_type)
    endtry
endfunction "}}}

" strchars() {{{
if exists('*strchars')
    function! s:strchars(expr)
        return strchars(a:expr)
    endfunction
else
    function! s:strchars(expr)
        return strlen(substitute(a:expr, '.', 'x', 'g'))
    endfunction
endif
" }}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
