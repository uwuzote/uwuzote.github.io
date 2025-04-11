divert(-1)

changequote([,])
changecom([##])

define([ABORT], [

Aborting build process...[]m4exit(1)])

define([CMD], [* [$1]syscmd([$1])[]ifelse(sysval, 0, [], [Return code: sysval[]ABORT])])
define([BUILD_PAGE], [CMD([m4 '-DDATETIME=]DATETIME[' -DLANG=]$2[ ]$3[ std.m4 ]$1[ > ]$4)])
define([BUILD_PAGE_FULL],
[Building `$1`...
  BUILD_PAGE([src/$1.html], [FI], [-DSELF=$1], [docs/$1.html])
  BUILD_PAGE([src/$1.html], [RU], [-DSELF=$1], [docs/$1.ru.html])])

define([DATETIME], esyscmd([date '+%Y-%m-%d %H:%M:%S' --utc | tr -d '\n']))

divert(0)dnl
CMD([rm -rf docs/*])
CMD([mkdir -p docs])
CMD([cp -r static/* docs])
BUILD_PAGE_FULL(index)
BUILD_PAGE_FULL(nouns)
