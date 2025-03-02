divert(-1)

changequote([,])
changecom([##])

ifdef([DATETIME], [], [errprint([Not defined: DATETIME])m4exit(1)])
ifdef([LANG], [], [errprint([Not defined: LANG])m4exit(1)])

ifelse(
  LANG, FI, [define([TRANS], [$1])],
  LANG, RU, [define([TRANS], [$2])],
  [errprint([Unknown language: "]LANG["])m4exit(1)]
)

define([ACCENT], [<span class="accent">$1</span>])
define([SELF_LINK], [<$1 id="$2">$3 <a href="#$2" class="self-link">&</a></$1>])

divert(0)dnl
<!-- AUTO-GENERATED AT DATETIME, DO NOT EDIT -->
