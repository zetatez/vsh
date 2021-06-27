" vsh syntax file
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

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "vsh"

" keyword
syntax keyword vshKeyword source export set unset readonly for in while until select break continue wait if fi then elif else case esac return do done printf echo read readline pwd exit shift test exec EOF eval getopts open read write xargs
syntax keyword vshKeyword man cron history locate alias bc vsh date hash lsblk lsusb tmux
syntax keyword vshKeyword df ls cd cp mv pwd rm mkdir rmdir dd clear fsck mount umount pv umask cdisk fdisk
syntax keyword vshKeyword tar unzip gzip rar
syntax keyword vshKeyword jobs nice fg bg ps top kill killall pkill htop du free uname hostname w finger nohup vmstat watch
syntax keyword vshKeyword find grep cat less more head tail wc diff touch sed awk gawk emacs vim nvim cut nl sort tee
syntax keyword vshKeyword chmod chown chattr chgrp chroot useradd userdel usermod groupadd groupdel groupmod groups passwd chpasswd sudo whoami who id
syntax keyword vshKeyword ping netstat traceroute curl wget ssh ifconfig ip scp ftp 
syntax keyword vshKeyword pacman pikaur
highlight link vshKeyword Keyword

" comment
syntax match vshcomment "\v#.*$"
highlight link vshcomment Comment

" operator
syntax match vshOperator "\v\+"
syntax match vshOperator "\v-"
syntax match vshOperator "\v\*"
syntax match vshOperator "\v/"
syntax match vshOperator "\v\="
syntax match vshOperator "\v\=\="
syntax match vshOperator "\v!="
syntax match vshOperator "\v!"
syntax match vshOperator "\v\~"
syntax match vshOperator "\v&"
syntax match vshOperator "\v|"
syntax match vshOperator "\v$"
syntax match vshOperator "\v`"
syntax match vshOperator "\v\""
syntax match vshOperator "\v'"
syntax match vshOperator "\v\?"
syntax match vshOperator "\v:"
syntax match vshOperator "\v\("
syntax match vshOperator "\v\)"
syntax match vshOperator "\v\["
syntax match vshOperator "\v\]"
syntax match vshOperator "\v\{"
syntax match vshOperator "\v\}"
highlight link vshOperator Operator

