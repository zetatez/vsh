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


function! VSHSendLine(...)
	let l:cmd = a:1
	call VSHNewTerminalBuffer()
	if g:terminal_buffer
		call term_sendkeys(g:terminal_buffer, l:cmd . "\<cr>")
	endif
endfunction


function! VSHSendRange(line_start, line_end)
    call VSHNewTerminalBuffer()
	if g:terminal_buffer
		call term_sendkeys(g:terminal_buffer, join(getline(a:line_start, a:line_end), "\<cr>") . "\<cr>")
	endif
endfunction


function! VSHSkipEmptyLine()
	let l:line = getline(".")
	let l:lineidx = line(".")
	let l:lastline = line("$")
	if strlen(l:line) == 0 && l:lineidx < l:lastline
		exe ":norm j0"
		call VSHSkipEmptyLine()
	endif
endfunction


" function VSHSendCurrentLineAndGoToNextLine()
" 	let l:line = getline(".")
" 	if strlen(l:line) > 0
" 		call VSHSendLine(l:line)
" 		exe ":norm j0"
" 		exe ":norm zz"
"     endif
" endfunction


function! VSHSendCurrentLine()
	let l:lastline = line("$")
	call VSHSkipEmptyLine()
	let l:line = getline(".")
	call VSHSendLine(l:line)
	exe ":norm j0"
	call VSHSkipEmptyLine()
	exe ":norm zz"
endfunction


function! VSHSendCurrentLineSelection()
    if line("'<") == line("'>")
        let l:i = col("'<") - 1
        let l:j = col("'>") - l:i
        let l:l = getline("'<")
        let l:line = strpart(l:l, l:i, l:j)
        call VSHSendLine(l:line)
	else
		call VSHSendRange(line("'<"), line("'>"))
	endif
endfunction


function! VSHSendSelection()
    if line("'<") == line("'>")
        let l:i = col("'<") - 1
        let l:j = col("'>") - l:i
        let l:l = getline("'<")
        let l:line = strpart(l:l, l:i, l:j)
        call VSHSendLine(l:line)
	else
		call VSHSendRange(line("'<"), line("'>"))
	endif
endfunction


function! VSHQuit()
	if g:terminal_buffer
		call term_sendkeys(g:terminal_buffer, "exit" . "\<cr>")
	endif
	execute "wq!"
endfunction


if !exists("g:vsh_send_line")
    let g:vsh_send_line = "<ENTER>"
endif

if !exists("g:vsh_send_current_line_selection")
    let g:vsh_send_current_line_selection= "<ENTER>"
endif

if !exists("g:vsh_exit")
    let g:vsh_exit= "<ESC><ESC>"
endif

if !exists("g:vsh_exit_cmd")
    let g:vsh_exit_cmd= "qq"
endif

exe 'autocmd FileType vsh nnoremap ' . g:vsh_send_line . ' :call VSHSendCurrentLine()<CR>'
exe 'autocmd FileType vsh vnoremap ' . g:vsh_send_current_line_selection . '<ESC>:call VSHSendCurrentLineSelection()<CR>'
exe 'autocmd FileType vsh nnoremap ' . g:vsh_exit . ' :call VSHQuit()<CR>'
exe 'autocmd FileType vsh cnoremap ' . g:vsh_exit_cmd . ' :call VSHQuit()<CR>'

" autocmd FileType vsh nnoremap <ENTER> :call VSHSendCurrentLine()<CR>
" autocmd FileType vsh vnoremap <ENTER> :call VSHSendCurrentLineSelection()<CR>
" autocmd FileType vsh nnoremap <ESC><ESC> :call VSHQuit()<CR>
" autocmd FileType vsh cnoremap qq :call VSHQuit()<CR>


