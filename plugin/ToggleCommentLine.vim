"There are lots of bugs in the online plugins, do not WASTE time with it!!
"so ~/.vim/ToggleCommentify_incompatible.vim
"nmap <s-a-F12> :call ToggleCommentify()<CR>
"nmap <F12> :TC<cr>

"I USE a simple function which can comment/uncomment line
"type :hepl =~
function! ToggleCommentLine()
"    GET the name of file you are editing
    let filename = expand("%:t")

    "COMMENT also the empty lines
    "GET filetype   :set filetype?


    let fileType = &ft
    if fileType == 'tex' || fileType == 'matlab'
        let commentSymbol = '%'
    elseif fileType == 'vim'
        let commentSymbol = '"'
    elseif fileType == 'grads'
        let commentSymbol = '\*'
    elseif fileType == 'fortran'
        let commentSymbol = '!'
    elseif fileType == 'c' || fileType == 'cpp' || fileType == 'php'
        let commentSymbol = '//'
    elseif fileType =~ '[^w]*sh$' || fileType == 'make' || fileType == 'python' || fileType == 'perl' || fileType == 'crontab'
        let commentSymbol = '#'
    elseif filename =~ '.screenrc' || filename =~ '[Rr]egistry*' || filename =~ 'cshrc_common' || fileType == 'cfg'
        let commentSymbol = '#'
    else
        "for IDL scripts
        let commentSymbol = ';'
    endif

  if getline(".") =~ '^'.commentSymbol.'.*'
    norm 0x
    "if the comment symbol IS NOT at the beginning of the line
  elseif getline(".") =~ '^[^'.commentSymbol.']\s*'.commentSymbol.'.*'
    "UNCOMMENT
    exe ':s+'.commentSymbol.'++'
  else
   "COMMENT at the beginning of the line
    if fileType == 'fortran'
        exe 'norm 0i'.commentSymbol
   "COMMENT with special character '*'
    elseif fileType == 'grads'
        exe 'norm 0i*'
   "COMMENT at the beginning of the text
    else
        exe 'norm I'.commentSymbol
    endif
  endif

endfunction
