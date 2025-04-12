divert(-1)
changequote([,])

# TODO: make build commands check timestamps to allow `incremental` building

define([PRINT], [pushdef([PREV_DIVNUM], divnum)divert(0)[]$1[]divert(PREV_DIVNUM)popdef([PREV_DIVNUM])])
define([ENDL], [
])
define([PRINTN], [PRINT([$1[]ENDL])])

define([ABORT], [PRINT([
Aborting build process...
])m4exit(69)])

define([EXEC], [dnl
ifelse([$1], [1], [PRINTN([[* $2]])])dnl
syscmd([$2])dnl
ifelse(sysval, 0, [], [PRINTN([[
Command failed with return code ]sysval[
Command was: `$2`]ABORT])])])

define([BUILD_PAGE], [EXEC(1, [m4 -EE '-DDATETIME=]DATETIME[' -DLANG=]$2[ ]$3[ std.m4 ]$1[ > ]$4)])

define([BUILD_PAGE_FULL],
[Building `$1`...
  BUILD_PAGE([content/$1.html], [FI], [-DSELF=$1], [docs/$1.html])
  BUILD_PAGE([content/$1.html], [RU], [-DSELF=$1], [docs/$1.ru.html])])

define([DATETIME], esyscmd([date '+%Y-%m-%d %H:%M:%S' --utc | tr -d '\n']))

EXEC(0, [mkdir -p docs])
EXEC(0, [cp -r static/* docs])
BUILD_PAGE_FULL(index)
# BUILD_PAGE_FULL(nouns)
