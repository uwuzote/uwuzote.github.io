divert(-1)

changequote([,])
changecom([##])

ifdef([DATETIME], [], [errprint([Not defined: DATETIME])m4exit(1)])
ifdef([LANG], [], [errprint([Not defined: LANG])m4exit(1)])

ifelse(
  LANG, FI, [define([TRANS], [$1])],
  LANG, RU, [define([TRANS], [$2])],
  [errprint(Unknown language: "LANG")m4exit(1)]
)

define([ACCENT], [<span class="accent">$1</span>])
define([SELF_LINK], [<$1 id="$2">$3 <a href="#$2" class="self-link">&</a></$1>])
define([LNK], [<a href="$1">$2</a>])

define([HEAD], [dnl
<!DOCTYPE html>
<html lang="TRANS(fi, ru)">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="icon" href="favicon.ico" />
$1</head>dnl
])

define([TRANSLATE_GADGET], [TRANS(
  [LNK([/]SELF[.ru.html], По-русски)],
  [LNK([/]SELF[.html], Suomeksi)]
)])

define([BODY], [dnl
<body>
<header>
<hgroup>$1</hgroup>
<nav>$2</nav>
</header>
<div class="hr-like">&#9829;</div>
<main>$3</main>
</body>
</html>
])

divert(0)dnl
<!-- AUTO-GENERATED AT DATETIME, DO NOT EDIT -->
