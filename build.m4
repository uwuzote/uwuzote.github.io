divert(-1)
changequote([,])

# TODO: make build commands check timestamps to allow `incremental` building

define([PRINT], [pushdef([PREV_DIVNUM], divnum)divert(0)[]$1[]divert(PREV_DIVNUM)popdef([PREV_DIVNUM])])
define([ENDL], [
])
define([PRINTN], [PRINT([$1[]ENDL])])

define([ABORT], [errprint([
Aborting build process...
])m4exit(69)])


define([SEXEC], [dnl
syscmd([$1])dnl
ifelse(sysval, 0, [], [errprint([
Command failed with return code ]sysval[
Command was: `$1`])ABORT])])

define([EXEC], [PRINTN([[* $1]])SEXEC([$1])])

define([DATETIME], esyscmd([date '+%Y-%m-%d %H:%M:%S' --utc | tr -d '\n']))
define([TIMESTAMP], [esyscmd([stat --printf %Y $1])])

define([BUILD_PAGE], [EXEC([m4 -EE '-DDATETIME=]DATETIME[' -DLANG=]$2[ ]$3[ src/std.m4 ]$1[ > ]$4)])

define([BUILD_PAGE_FULL], [
  BUILD_PAGE([content/$1.html], [FI], [-DSELF=$1], [docs/$1.html])
  BUILD_PAGE([content/$1.html], [RU], [-DSELF=$1], [docs/$1.ru.html])
])

define([BUILD_PAGE_NEW], [EXEC([m4 -EE '-DDATETIME=]DATETIME[' -DLANG=]$2[ -DSRC=]$1[ ]$3[ src/gen.html.m4 > ]$4)])

define([BUILD_PAGE_FULL_NEW], [
  BUILD_PAGE_NEW([content/$1.html], [FI], [-DSELF=$1], [docs/$1.html])
  BUILD_PAGE_NEW([content/$1.html], [RU], [-DSELF=$1], [docs/$1.ru.html])
])

SEXEC([mkdir -p docs])
SEXEC([cp -r static/* docs])
BUILD_PAGE_FULL(index)
# BUILD_PAGE_FULL_NEW(nouns)
