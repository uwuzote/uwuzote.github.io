divert(-1)
changequote([,])

define([PRINT], [pushdef([PREV_DIVNUM], divnum)divert(0)[]$1[]divert(PREV_DIVNUM)popdef([PREV_DIVNUM])])
define([ENDL], [
])
define([PRINTN], [PRINT([$1[]ENDL])])

define([ABORT], [errprint([
Aborting build process...
])m4exit(69)])

ifdef([FORCE_REBUILD], [], [define([FORCE_REBUILD], [0])])
ifdef([DONT_MINIFY], [], [define([DONT_MINIFY], [0])])

define([SEXEC], [dnl
syscmd([$1])dnl
ifelse(sysval, 0, [], [errprint([
Command failed with return code ]sysval[
Command was: `$1`])ABORT])])

define([ESEXEC], [dnl
esyscmd([$1])dnl
ifelse(sysval, 0, [], [errprint([
Command failed with return code ]sysval[
Command was: `$1`])ABORT])])

define([EXEC], [PRINTN([[* $1]])SEXEC([$1])])

define([DATETIME], esyscmd([date '+%Y-%m-%d %H:%M:%S' --utc | tr -d '\n']))
define([TIMESTAMP], [ESEXEC([test -f $1 && stat --printf %Y $1 || echo 0])])

define([TIMESTAMP_GT], [eval(TIMESTAMP([$1])[>]TIMESTAMP([$2]))])

define([EDGE], [ifelse(FORCE_REBUILD, 1, [EXEC([$3])], TIMESTAMP_GT([$1], [$2]), 1, [EXEC([$3])])])

define([BUILD_PAGE], [dnl
EDGE([$1], [$4], [m4 -EE '-DDATETIME=]DATETIME[' -DLANG=]$2[ -DSRC=]$1[ ]$3[ m4/gen.html.m4 > ]$4)dnl
])

define([BUILD_PAGE_FULL], [
  BUILD_PAGE([content/$1.html], [FI], [-DSELF=$1], [docs/$1.html])
  BUILD_PAGE([content/$1.html], [RU], [-DSELF=$1], [docs/$1.ru.html])
])

SEXEC([mkdir -p docs])
SEXEC([cp -r static/* docs])
BUILD_PAGE_FULL(index)
# BUILD_PAGE_FULL(nouns)
ifelse(DONT_MINIFY, 1, [], [EXEC([minify -r docs/ -o docs/])])
