" USE VIM settings, rather then Vi settings (much better!)
" This must be first, because it changes other options as a side effect
set nocompatible

" ALLOW backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
set nobackup            "DO NOT KEEP a backup file, USE versions instead
"else
"  set backup           "KEEP a backup file
"endif
set history=50          "KEEP 50 lines of command line history
set ruler               "SHOW the cursor position all the time
set showcmd             "DISPLAY incomplete commands
"set incsearch           "DO incremental searching
set showmatch           "briefly JUMP to matching bracket if insert one
set showfulltag         "SHOW/INSERT the full tag with keyword options

" For Win32 GUI, REMOVE 't' flag from 'guioptions': no tearoff menu entries
"let &guioptions = substitute(&guioptions, "t", "", "g")

" TYPE gq for formatting
"set textwidth=70
set textwidth=0
set wrapmargin=0


" Only DO this part when compiled with support for autocommands.
if has("autocmd")
  "FORCE certain files have a specific syntax highlighting!!!
  "NOTE it's called before filetype and syntax on
  "SEE details in /homes/metogra/james/vim/prefix/share/vim/vim70/filetype.vim
  au BufNewFile,BufRead profile,help*.txt  call SetFileTypeShell('sh')
  "au BufNewFile,BufRead .bashrc.* call SetFileTypeSH("bash")
  au BufNewFile,BufRead ASSIGNS.*,*.cshrc,.ls_colors  call SetFileTypeShell('csh')
  au BufNewFile,BufRead vi,vimtips  setf vim
  au BufNewFile,BufRead msgFilterRules.dat  setf mailcap
  au BufNewFile,BufRead authorized_keys,id_rsa.pub,thunderbird*csv  setf mail
  au BufNewFile,BufRead idl.*ini,dale.txt,*.pro  setf idlang
  au BufNewFile,BufRead *.ncl setf ncl
  au BufNewFile,BufRead *namelist*,*.inp,*.jnl,*.in,*.nml,*.IN  setf fortran
  au BufNewFile,BufRead config*  setf make
  "mail files (in ~/maildir/*/cur)
  au BufEnter * if expand("%:p:h") =~ "maildir/.*cur" | setf mail | endif

  "au FileType cfg setlocal commentstring=#\ %s     "Overridden ToggleCommentLine.vim


  "ENABLE file type detection
  "USE the default filetype settings, so that mail gets 'tw' set to 72,
  "'cindent' is on in C files, etc.
  "Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  "VIM does not like files with no extension!!!
  "au BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=sh | endif
  "au BufNewFile,BufRead * if expand('%:t') == '.cshrc_common' | call SetFileTypeShell('csh') | endif
  "au BufNewFile,BufRead * if expand('%:t') == '.cshrc_common' | set syntax=sh | endif

  "PUT these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  "For all text files, SET 'textwidth' to 78 characters.
  "au FileType text setlocal textwidth=78

  "When editing a file, always JUMP to the last known cursor position.
  "Don't do it when the position is invalid or when inside an event handler
  "(happens when dropping a file on gvim).
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

"else
  "set autoindent		"SET autoindenting on
endif   "has("autocmd")

"set smartindent

"'ignorecase'  'ic'  'scs'  IGNORE case in search patterns unless I SAY so
set ignorecase smartcase
set whichwrap=<,>,[,]

no U u
" ctrl+r is REDO
"map <c-y> :redo<cr>


" ZZ = :x<cr>
"ino <c-s> <c-o>:diffo<cr><c-o>:mkview<cr><c-o>:w<cr>
"no K :diffo<cr>zM:mkview<cr>:w<cr>
no <f11>  :w<cr>
no <s-f11> :w!<cr>
"ino <f11>  <esc>:w<cr>li

" MAP f12 as f11, if not in Screen
if &term !~ 'screen*'
  no <f12> :w<cr>
  ino <f12>  <esc>:w<cr>li
endif

" SORT by the second column (-k2), treat the text as a number (n) and then sort in reverse (r)
"   then SORT by the third column
":%!sort -k2nr -k3nr


" zE DELETEs all folds, zd DELETEs the fold at the cursor
" zf/string CREATEs a fold from the cursor to the 'string'
" when it FREEZEs, <c-q> should fix it!!!
" c-s on some terminals STOPs data from arriving (e.g. a fast-scrolling display)
" c-z SUSPENDs vim -> can DO sequence of shell cmds, then TYPE 'fg' to COME back
" SCROLL up/down c-y/c-e
" zz CENTER your screen where your cursor is, zt (zb) top (bottom) of the window

"FREEZE terminal c-s
"UNFREEZE c-q


" Calculator WRITE result at cursor position in Insert mode
" <c-r>=(3+1)*5<cr>


" QUIT
no Q :q<cr>
no qQ :q!<cr>

" MAKE :QA behave like :qall (because I suck at typing)
"cno QA<cr> qa<cr>
"cno Q! q!    NOTE the difference w and w/o  <Enter>=<cr>
cno W<cr> w<cr>
cno WQ<cr> wq<cr>
cno qw q

" ALT mappings <a-*>
" JUMP quickly between the splits
" <c-w> with arrows WORKs in normal mode !!!
"no <a-Up> <c-w>k
"no <a-Down> <c-w>j
"no <a-Right> <c-w>l
"no <a-Left> <c-w>h

" ALLOW for quick resizing
no - <c-w>-
no + <c-w>+
" INCREASE/DECREASE width of the window by 10/20
"10<c-w>>  20<c-w><
" MAKE the current window as big as possible
"no _ <c-w>_
set wmh=0
" MAKE window sizes equal
no = <c-w>=

" ctrl-w DELETE the previous word (insert mode)
" DELETE current word
ino <f7> <c-o>dw
"no <f7> dw
"ino <f9> <c-o>u
"ino <f9> <c-o><c-r>
" {},() JUMP to empty line before/after paragraph

" shift + function keys does not work in SCREEN
" SEARCH (inverse search with shift)
"no <f3> n
"no <s-f3> N
"ino <f3> <esc>nni
"ino <s-f3> <esc>Ni

" MOVE cursor by display lines when wrapping
nn <Down> gj
nn <Up> gk
vn <Down> gj
vn <Up> gk
ino <Down> <c-o>gj
ino <Up> <c-o>gk

" Microsoft Office select in Visual
" First REMOVE trailing characters from the beginning of all lines :%s/^\s\{1,}\r*$//cg
" so you can JUMP with ctrl+arrows (SEE below)
cno <c-t> %s+^\s\{1,}\r*$++cgi

" REMOVE trailing whitespace:
" \s finds whitespace (a space or a tab), and \+ finds one or more occurrences
no <f7> :%s/\s\+$//cgi

"nn <c-down> }
"nn <c-up> {
"vn <c-down> }
"vn <c-up> {
"vn <s-left> (
"vn <s-right> )

" On Mac, cannot MAP the meta characters! :(
" MOVE by one word
"no <f6> w
ino <f6> <c-o>w
"no <f5> b
ino <f5> <c-o>b
" DEL to the BOL <c-u>
" DEL previous word <c-w>
" DEL to the EOL
ino <c-l> <c-o>D

" CAPITALIZE word
nn <f3> gUiw
" TOGGLE case http://vim.wikia.com/wiki/Switching_case_of_characters
" TOGGLE all text to lower/uppercase ggVGu/ggVGU
nn <f4> mpg~iw`p
ino <f4> <esc>lmpg~iw`pi

" SHOW the time and info about the opened file (TYPE tt quickly)
" :p modifier MAKEs the pathname absolute
no tt :!ls -la %:p<cr>


" If vim LAUNCHed on halo.atmos.umd.edu
"if system('hostname -s') != 'halo'


" F o l d i n g  FOLD zf UNFOLD za
au FileType fortran  so $HOME/.vim/syntax/fortran.fold.vim
"au FileType idlang  so ~/.vim/syntax/fold.begin.end.vim
no <space> za
" SEARCH only in open folds (unfolded text)
":set fdo-=search

" Vim saves AUTOMATICALLY and restores folds when a file is closed and re-opened
"au BufWinLeave *.pro mkview        ;fails when using vimdiff
"au BufWinEnter * silent lo   ;rather LIST filetypes since vimshell has problems
au BufWinEnter *.pro,*.vim,*.php,*.htm,*.html,*.css,*.txt,.alias,.*rc,.*rc_par silent lo
au FileType sh,csh silent lo

" SWITCH syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  if 0
    hi Comment ctermfg=Yellow
    "hi Comment ctermfg=76
    hi Constant ctermfg=White
    "hi Identifier ctermfg=Blue
    hi Identifier ctermfg=66 cterm=bold
    hi Special ctermfg=Magenta
    hi Number ctermfg=Cyan cterm=bold
    hi Type ctermfg=Grey
    "tags and my routines are as Typedef
    hi Typedef ctermfg=Brown
    hi Underlined ctermfg=Brown gui=underline
    hi Statement ctermfg=Red
    hi Function ctermfg=Red
    hi Keyword ctermfg=66 cterm=bold
    hi SpecialChar ctermfg=DarkGreen
    hi StatusLine term=reverse ctermfg=Blue ctermbg=Black
    "DarkRed,DarkGreen,DarMagenta available
    "when searching before 'enter' hit
    hi IncSearch cterm=none ctermfg=Yellow ctermbg=Green
    "when searching once 'enter' is hit
    hi Search cterm=none ctermfg=Grey ctermbg=Blue
  endif

  "iTerm on Mac colors
  if &term =~ '.*linux'
      hi Comment cterm=none
      hi Constant cterm=none
      hi Identifier cterm=none
      hi Special cterm=none
      hi Number cterm=none
      hi IncSearch ctermbg=Red
      hi Search ctermfg=Black
      hi DiffAdd ctermfg=black
      "hi DiffDelete ctermfg=black ctermbg=yellow
      hi DiffChange ctermfg=black
      "hi DiffText ctermfg=black ctermbg=yellow
      hi DiffText ctermfg=black
  endif

  hi DiffDelete ctermfg=4 cterm=bold ctermbg=black
  hi DiffText   ctermfg=2 cterm=bold ctermbg=1
  hi DiffChange ctermfg=2 cterm=bold ctermbg=5
  "hi DiffAdd    ctermfg=white
  if $HOSTNAME[0:4] == "narwh"
    "Best color combinations in this order for Added line (vimdiff)
    hi DiffAdd    ctermfg=yellow ctermbg=Green
    "hi DiffAdd    ctermfg=yellow ctermbg=Red
    "hi DiffAdd    ctermfg=white ctermbg=green
    "hi DiffAdd    ctermfg=yellow ctermbg=cyan
    "hi DiffAdd    ctermfg=white ctermbg=Red
    "hi DiffAdd    ctermfg=white ctermbg=cyan
    "hi DiffAdd  ctermbg=blue
    "hi DiffAdd    ctermfg=white ctermbg=Yellow
    "hi DiffAdd cterm=NONE ctermfg=white ctermbg=yellow gui=NONE guifg=bg guibg=Green
    "hi DiffAdd cterm=NONE ctermbg=Green gui=NONE guifg=bg guibg=Green
    "hi DiffDelete cterm=NONE ctermbg=Red gui=NONE guifg=bg guibg=Red
    "hi DiffChange cterm=NONE ctermbg=Yellow gui=NONE guifg=bg guibg=Yellow
    "hi DiffText cterm=NONE ctermbg=Magenta gui=NONE guifg=bg guibg=Magenta
  endif
  hi Folded term=standout ctermfg=black ctermbg=7
  hi Search ctermfg=black
  hi Todo term=none ctermfg=1 ctermbg=4
  " ADD a more visual cursor
  "set cursorline
  hi CursorLine ctermfg=black cterm=none ctermbg=yellow term=none
  "hi CursorLine cterm=none ctermbg=yellow term=none
  "set cursorcolumn
  hi CursorColumn ctermfg=black cterm=none ctermbg=yellow term=none
  " TOGGLE
  no <f6> :set cursorcolumn!<Bar>set cursorline!<CR>

  " MAKE easier to read highlighted text
  hi NoHighLight ctermbg=black
  "match NoHighLight /\S\+\(\s\+\|$\)/
  " CHANGE background of text only if in InsertMode
  au InsertEnter * match NoHighLight /\S\+\(\s\+\|$\)/
  " REVERT back to highlighted background behind text by only ignoring unusual string "NoHighLight"
  au InsertLeave * match NoHighLight /NoHighLight/

  "hi OverLength ctermbg=LightRed ctermfg=white guibg=#FFD9D9
  "match OverLength /\%133v.*/



  "USE 4 spaces when 'Tab' is hit, except in Makefiles
  set tabstop=8
  set shiftwidth=2
  set softtabstop=4
  set expandtab

  "HIGHLIGHT tabs
  au FileType python  setlocal list! listchars=tab:>-
  "TOGGLE highlight tabs and trailing spaces
  "ino <f6> <c-o>:set list! listchars=tab:>-,trail:*<cr>
  "no <c-t> :set list! listchars=tab:>-,trail:-<cr>

  au FileType make  setlocal noexpandtab
  au FileType changelog  setlocal noexpandtab
  "au FileType pro so /usr/share/vim/vim70/syntax/idl.vim
  au FileType python  setlocal expandtab

  "TOGGLE Spell-check on/off
  cno <f7> setlocal spell! spelllang=en_us
  "]s FIND the misspelled word after the cursor (Forward search)
  "[s FIND the misspelled word before the cursor (Backward search)
  "After you located the misspelled word, TYPE z= for suggestions
  "zg ADD the word under the cursor as good word in spellfile (your own dictionary)


  "TOGGLE search result highlighting
  "<f3> is reserved for Spaces on Mac :(
  "no <s-f3> :set hls!<bar>set hls?<cr>
  cno <f4> set hls!


  "HIGHLIGHT duplicate lines that follow each other
  "Careful c-a-f11 SWITCHes to different console
  "      - TRY coming back by pressing c-a-f4 (if accidentally hit)
  "no ,, /^\(\S*\)$\n\1$<cr>
  no ,, /^\(\.*\)$\n\1$<cr>
  "REMOVE them
  cno ,, %s/^\(.*\)$\n\1$/\1/cgi


endif   "gui_running (for highlighting)



" ENABLE mouse in all modes normal, visual, insert
"set mouse=a
"set mouse=n
"set mouse=c
"set mouse="" or just set mouse


" TOGGLE Paste mode on/off (TURN ON in Insert mode)
" very useful when PASTing a text into VIM to AVOID ugly indentation
set pastetoggle=<f2>
nn <f2> :set paste<cr>i


" DISABLE continuation of comments to the next line after typing <enter>
" This works only with colon after I and not with set formatoptions-=cro
":set formatoptions-=cro
" For csh files needed to over-rule ~/.vim/ftplugin/csh.vim
" For vim files this works
au Filetype * set formatoptions-=cro


" Never USE CAPSlock again! USE <f9> in Insert mode and ~ in Normal mode
" TURN off Capitalizing when changed to normal mode - SEE plugin/capslock.vim
" Because if CAPSlock is used then it is always forgotten, which is NO GOOD!
imap <f9>  <Plug>CapsLockToggle


" TYPE the name of the variable in the beginning of the line and then PRESS <f10>
"ino <f10> <esc>0dwiif ~exist(<c-o>p) then <c-o>p =
"no <f10> :%s/if n_elements(\(.*\)) eq 0 then/if \~exist(\1) then/cgi

" SEARCH for stops in IDL, SEARCH backwards by typing (capital) N
no <f10> /\<stop\><cr>
"no <f10> /^[^;]top<cr>

"REPLACE a line (Command mode)
"the space allows for (ctrl+arrows) jumps
cno <c-r> %s/^\(.*\)\(.*\)$/ \1\2/cgi<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
"SEARCH for whole words
no <c-h> /\<\><left><left>
"SEARCH from the beginning of the document, but first SET mark f
"then 'f GO (back) to mark f
no <c-f> mfgg/
"SPLIT window vertically with binded scrolling
cno VV vsp<cr>mvgg:set scrollbind<cr><c-w>lggLzt:set scrollbind<cr><c-w>h'v
cno Fm set foldmethod=manual
cno Se Search
"REPLACE the current line with line stored in the copy-buffer
nn yr pkddY

ino <c-k> <c-o>dd

"If you use Vim under screen, press Ctrl-A and then hit a. Screen then sends
"on a translation of Ctrl-A to the underlying program, Vim.

"AVOID 'backslashitis' :-) USE different separator
"s:/dir1/dir2/dir3/file:/dir4/dir5/file2:g

"LIST individual marks
":marks abcdefgh
"LIST mappings
":map :cmap :imap

"AVOID 07 being understood as an octal number
"c-a will increment (07 to 08) and not (07 to 10)
set nrformats=hex


" V I M  -  S h e l l
" ctrl+w e OPENs up a vimshell in a horizontally split window
" ctrl+w E                           vertically
" The shell window is be auto-closed after termination
" ctrl+w c EXITs !!!
"nn <c-w>e :new \| vimshell csh<cr>
"nn <c-w>E :vnew \| vimshell csh<cr>


" SEPARATE files to give the order, since allen is alphabetically favored
":tnext JUMPs to next tag if more with the same name
set tags=tags,~/tools/tags,~/.vim/tags
"JUMP to a tag c-t, RETURN after a tag jump c-t

set completeopt+=preview

set wildmenu

" MAP ` to avoid collisions with SCREEN attention mappings
" instead PRINT current time!
"nn ` :echo strftime("%c")<cr>

" PRINT very cool with syntax highlighted (thanks to Heng Xiao)
" EXPERIMENT with wrap, margin options first before printing a big thing
set printoptions=portrait:n,number:y
" Then PRINT it into postscript
":hardcopy>print-this-document.ps

" LIST all the current registers!
":reg
" To COPY the current line into register k, TYPE "kyy
" To USE register k TYPE "k before the command for the operation
" e.g. to PASTE text from the register k, TYPE "kp
" <c-r> " in Insert mode INSERTs the content of the unnamed register
" the stuff I yanked/deleted...
" SELECT visual block by v (and MOVING arrow), PRESS "ky
" PASTE it by "kp

" SEE special mappings for Insert mode
":help i_ctrl-g
"i_ctrl-e INSERT the character that is below the cursor


" The following should also IGNORE the leading whitespaces
" TRY uncommenting the following line to ignore leading whitespaces
"set diffexpr=MyDiff()
function MyDiff()
   let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "--ignore-all-space "
   endif
   silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new .
    \  " > " . v:fname_out
endfunction"
" IGNORE (trailing) whitespaces in the diff (not the leading ones, alas!)
"set diffopt+=iwhite
"set diffopt+=icase


" Vimdiff
"]c       next change
"[c       prev change
"do       diff obtain
"dp       diff put
":diffu   diff update
":%diffput   put all changes from the current buffer to the 'other' buffer

" UPDATE the view automatically in Vimdiff upon writing changes to file
autocmd BufWritePost * if &diff == 1 | diffupdate | endif


" TOGGLE Commenting based on filename and filetype!!
" SEE ~/.vim/plugin/ToggleCommentLine.vim
"no <buffer> <f1> :call ToggleCommentLine()<LF>
" COMMENT at the 1st character of the current line and DO NOT MOVE down
no <f1> :call ToggleCommentLine()<LF>0
ino <f1> <esc>:call ToggleCommentLine()<LF>li
" COMMENT the visual selection
vno <buffer> <f1> :call ToggleCommentLine()<LF>

"Great VIM scripting cheatsheet!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"https://devhints.io/vimscript
"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

"Useful when writing a commit message in Git
"More generic one (does not require 'Changes not staged for commit')
"Uses range between 'Changes' and first empty line with comment character '#' after
"no <f5> gg:/Changes/;/#$/-1s/^#//g<cr>?On branch<cr>0xyyp0DyyPo
"no <f5> gg:/Changes/;/Changes not/-1s/^#\(\s*mod\)\(.*\)/\1\2/g<cr>?On branch<cr>0xyyp0DyyPo
"no <f5> gg:/Changes not/+1;/Untrack/-1s/\smodified:/-modified:/g<cr>gg:/Changes/;/Untrack/-1s/^#\(\s*mod\)\(.*\)/\1\2/g<cr>?On branch<cr>0xyyp0DyyPo
"no <f5> gg:/Changes/;/Untrack/-1s/^#\(\s*mod\)\(.*\)/\1\2/g<cr>gg:s/Changes not.*
"no <f5> gg:/Changes/;/\<(Changes\|Untracked\)\>/-1s/^#\(\s*mod\)\(.*\)/\1\2/g<cr>?On branch<cr>0xyyp0DyyPo
":echo search('Changes not','ncpe')

"CHECK if 'Changes not staged' present in git-commit pre-populated message.
"If yes then REMOVE ':' so it can be used as an identifying pattern for changes to be uncommented:
" modified: new file: deleted: renamed:
"UNCOMMENT lines with ':' (originally with ':\s')
fu! GitCommit()
  let u = search('Untracked ','ncpe')
  if search('Changes not','ncpe') == 1
    if u == 1
      exe "norm gg:/Changes not/;/Untracked /-1s/\:/ /g\<cr>"
    el
      exe "norm gg:/Changes not/,$s/\:/ /g\<cr>"
    en
  en
  if u == 1
    exe "norm gg:/Changes to/;/Untracked /-1s/^#\\(.*\\):/\\1:/g\<cr>"
  el
    exe "norm gg:/Changes to/,$s/^#\\(.*\\):/\\1:/g\<cr>"
  en
  "exe "norm ?On branch\<cr>0xyyp0DyyPp"
  "exe "norm ?On branch\<cr>0xjjddjxjjx6kxyyPo"
  exe "norm ?On branch\<cr>0xjjxdd3k2pkyyjpI "
endf
no <f5> :call GitCommit()<cr>A

"For testing
if 0
  fu! GitCommit()
    if search('Changes not','ncpe') == 1
      "Set mark t
      "exe "norm gg/Changes not\<cr>mt"
      "search('(use','ncpe',line("'t"))
      exe "norm gg:/Changes not/;/Untrack/-1s/\:/ /g\<cr>"
      "exe "norm gg:/Changes not/+1;/Untrack/-1s/\\smodified:/-modified:/g\<cr>"
      "exe "norm gg:/Changes/;/Changes not/-1s/^#\\(\\\)\\(.*\\)/\\1\\2/g\<cr>?On branch\<cr>0xyyp0DyyPp"
    en
    "exe "norm gg:/Changes/;/Untrack/-1s/^#\\(\\s*mod\\)\\(.*\\)/\\1\\2/g\<cr>?On branch\<cr>0xyyp0DyyPp"
    "Do not INCLUDE 'Changes to be committed:'
    "exe "norm gg:/Changes/;/Untrack/-1s/^#\\(.*\\):\\(\\s\\)/\\1:\\2/g\<cr>?On branch\<cr>0xyyp0DyyPp"
    "INCLUDE 'Changes to be committed:'
    exe "norm gg:/Changes/;/Untrack/-1s/^#\\(.*\\):/\\1:/g\<cr>?On branch\<cr>0xyyp0DyyPp"
  endf
endif

" For some reason <s-f1> or <a-f1> wouldn't map on metosrv8
" Shift with functions keys does not work in Screen sessions!
" COMMENT at the beginning of the line and MOVE down
"no <buffer> <a-s-f1> :call ToggleCommentLineAndMoveDown()<LF>


" EXECUTE shell cmd by :!{cmd}
" <f8> LaTeX and gview the output (postscript) of currently opened TeX file
"au BufNewFile,BufRead *.tex no <f8> :!texps %:p<cr>
au BufNewFile,BufRead *.ncl no <f8> :w<cr>:!ncl %:p<cr>
"au BufNewFile,BufRead *.py no <f8> :w<cr>:!python %:p<cr>
au BufNewFile,BufRead *.cfg no <f8> :w<cr>:!npp -i %:p<cr>
au BufNewFile,BufRead *.sh no <f8> :w<cr>:!sh %:p<cr>
"au BufNewFile,BufRead NPP_userIn.cfg no <f8> :w<cr>:!python ~/npp/NPP_main.py<cr>
" SEE ~/.vim/syntax/idlang.vim for details
"<f8> mapped to RUN the idl on the opened file  (IDL> subroutine)
"<s-f8> mapped to RUN the idl on the opened file  (IDL> .r subroutine)


"au BufEnter *.sh if getline(1) == "" | call setline(1, '#!/bin/csh -f') | endif
au BufWritePost * if getline(1) =~ "^#!/" | silent exe "!chmod u+x <afile> >& /dev/null" | endif

" A better option is to MOVE the syntax file into ~/.vim/syntax
"au BufReadPost * if &filetype =~ "[^w]*csh$" | silent! exe "so ~/.vim/csh.vim" | endif

"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ %P
set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%a-%d-%b-%Y\ %k:%M\",getftime(expand(\"%:p\")))}%=\ %l\,%L\ Col:%c%V\ %P
set laststatus=2

"endif   "if not on halo.atmos.umd.edu

" SET colorscheme - dark background is more reflective
" SEE examples for dark/light backgrounds at http://code.google.com/p/vimcolorschemetest/
" DOWNLOAD and put into .vim/colors/
"colorscheme wombat
"colo desert
"colo colorzone


" FOLD on the current /search/ pattern. SEE only the lines containing
" what I'm searching for, zM (FOLDs everything), c-y (SCROLL to beginning)
nn \z :se fde=getline(v:lnum)!~@/ fdm=expr<cr> zM 999<c-y>
" nn \z :se fde=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 fdm=expr<cr> zM

" FOLD commented lines by typing :fo<tab> (auto-COMPLETEs to Fold1stChar)
" # - shell        !,c - fortran         ; - idl
":Fold1stChar ;
" zR/zM  UNFOLD/FOLD all

if v:version >= 703
  function! Fold1stChar(...)
    let mark = "set fde=getline(v:lnum)[0]==\\\"" . a:1 . "\\\""
    exe mark
    set foldmethod=expr
  endfunction
  command! -nargs=1 Fold1stChar :call Fold1stChar(<q-args>)
endif
