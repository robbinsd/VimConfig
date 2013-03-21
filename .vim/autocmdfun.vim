function! RespondToSwap ()
    let workingDirPath = Strip(system('pwd'))
    let fileDir = expand('%:h')
    let fileName = expand('%:t')
    let swapfileNamePat = '^\.' . fileName . 's[a-z][a-z]$'

    call system('cd '.fileDir)
    let fileDirPath = Strip(system('pwd'))

    " vim -r sees the swap files in the current directory.
    " Since we switched to the directory containing the file, we will now
    " look in its directory for corresponding swap files.
    "let rawSwapfileInfo = system('vim -r')
    "let rawSwapfileInfoLines = split(rawSwapfileInfo, '\n')
    "" Strip all lines
    "call map(rawSwapfileInfoLines, string(Strip) . '(v:val)')
    "let swapfileInfo = join(rawSwapfileInfoLines, "\n")
    "let inDirSplitTexts = ['In current directory:', 'In directory ~/tmp:', 'In directory /var/tmp', 'In directory /tmp']
    "let swapNumSplitTexts = ['\n\d+.    ']
    "let splitTextPat = '\v(' . join(inDirSplitTexts+swapNumSplitTexts,'|') . ')'
    "let swapfileInfos = split(swapfileInfo, splitTextPat)


    "let swapFileObjs = []
    "let swapFileObj = {}
    "for line in swapfileInfoLines
    "    let line = Strip(line)
    "    if line == 'In current directory:'

    "    endif
    "endfor

    "echo swapfileInfoLines[0]
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
    let newlineMarker = 'Ƃ'
    let inputStrNoNewline = substitute(a:input_string, '\n', newlineMarker, 'g')
    let whitespace = '[\s'.newlineMarker.']*'
    let strippedInput = substitute(inputStrNoNewline, '^'.whitespace.'\(.*\)'.whitespace.'$', '\1', '')
    echo strippedInput 
    return substitute(a:input_string, newlineMarker, '\n', 'g')
endfunction

function! Lol()
    let rawSwapfileInfo = system('vim -r')
    let rawSwapfileInfoLines = split(rawSwapfileInfo, '\n')
    " Strip all lines
    call map(rawSwapfileInfoLines, 'Strip(v:val)')
    let swapfileInfo = join(rawSwapfileInfoLines, "\n")
    let inDirSplitTexts = ['In current directory:', 'In directory \~/tmp:', 'In directory /var/tmp:', 'In directory /tmp:']
    let swapNumSplitTexts = ['\n\d+.    ']
    let splitTextPat = '\v(' . join(inDirSplitTexts+swapNumSplitTexts,'|') . ')'
    let swapfileInfos = split(swapfileInfo, splitTextPat)
    call map(swapfileInfos, 'Strip(v:val)')
    function! IsNotNone(str)
        return a:str != '-- none --'
    endfunction
    call filter(swapfileInfos, 'IsNotNone(v:val)')
    echo swapfileInfos
endfunction
