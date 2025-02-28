changequote([,])dnl
changecom([##])dnl
ifelse(
  LANG, FI, [define([trans], [$1])],
  LANG, RU, [define([trans], [$2])],
  [errprint([Unknown language: "]LANG["])m4exit(1)]
)dnl
