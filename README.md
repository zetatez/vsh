# VSH 
VSH is a vim shell, a vim plugin! It's elegant and efficient.

With VSH, we can take full advantage of the vim to interact with the terminal. For example, we can extend `vsh` with [ultisnips](https://github.com/SirVer/ultisnips) plugin by creating a bunch of snippets to achieve our own auto-completion.

[BiliBili](https://b23.tv/437IxV)

![vsh](https://raw.githubusercontent.com/zetatez/vsh/main/pic/20210627022724.png)

### Installation
- vim-plug is required, add following lines to your vim-plug session of your vimrc file.
```vim
""""""
"""""" vsh
plug "zetatez/vsh"
" let g:vsh_send_line = "<ENTER>"
" let g:vsh_send_selection= "<ENTER>"
" let g:vsh_exit = "<ESC><ESC>"
" let g:vsh_exit_cmd = "qq"

""""""
"""""" optional: snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Trigger configuration. You need to change this to something other than <\> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger = '<TAB>'
let g:UltiSnipsJumpForwardTrigger = '<C-J>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDirectories = ['~/.ultisnips/']
```
then
```bash
vim +PlugInstall
```

- install vsh cli tool
```bash
git clone git@github.com:zetatez/vsh.git
cd vsh

# vsh
sudo make install

# optional: ultisnips
mkdir ~/.ultisnips
cp vsh.snippets ~/.ultisnips/
```

### Usage
Here we go !
```bash
vsh

```

Hints,
```
normal mode, `<ENTER>`      send current line to the terminal
visual mode, `<ENTER>`      send selected lines to the terminal
normal mode, `<ESC><ESC>`   quit vsh
cli    mode, `:qq`          quit vsh
```

### One more tip !
- Try to use [ultisnips](https://github.com/SirVer/ultisnips) plugin to create some your own snippets. 

