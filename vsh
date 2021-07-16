#!/bin/bash - 

# MIT License

# Copyright (c) 2021 Lorenzo

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

if ! [[ -e ~/.vsh ]] 
then
	mkdir ~/.vsh
fi

helpMe() {
echo """
NAME
	vsh - vim shell 

SYNOPSIS
	vsh [-a num] [-d num] [-k num] [-l] [-h]

DESCRIPTION
	x is a vim shell.

	The options are as follows:
	-a  attach to exit session  
		 vsh -a num

	-d  dettach to exit session  
		 vsh -d num
	
	-k  kill to exit session  
		 vsh -k num

	-l  list all sessions 
		 vsh -l

	-h  help 
		 vsh -h

AUTHOR
	Lorenzo<zetatez@icloud.com>

LICENSE	
	MIT
"|less
    exit 0
}


list_tmux_session() {
	tmux ls|sort
	exit 0 
}


attach_tmux_session() {
	num=$OPTARG
	tmux attach -t "vsh-$num"
	unset num
	exit 0 
}


detach_tmux_session() {
	num=$OPTARG
	tmux ls|grep "vsh-$num"|awk -F: '{print $1}'|awk '{print "tmux detach-client -s "$1}'|sh
	unset num
	exit 0 
}


kill_tmux_session() {
	num=$OPTARG
	tmux ls|grep "vsh-$num"|awk -F: '{print $1}'|awk '{print "tmux kill-session -t "$1}'|sh
	unset num
	exit 0 
}


login() {
	tmux ls|grep "vsh-" >> /dev/null
	if [[ $? == 0 ]]
	then
		inc=$(tmux ls|grep "vsh-"|awk -F: '{print $1}'|awk -F- '{print $2}'|sort -n|tail -n 1)
		let inc+=1
	else
		inc=1
	fi

	now=$(date +%Y%m%d.vsh)
	if ! [[ -e ~/.vsh/$now ]] 
	then
		touch ~/.vsh/$now
	fi

	cur=$(date +%Y%m%dT%H%M%S.vsh)
	cp -f ~/.vsh/$now ~/.vsh/$cur

	# open file at last line
	cmd="vim + ~/.vsh/$cur"

	session="vsh-$inc"
	tmux new -d -s $session
	tmux send-keys -t $session "$cmd" ENTER
	tmux attach -t $session
	mv -f ~/.vsh/$cur ~/.vsh/$now

	unset now
	unset inc
	unset cmd
	unset session
	exit 0 
}


# x: list all sessions 
if [[ $# == 0 ]]
then
	login
fi

while getopts :a:d:k:lh opt
do
	case "$opt" in
		a) attach_tmux_session ;;
		d) detach_tmux_session ;;
		k) kill_tmux_session ;;
		l) list_tmux_session ;;
		h) helpMe ;;
		*) echo "Unknown option: $opt" ;;
	esac
done

shift $[ $OPTIND - 1 ]

for var in "$@"
do
	:
done

unset var

