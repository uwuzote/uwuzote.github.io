divert(-1)

changequote([,])
changecom([##])

ifelse(
  LANG, FI, [define([TRANS], [$1])],
  LANG, RU, [define([TRANS], [$2])],
  [errprint([Unknown language: "]LANG["])m4exit(1)]
)

define([ACCENT], [<span class="accent">$1</span>])

divert(0)dnl
