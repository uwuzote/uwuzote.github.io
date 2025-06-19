include(m4/common.m4)

ifdef([FORCE_REBUILD], [], [define([FORCE_REBUILD], [0])])
ifdef([DONT_MINIFY], [], [define([DONT_MINIFY], [0])])

define([DATETIME], ECMD([date '+%Y-%m-%d %H:%M:%S' --utc | tr -d '\n']))
define([TIMESTAMP], [ECMD([test -f $1 && stat --printf %Y $1 || echo 0])])

define([TIMESTAMP_GT], [eval(TIMESTAMP([$1])[>]TIMESTAMP([$2]))])

define([_WORK_DONE], [0])
define([EDGE], [ifelse(FORCE_REBUILD, 1, [define([_WORK_DONE], [1])CMD_LOG([$3])], TIMESTAMP_GT([$1], [$2]), 1, [define([_WORK_DONE], [1])CMD_LOG([$3])])])

define([BUILD_PAGE], [
  EDGE([$1], [$3], [m4 -EE '-DDATETIME=]DATETIME[' -DSRC=]$1[ ]$2[ m4/gen.html.m4 > ]$3)
])

define([BUILD_PAGE_FULL], [
  BUILD_PAGE([pages/$1.html], [-DLANG=FI -DSELF=$1], [docs/$1.html])
  BUILD_PAGE([pages/$1.html], [-DLANG=RU -DSELF=$1], [docs/$1.ru.html])
])

CMD([mkdir -p docs])
CMD([cp -r static/* docs])

BUILD_PAGE([pages/404.html], [-DLANG=FI], [docs/404.html])

BUILD_PAGE_FULL(index)
BUILD_PAGE_FULL(verbs)
BUILD_PAGE_FULL(object)
BUILD_PAGE_FULL(numbers)
BUILD_PAGE([pages/nouns.html], [-DLANG=RU -DSELF=nouns], [docs/nouns.ru.html])

ifelse(DONT_MINIFY, 1, [], [
  CMD_LOG([minify --html-keep-comments -r docs/ -o docs/])
])
