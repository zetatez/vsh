# VSH 
VSH is a vim shell, a vim plugin! It's elegant and efficient.

With VSH, we can take full advantage of the vim to interact with the terminal. For example, we can extend `vsh` with `ultisnips` plugin by creating a bunch of snippets to achieve our own auto-completion.

[BiliBili](https://b23.tv/437IxV)

![vsh](https://raw.githubusercontent.com/zetatez/vsh/main/pic/20210627022724.png)

### Installation
- vim-plug 
```vim
plug "zetatez/vsh"
" let g:vsh_send_line = "<ENTER>"
" let g:vsh_send_selection= "<ENTER>"
" let g:vsh_exit = "<ESC><ESC>"
" let g:vsh_exit_cmd = "qq"
```
then
```bash
vim +PlugInstall
```

- install vsh
```bash
git clone git@github.com:zetatez/vsh.git
cd vsh
sudo make install
```

### Usage
Here we go !
```bash
vsh
```

Hints,
  1. normal mode, press `<ENTER>` to send current line to the terminal.
  2. visual mode, press `<ENTER>` to send selected lines to the terminal.
  3. normal mode, press `<ESC><ESC>` to quit vsh. 
  4. cli    mode, press `:qq` to quit vsh. 

### One more tip !
- Try to use ultisnips plugin to create some your own snippets. 


