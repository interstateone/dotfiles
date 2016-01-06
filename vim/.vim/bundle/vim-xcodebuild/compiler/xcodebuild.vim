if exists("current_compiler")
    finish
endif
let current_compiler = "xcodebuild"

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=xcodebuild
CompilerSet errorformat=
    \%f:%l:%c:{%*[^}]}:\ %m,
    \%f:%l:%c:\ %m,
    \%f:%l:\ %m,

let &cpo = s:save_cpo
unlet s:save_cpo

