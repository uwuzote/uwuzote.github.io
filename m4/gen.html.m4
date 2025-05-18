include(m4/common.m4)
changecom([##])

DEREF([DATETIME])
DEREF([LANG])
DEREF([SRC])

DEFINE_PROTECTED([TITLE], [define([_TITLE], [CONCAT($@)])])

define([_HEAD_EXTRA], [])
DEFINE_PROTECTED([HEAD_EXTRA], [define([_HEAD_EXTRA], [CONCAT($@)])])

define([_BODY], [0])
DEFINE_PROTECTED([BODY], [define([_BODY], [CONCAT($@)])])

DEFINE_PROTECTED([HEADER], [define([_HEADER], [CONCAT($@)])])
DEFINE_PROTECTED([NAV], [define([_NAV], [CONCAT($@)])])
DEFINE_PROTECTED([ARTICLE], [define([_ARTICLE], [CONCAT($@)])])

ifelse(
  LANG, FI, [define([TRANS], [$1])],
  LANG, RU, [define([TRANS], [$2])],
  [errprint(Unknown language: "LANG")m4exit(1)]
)

DEFINE_PROTECTED([ACCENT], [<span class="accent">$1</span>])
DEFINE_PROTECTED([SELF_LINK], [<$1 id="$2">$3 <a href="#$2" class="self-link">&</a></$1>])
DEFINE_PROTECTED([LNK], [<a href="$1">$2</a>])

define([_LIST_HELPER], [ifelse($#, 0, [], $#, 1, [<li>$1</li>], [$1], [CUSTOM], [<li $2>$3</li>_LIST_HELPER(shift(shift(shift($@))))], [<li>$1</li>_LIST_HELPER(shift($@))])])
DEFINE_PROTECTED([LIST], [<$1>_LIST_HELPER(shift($@))</$1>])dnl

DEFINE_PROTECTED([H1], [<h1>CONCAT($@)</h1>])
DEFINE_PROTECTED([H2], [<h2>CONCAT($@)</h2>])
DEFINE_PROTECTED([H3], [<h3>CONCAT($@)</h3>])
DEFINE_PROTECTED([H4], [<h4>CONCAT($@)</h4>])
DEFINE_PROTECTED([H5], [<h5>CONCAT($@)</h5>])
DEFINE_PROTECTED([H6], [<h6>CONCAT($@)</h6>])

DEFINE_PROTECTED([P], [<p>CONCAT($@)</p>])
DEFINE_PROTECTED([B], [<b>CONCAT($@)</b>])
DEFINE_PROTECTED([I], [<i>CONCAT($@)</i>])
DEFINE_PROTECTED([DETAILS], [<details><summary>$1</summary>$2</details>])

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
  <link rel="stylesheet" href="style.css" />
  <title>DEREF([_TITLE])</title>
_HEAD_EXTRA</head>

<body>
ifelse(_BODY, 0, [dnl
  <header>
    <hgroup>DEREF([_HEADER])</hgroup>
    ifdef([_NAV], [<nav>_NAV</nav>])
  </header>
  <div class="hr-like">&#9829;</div>
  <main>DEREF([_ARTICLE])</main>
  <div id="up-button"><a href="#">&uarr;</a></div>
], [dnl
  _BODY
])
</body>
</html>
