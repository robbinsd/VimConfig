function! RespondToSwap ()

    if (&modified)
        let v:swapchoice='q'
    endif
endfunction
autocmd  SwapExists * :call RespondToSwap()
"call RespondToSwap()
"autocmd InsertEnter * echo <afile>
"echo v:swapname
"echo @%
"echo expand("%")
"echo expand("%:t")  returns tail (i.e. myFile.txt)
"

