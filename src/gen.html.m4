divert(-1)

changequote([,])
changecom([##])

define([DEREF], [ifdef([$1], [$1], [errprint([Not defined: $1])m4exit(69)])])

DEREF([DATETIME])
DEREF([LANG])
DEREF([SRC])

define([TITLE], [define([_TITLE], [$1])])

define([_HEAD_EXTRA], [])
define([HEAD_EXTRA], [define([_HEAD_EXTRA], [$1])])

define([HEADER], [define([_HEADER], [$1])])

define([NAV], [define([_NAV], [$1])])

define([ARTICLE], [define([_ARTICLE], [$1])])

ifelse(
  LANG, FI, [define([TRANS], [$1])],
  LANG, RU, [define([TRANS], [$2])],
  [errprint(Unknown language: "LANG")m4exit(1)]
)

define([ACCENT], [<span class="accent">$1</span>])
define([SELF_LINK], [<$1 id="$2">$3 <a href="#$2" class="self-link">&</a></$1>])
define([LNK], [<a href="$1">$2</a>])

define([H1], [<h1>$1<h1>])
define([H2], [<h2>$1<h2>])
define([H3], [<h3>$1<h3>])
define([H4], [<h4>$1<h4>])
define([H5], [<h5>$1<h5>])
define([H6], [<h6>$1<h6>])

define([TRANSLATE_GADGET], [TRANS(
  [LNK([/]SELF[.ru.html], По-русски)],
  [LNK([/]SELF[.html], Suomeksi)]
)])

include(SRC)

divert(0)dnl
<!-- AUTO-GENERATED AT DATETIME, DO NOT EDIT -->
<!DOCTYPE html>
<html lang="TRANS(fi, ru)">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="icon" href="favicon.ico" />
<title>DEREF([_TITLE])</title>
_HEAD_EXTRA</head>

<body>
<header>
<hgroup>DEREF([_HEADER])</hgroup>
<nav>DEREF([_NAV])</nav>
</header>
<div class="hr-like">&#9829;</div>
<main>DEREF([_ARTICLE])</main>
</body>
</html>
