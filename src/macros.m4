divert(-1)

changequote([,])
changecom([##])

ifelse(
  LANG, FI, [define([trans], [[$1]])],
  LANG, RU, [define([trans], [[$2]])],
  [errprint([Unknown language: "]LANG["])m4exit(1)]
)

divert(0)dnl
