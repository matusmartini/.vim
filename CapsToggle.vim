command -nargs=0 Caps :call s:Caps()
command -nargs=0 Mixed :call s:Mixed()
function s:Caps()
  im a A
  im b B
  im c C
  im d D
  im e E
  im f F
  im g G
  im h H
  im i I
  im j J
  im k K
  im l L
  im m M
  im n N
  im o O
  im p P
  im q Q
  im r R
  im s S
  im t T
  im u U
  im v V
  im w W
  im x X
  im y Y
  im Z Z
  echo "CAPS ON"
  hi LineNr term=underline ctermfg=3 guifg=Red3 guibg=#cccccc
endfunction

function s:Mixed()
  im a a
  im b b
  im c c
  im d d
  im e e
  im f f
  im g g
  im h h
  im i i
  im j j
  im k k
  im l l
  im m m
  im n n
  im o o
  im p p
  im q q
  im r r
  im s s
  im t t
  im u u
  im v v
  im w w
  im x x
  im y y
  im z z
  echo "Caps Off"
  hi LineNr term=underline ctermfg=3 guifg=Red3 guibg=#99dddd
endfunction

map <F9> :Caps<cr>
imap <F9> <c-o>:Caps<cr>
map <F10> :Mixed<cr>
imap <F10> <c-o>:Mixed<cr>
