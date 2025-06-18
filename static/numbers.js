const c = (s, e) => [s + "1", s + "2", e, e];
const _apl = (x, fn) => (typeof x == "string" ? fn(x) : x.map(fn));
const _pref = (x, p) => _apl(x, (s) => p + s);
const concat = (x, sep = "/") => (typeof x == "string" ? x : x.join(sep));
const div = (a, b) => (a - (a % b)) / b;
const SEPERATOR = "¦\u200B";

const CASES = {
  nom: ["n1", "w1", "", "t"],
  gen: ["w1", "g2", "n", "n"],
  par: c("p", ""),
  ine: c("w", "ssA"),
  ela: c("w", "stA"),
  ill: c("i", "n"),
  ade: c("w", "llA"),
  abl: c("w", "ltA"),
  all: c("w", "lle"),
  ess: c("s", "nA"),
  tra: c("w", "ksi"),
  abe: c("w", "ttA"),
  ins: c("w", "n"),
  com: c("s", "ne"),
};

const mkSimple = (a, n1, w1, s1, w2, s2, p1, p2, g2, i1, i2, prefix = "") => ({
  a,
  n1: _pref(n1, prefix),
  w1: _pref(w1, prefix),
  s1: _pref(s1, prefix),
  w2: _pref(w2, prefix),
  s2: _pref(s2, prefix),
  p1: _pref(p1, prefix),
  p2: _pref(p2, prefix),
  g2: _pref(g2, prefix),
  i1: _pref(i1, prefix),
  i2: _pref(i2, prefix),
  check: null,

  decline(cs, num) {
    const over = this.check?.(cs, num);
    if (over != null) return over;

    const suffix = cs[2 + num - 1].replace("A", this.a);

    return _apl(this[cs[num - 1]], (s) =>
      s.endsWith("*") ? s.slice(0, s.length - 1) + suffix + "*" : s + suffix,
    );
  },

  as_part() {
    return { ...this, n1: this.p1 };
  },

  no_part() {
    const self = this;
    return {
      ...self,
      as_part() {
        return self;
      },
    };
  },
});

const mkStr = (form) => ({
  form,

  decline(c, n) {
    return this.form;
  },

  as_part() {
    return this;
  },

  no_part() {
    return this;
  },
});

const EMPTY = mkStr("");

const mkComplex = (parts) => ({
  parts,
  sep: SEPERATOR,

  decline(cs, num) {
    let result = [];

    for (let part of this.parts) {
      if (typeof part == "string") {
        if (part != "") result.push(part);
      } else {
        if (part != EMPTY) result.push(concat(part.decline(cs, num)));
      }
    }

    return result.join(this.sep);
  },
});

const format_power = (i) => {
  const dgts = "⁰¹²³⁴⁵⁶⁷⁸⁹";
  let txt = i + "";

  for (let j = 0; j < 10; j += 1) {
    txt = txt.replace(j, dgts[j]);
  }

  return mkStr("10" + txt);
};

const mkGenerator = (NUMBERS) => {
  const single = (n, suffix = EMPTY, small = false) => {
    let numeral = (small ? NUMBERS[n + "-small"] : null) ?? NUMBERS[n];

    if (n == 0) return [];
    if (n == 1) return suffix == EMPTY ? [numeral] : [suffix];
    else return [numeral, suffix.as_part()];
  };

  const double = (n, suffix = EMPTY, small = false) => {
    if (n < 10) return single(n, suffix, small);
    if (n == 10) return [NUMBERS[10], suffix.as_part()];
    if (n < 20) return [NUMBERS[n - 10], NUMBERS["1x"], suffix.as_part()];
    else
      return [
        NUMBERS[div(n, 10)],
        NUMBERS[10].as_part(),
        ...single(n % 10, EMPTY, small),
        suffix.as_part(),
      ];
  };

  const triple = (n, suffix = EMPTY, small = false) => {
    if (n < 100) return double(n, suffix, small);
    if (n < 200)
      return [
        NUMBERS[100],
        ...double(n % 100, EMPTY, small && suffix == EMPTY),
        suffix.as_part(),
      ];
    else
      return [
        NUMBERS[div(n, 100)],
        NUMBERS[100].as_part(),
        ...double(n % 100, EMPTY, small && suffix == EMPTY),
        suffix.as_part(),
      ];
  };

  const multiple = (n, small = false) => {
    let is_zero = true;
    let parts = [];

    for (let i = 0; n.length > 0; i += 1) {
      const cur = +n.slice(Math.max(0, n.length - 3));
      n = n.slice(0, Math.max(0, n.length - 3));

      const suffix = NUMBERS.ROW[i] ?? format_power(i * 3);

      if (cur != 0) {
        is_zero = false;
        parts.push(triple(cur, suffix, small && i == 0));
      }
    }

    if (is_zero) return mkComplex([NUMBERS[0]]);
    else return mkComplex(parts.reverse().flat());
  };

  return multiple;
};

///////////////////

const KOTUS = {
  koira(root, a, gen_in_nom = false) {
    return mkSimple(
      a,
      gen_in_nom ? a + "n" : a,
      a,
      a,
      "i",
      "i",
      a + a,
      "i" + a,
      ["ie", a + "i*"],
      a + a,
      "ii",
      root,
    );
  },

  käsi(root, a) {
    return mkSimple(
      a,
      "si",
      "de",
      "te",
      "si",
      "si",
      "tt" + a,
      "si" + a,
      ["sie", "tte*"],
      "tee",
      "sii",
      root,
    );
  },

  kaksi(root, a) {
    return mkSimple(
      a,
      "ksi",
      "hde",
      "hte",
      "ksi",
      "ksi",
      "ht" + a,
      "ksi" + a,
      "ksie",
      "htee",
      "ksii",
      root,
    );
  },

  nainen(root, a) {
    return mkSimple(
      a,
      "nen",
      "se",
      "se",
      "si",
      "si",
      "st" + a,
      "si" + a,
      ["ste", "sie"],
      "see",
      "sii",
      root,
    );
  },

  kahdeksas(root, a) {
    return mkSimple(
      a,
      "s",
      "nne",
      "nte",
      "nsi",
      "nsi",
      "tt" + a,
      "nsi" + a,
      "nsie",
      "ntee",
      "nsii",
      root,
    );
  },
};

const CARDINALS = {
  0: KOTUS.koira("noll", "a"),
  1: KOTUS.kaksi("y", "ä"),
  2: KOTUS.kaksi("ka", "a"),
  3: mkSimple(
    "a",
    "e",
    "e",
    "e",
    "i",
    "i",
    "ea",
    "ia",
    "ie",
    "ee",
    "ii",
    "kolm",
  ),
  4: KOTUS.koira("nelj", "ä"),
  5: KOTUS.käsi("vii", "ä"),
  6: KOTUS.käsi("kuu", "a"),
  7: KOTUS.koira("seitsem", "ä", true),
  8: KOTUS.koira("kahdeks", "a", true),
  9: KOTUS.koira("yhdeks", "ä", true),
  10: mkSimple(
    "ä",
    "en",
    "e",
    "e",
    "i",
    "i",
    "tä",
    "iä",
    ["ie", "te"],
    "ee",
    "ii",
    "kymmen",
  ),
  "1x": mkStr("toista"),
  100: mkSimple(
    "a",
    "ta",
    "da",
    "ta",
    "doi",
    "toi",
    "taa",
    "toja",
    ["toje", "tai*"],
    "taa",
    "toihi",
    "sa",
  ),
  ROW: [
    EMPTY,
    mkSimple(
      "a",
      "t",
      "nne",
      "nte",
      "nsi",
      "nsi",
      "tta",
      "nsia",
      ["nsie", "nte*"],
      "ntee",
      "nsii",
      "tuha",
    ),
    KOTUS.koira("miljoon", "a"),
    mkSimple(
      "a",
      "i",
      "i",
      "i",
      "ei",
      "ei",
      "ia",
      "eja",
      "ie",
      "ii",
      "eihi",
      "miljard",
    ),
    KOTUS.koira("biljoon", "a"),
    mkSimple(
      "a",
      "i",
      "i",
      "i",
      "ei",
      "ei",
      "ia",
      ["eita", "eja"],
      ["ie", "eide", "eitte"],
      "ii",
      "eihi",
      "biljard",
    ),
  ],
};

CARDINALS[4].check = (cs, num) => {
  if (cs == CASES.ins && num == 2) return ["nelin", "neljin"];
  else return null;
};

const ORDINALS = {
  0: KOTUS.kahdeksas("nolla", "a"),
  1: KOTUS.kahdeksas("yhde", "ä"),
  "1-small": KOTUS.nainen("ensimmäi", "ä"),
  2: KOTUS.kahdeksas("kahde", "a"),
  "2-small": KOTUS.nainen("toi", "a"),
  3: KOTUS.kahdeksas("kolma", "a"),
  4: KOTUS.kahdeksas("neljä", "ä"),
  5: KOTUS.kahdeksas("viide", "ä"),
  6: KOTUS.kahdeksas("kuude", "a"),
  7: KOTUS.kahdeksas("seitsemä", "ä"),
  8: KOTUS.kahdeksas("kahdeksa", "a"),
  9: KOTUS.kahdeksas("yhdeksä", "ä"),
  10: KOTUS.kahdeksas("kymmene", "ä").no_part(),
  "1x": mkStr("toista"),
  100: KOTUS.kahdeksas("sada", "a").no_part(),
  ROW: [
    EMPTY,
    KOTUS.kahdeksas("tuhanne", "a"),
    KOTUS.kahdeksas("miljoona", "a"),
    KOTUS.kahdeksas("miljardi", "a"),
    KOTUS.kahdeksas("biljoona", "a"),
    KOTUS.kahdeksas("biljardi", "a"),
  ].map((x) => x.no_part()),
};

///////////////////

const filter_input = (value) => {
  let filtered = "";

  for (let i = 0; i < value.length; i += 1) {
    if ("0123456789".includes(value.at(i))) {
      filtered += value.at(i);
      continue;
    }

    return { ok: false, val: L10N.unknown_sym + ": '" + value.at(i) + "'" };
  }

  if (filtered.length == 0) return { ok: false, val: L10N.err_empty };
  else return { ok: true, val: filtered };
};

const g_car = mkGenerator(CARDINALS),
  g_ord = mkGenerator(ORDINALS);

const generators = {
  car(n, c, g) {
    return g_car(n).decline(c, g);
  },
  ord(n, c, g) {
    if (+n == 1 || +n == 2) return ORDINALS[+n + "-small"].decline(c, g);

    const small = g_ord(n, true).decline(c, g),
      big = g_ord(n, false).decline(c, g);

    if (small == big) return small;
    else return small + " " + L10N.or + " " + big;
  },
};

const number_e = document.getElementById("number");
const type_e = document.getElementById("type");
const case_e = document.getElementById("case");
const gnum_e = document.getElementById("gram-number");
const result_e = document.getElementById("result");

window.entry = () => {
  const value = filter_input(number_e.value);

  if (!value.ok) {
    result_e.innerHTML = "<b>" + L10N.error + "</b>: " + value.val;
    return;
  }

  if ((case_e.value == "com" || case_e.value == "ins") && gnum_e.value == "1") {
    result_e.innerHTML =
      "<b>" + L10N.error + "</b>: " + L10N["err_sg_" + case_e.value];
    return;
  }

  const generator = generators[type_e.value];

  result_e.innerHTML =
    "<b>" +
    L10N.result +
    "</b>: " +
    generator(value.val, CASES[case_e.value], +gnum_e.value);
};

for (let e of [number_e, type_e, case_e, gnum_e, result_e]) e.onchange = entry;

entry();
