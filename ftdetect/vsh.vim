" recognize .vsh files
if has("autocmd")
    autocmd BufNewFile,BufRead *.vsh setfiletype vsh
endif
