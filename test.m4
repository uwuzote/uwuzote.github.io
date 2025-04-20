divert(-1)
changequote([,])

define([PRINT], [pushdef([PREV_DIVNUM], divnum)divert(0)[]$1[]divert(PREV_DIVNUM)popdef([PREV_DIVNUM])])

PRINT([esyscmd([echo 'a, b, c'])])
