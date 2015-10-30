"There are lots of bugs in the online plugins, do not waste time with it!!
"so ~/.vim/ToggleCommentify_incompatible.vim
"nmap <s-a-F12> :call ToggleCommentify()<CR>
"nmap <F12> :TC<cr>

"I use a simple function which can comment/uncomment line
"type :hepl =~
function! ToggleCommentLineAndMoveDown()
"    Only the filename (without path)
"    you can quickly check by typing in normal mode
"    :!echo %:t
    let filename = expand("%:t")
"    The filename with path
"    let filename = expand("%:p")
"    Only the path
"    let filename = expand("%:p:h")

"    DON'T COMMENT empty lines
    let IsBlankLine = getline(".")
    if IsBlankLine == $
        norm j
        return
    endif

    let fileType = &ft
    if fileType == 'tex'
        let commentSymbol = '%'
    elseif fileType == 'vim'
        let commentSymbol = '"'
    elseif fileType == 'grads'
        let commentSymbol = '\*'
    elseif fileType == 'fortran'
        let commentSymbol = '!'
    elseif fileType == 'c' || fileType == 'cpp' || fileType == 'php'
        let commentSymbol = '//'
    elseif fileType =~ '[^w]*sh$' || fileType == 'make' || fileType == 'python' || fileType == 'perl' || filename =~ '.screenrc'
        let commentSymbol = '#'
    else
"        for IDL scripts
        let commentSymbol = ';'
    endif

  if getline(".") =~ '^'.commentSymbol.'.*'
    norm 0xj
"    if the comment symbol IS NOT at the beginning of the line
  elseif getline(".") =~ '^[^'.commentSymbol.']\s*'.commentSymbol.'.*'
"    UNCOMMENT
    exe 'norm 0f'.commentSymbol.'xj'
  else
"   COMMENT at the beginning of the line
    if fileType == 'grads'
        exe 'norm I*'
    else
        exe 'norm I'.commentSymbol
    endif
"   MOVE the cursor down
        norm j
  endif

"  if getline(".") =~ '^;.*'
"    norm 0xj
"  elseif getline(".") =~ ';.*'
"    norm 0f;xj
"  else
"    norm I;
"    norm j
"  endif

endfunction
