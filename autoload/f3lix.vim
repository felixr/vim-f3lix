function! f3lix#window_smart_close() "{{{
  if winnr('$') != 1
    close
  endif
endfunction "}}}

function! f3lix#window_next() "{{{
  if winnr('$') == 1
    silent! normal! ``z.
  else
    wincmd w
  endif
endfunction "}}}

function! f3lix#window_tab_next() "{{{
  if tabpagenr('$') == 1 && winnr('$') == 1
    call s:split_nicely()
  elseif winnr() < winnr("$")
    wincmd w
  else
    tabnext
    1wincmd w
  endif
endfunction "}}}

function! f3lix#window_tab_prev() "{{{
  if winnr() > 1
    wincmd W
  else
    tabprevious
    execute winnr("$") . "wincmd w"
  endif
endfunction "}}}

" If window isn't splited, split buffer.
function! f3lix#window_split_toggle() " {{{
  let prev_name = winnr()
  silent! wincmd w
  if prev_name == winnr()
    call f3lix#window_split_nicely()
  else
    call f3lix#window_smart_close() 
  endif
endfunction " }}}

function! f3lix#window_split_nicely() " {{{
  if winwidth(0) > 2 * &winwidth
    vsplit
  else
    split
  endif
  wincmd p
endfunction
"}}}

" Delete current buffer.
function! f3lix#buffer_delete(is_force) "{{{
  let current = bufnr('%')

  call unite#util#alternate_buffer()

  if a:is_force
    silent! execute 'bdelete! ' . current
  else
    silent! execute 'bdelete ' . current
  endif
endfunction "}}}


" Shortens a string by removing chars from the middle
function! f3lix#string_shorten(str, len, mask)
  if a:len >= len(a:str)
    return a:str
  elseif a:len <= len(a:mask)
    return a:mask
  endif

  let len_head = (a:len - len(a:mask)) / 2
  let len_tail = a:len - len(a:mask) - len_head

  return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction "}}}
