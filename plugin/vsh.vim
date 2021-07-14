" vsh
"
" MIT License

" Copyright (c) 2021 Lorenzo

" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:

" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.

" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

if exists("g:did_load_vsh")
    finish
endif
let g:did_load_vsh = 1


function! VSHNewTerminalBuffer()
	" get exist terminal buffer
	let g:terminal_buffer = get(g:, 'terminal_buffer', -1)

	" create a terminal buffer if not exist 
	if g:terminal_buffer == -1 || !bufexists(g:terminal_buffer)
		terminal
		let g:terminal_buffer = bufnr('')
		wincmd p
		exec "resize -16" 
	" split a new window if terminal buffer hidden
	elseif bufwinnr(g:terminal_buffer) == -1
		exec 'sbuffer ' . g:terminal_buffer
		wincmd p
		exec "resize -16" 
	endif
endfunction


function! VSHSend(...)
	let b:cmd = a:1

	call VSHNewTerminalBuffer()
	
	if g:terminal_buffer
		call term_sendkeys(g:terminal_buffer, b:cmd . "\<cr>")
	endif
endfunction


function! VSHSendRange(line_start, line_end)
    call VSHNewTerminalBuffer()
	if g:terminal_buffer
		call term_sendkeys(g:terminal_buffer, join(getline(a:line_start, a:line_end), "\<cr>") . "\<cr>")
	endif
endfunction


function! VSHSkipEmptyLine()
	let b:line = getline(".")
	let b:lineidx = line(".")
	if strlen(b:line) == 0 && b:lineidx < g:end
		exe ":norm j0"
		call VSHSkipEmptyLine()
	endif
endfunction


function! VSHSendLine()
	let g:end = line("$")
	call VSHSkipEmptyLine()
	let b:line = getline(".")
	call VSHSend(b:line)
	exe ":norm j0"
	call VSHSkipEmptyLine()
	exe ":norm zz"
endfunction


function! VSHSendLineAndStay()
    let b:line = getline(".")
    if strlen(b:line) > 0
		call VSHSend(b:line)
    endif
endfunction


function! VSHSendSelection()
    if line("'<") == line("'>")
		let b:line = getline(".")
        " let b:i = col("'<") - 1
        " let b:j = col("'>") - i
        " let b:l = getline("'<")
        " let b:line = strpart(b:l, b:i, b:j)
		if strlen(b:line) != 0
			call VSHSend(b:line)
		endif
    else
		let b:line_start = line("'<")
		let b:line_end = line("'>")
		call VSHSendRange(b:line_start, b:line_end)
    endif
endfunction


function! VSHExit()
	if g:terminal_buffer
		call term_sendkeys(g:terminal_buffer, "exit" . "\<cr>")
	endif
	execute "wq!"
endfunction


if !exists("g:vsh_send_line")
    let g:vsh_send_line = "<ENTER>"
endif

if !exists("g:vsh_send_selection")
    let g:vsh_send_selection= "<ENTER>"
endif

if !exists("g:vsh_exit")
    let g:vsh_exit= "<ESC><ESC>"
endif

if !exists("g:vsh_exit_cmd")
    let g:vsh_exit_cmd= "qq"
endif

exe 'autocmd FileType vsh nnoremap ' . g:vsh_send_line . ' :call VSHSendLine()<CR>'
exe 'autocmd FileType vsh vnoremap ' . g:vsh_send_selection . ' :call VSHSendSelection()<CR>'
exe 'autocmd FileType vsh nnoremap ' . g:vsh_exit . ' :call VSHExit()<CR>'
exe 'autocmd FileType vsh cnoremap ' . g:vsh_exit_cmd . ' :call VSHExit()<CR>'

" autocmd FileType vsh nnoremap <ENTER> :call VSHSendLine()<CR>
" autocmd FileType vsh vnoremap <ENTER> :call VSHSendSelection()<CR>
" autocmd FileType vsh nnoremap <ESC><ESC> :call VSHExit()<CR>
" autocmd FileType vsh cnoremap qq :call VSHExit()<CR>

