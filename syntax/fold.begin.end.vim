"just TYPE :source <name of this file> in normal mode

set fml=3
set foldnestmax=3
set foldmethod=marker
"foldmarker must be a string, regular expression would be too slow
set foldmarker=begin,end
"set foldmarker=\:\ begin,\ end


"The indent is sometimes nice to see
"set foldmethod=indent

"Or better indent - SEE following

"set foldmethod=expr
"set foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum))
