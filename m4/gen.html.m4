divert(-1)

changequote([,])
changecom([##])

define([DEREF], [ifdef([$1], [$1], [errprint([Not defined: $1])m4exit(69)])])
define([CONCAT], [ifelse($#, 0, [], $#, 1, [$1], [[$1, ]CONCAT(shift($@))])])dnl

DEREF([DATETIME])
DEREF([LANG])
DEREF([SRC])

define([TITLE], [define([_TITLE], [CONCAT($@)])])

define([_HEAD_EXTRA], [])
define([HEAD_EXTRA], [define([_HEAD_EXTRA], [CONCAT($@)])])

define([HEADER], [define([_HEADER], [CONCAT($@)])])

define([NAV], [define([_NAV], [CONCAT($@)])])

define([ARTICLE], [define([_ARTICLE], [CONCAT($@)])])

ifelse(
  LANG, FI, [define([TRANS], [$1])],
  LANG, RU, [define([TRANS], [$2])],
  [errprint(Unknown language: "LANG")m4exit(1)]
)

define([ACCENT], [<span class="accent">$1</span>])
define([SELF_LINK], [<$1 id="$2">$3 <a href="#$2" class="self-link">&</a></$1>])
define([LNK], [<a href="$1">$2</a>])
define([_LIST_HELPER], [ifelse($#, 0, [], $#, 1, [<li>$1</li>], [$1], [CUSTOM], [<li $2>$3</li>_LIST_HELPER(shift(shift(shift($@))))], [<li>$1</li>_LIST_HELPER(shift($@))])])
define([LIST], [<$1>_LIST_HELPER(shift($@))</$1>])dnl

define([H1], [<h1>CONCAT($@)</h1>])
define([H2], [<h2>CONCAT($@)</h2>])
define([H3], [<h3>CONCAT($@)</h3>])
define([H4], [<h4>CONCAT($@)</h4>])
define([H5], [<h5>CONCAT($@)</h5>])
define([H6], [<h6>CONCAT($@)</h6>])
define([P], [<p>CONCAT($@)<p>])

define([TRANSLATE_GADGET], [TRANS(
  [LNK([/]SELF[.ru.html], По-русски)],
  [LNK([/]SELF[.html], Suomeksi)]
)])

include(SRC)

divert(0)dnl
<!DOCTYPE html>
<html lang="TRANS(fi, ru)">
<!-- AUTO-GENERATED AT DATETIME, DO NOT EDIT -->
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="icon" href="favicon.ico" />
  <link rel="stylesheet" href="destyle.css" />
  <link rel="stylesheet" href="new-style.css" />
  <title>DEREF([_TITLE])</title>
_HEAD_EXTRA</head>

<body>
  <header>
    <hgroup>DEREF([_HEADER])</hgroup>
    <nav>DEREF([_NAV])</nav>
  </header>
  <div class="hr-like">&#9829;</div>
  <main>DEREF([_ARTICLE])</main>
  <div id="up-button"><a href="#">&uarr;</a></div>
</body>
</html>
