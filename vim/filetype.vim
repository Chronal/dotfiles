if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.alg,*.algol   setfiletype algol
augroup END
