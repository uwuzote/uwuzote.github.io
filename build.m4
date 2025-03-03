#!/usr/bin/env -S m4 -EE
divert(-1)

changequote([,])
changecom([##])

define([CMD], [* [$1]syscmd([$1])[]ifelse(sysval, 0, [], [Return code: sysval])])
define([BUILD], [CMD([m4 '-DDATETIME=]DATETIME[' -DLANG=]$2[ src/std.m4 ]$1[ > ]$3)])

define([DATETIME], esyscmd([date '+%Y-%m-%d %H:%M:%S' --utc | tr -d '\n']))

divert(0)dnl
CMD([rm -rf docs/*])
CMD([mkdir -p docs])
CMD([cp -r static/* docs])
BUILD(src/index.html, FI, docs/index.html)
BUILD(src/index.html, RU, docs/index.ru.html)
