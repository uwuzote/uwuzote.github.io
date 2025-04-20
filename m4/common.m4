divert(-1)
changequote([,])

define([DEFINE_PROTECTED], [define([$1], [ifelse($][#, 0, [[$1]], [$2])])])

DEFINE_PROTECTED([PRINT], [pushdef([PREV_DIVNUM], divnum)divert(0)[]$1[]divert(PREV_DIVNUM)popdef([PREV_DIVNUM])])
DEFINE_PROTECTED([PRINTN], [PRINT([$1
])])

define([ABORT], [errprint([
M4: Aborting...
])m4exit(1)])

DEFINE_PROTECTED([CMD], [dnl
syscmd([$1])dnl
ifelse(sysval, 0, [], [errprint([

Command `$1` failed with return code ]sysval)
ABORT])])

DEFINE_PROTECTED([ECMD], [dnl
esyscmd([$1])dnl
ifelse(sysval, 0, [], [errprint([

Command `$1` failed with return code ]sysval)
ABORT])])

DEFINE_PROTECTED([CMD_LOG], [errprint([* $1
])CMD([$1])])

DEFINE_PROTECTED([DEREF], [ifdef([$1], [$1], [errprint([Not defined: $1])m4exit(69)])])

DEFINE_PROTECTED([CONCAT], [ifelse($#, 0, [], $#, 1, [$1], [[$1, ]CONCAT(shift($@))])])
