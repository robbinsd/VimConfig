function! RespondToSwap ()
    let workingDirPath = Strip(system('pwd'))
    let fileDir = expand('%:h')
    let fileName = expand('%:t')

    call system('cd '.fileDir)
    let fileDirPath = Strip(system('pwd'))

    " vim -r sees the swap files in the current directory.
    " Since we switched to the directory containing the file, we will now
    " look in its directory for corresponding swap files.
    let swapfileInfo = Strip(system('vim -r'))
    let swapfileInfoLines = split(swapfileInfo, '\n')
    echo swapfileInfoLines[0]
    "echo swapfileInfoLines[1]
    "if (&modified)
    "    let v:swapchoice='q'
    "endif

    "Change directory back to original working directory, so that user does
    "not notice that we changed the working directory.
    call system('cd '.workingDirPath)
endfunction
autocmd  SwapExists * :call RespondToSwap()
"call RespondToSwap()
"autocmd InsertEnter * echo <afile>
"echo v:swapname
"echo @%
"echo expand("%")
"echo expand("%:t")  returns tail (i.e. myFile.txt)
"

function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

