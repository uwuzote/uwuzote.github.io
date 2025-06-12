"use strict";

const decline = (w, pl = false) => {
  if (typeof w === "string") return Array(14).fill(w);

  let wik = pl? w.wik2 : w.wik1;
  let str = pl? w.str2 : w.str1;

  return [
    pl? w.wik1 + "t" : (w.basic_par? w.par1 : w.nom1),
    pl? w.gen2 : wik + "n",
    pl? w.par2 : w.par1,
    wik + "ss" + w.a,
    wik + "st" + w.a,
    pl? w.ill2 : w.ill1,
    wik + "ll" + w.a,
    wik + "lt" + w.a,
    wik + "lle",
    str + "n" + w.a,
    wik + "ksi",
    wik + "tt" + w.a,
    pl? wik + "n" : undefined,
    pl? (w.ins2_over ?? (str + "ne")) : undefined,
  ];
}

const mkTypeKoira = (w, a, n = "", over_instr = null) => ({
  nom1: w + a + n,
  wik1: w + a,
  str1: w + a,
  wik2: w + "i",
  str2: w + "i",
  par1: w + a + a,
  par2: w + "i" + a,
  gen2: w + "ien",
  ill1: w + a + a + "n",
  ill2: w + "iin",
  ins2_over: over_instr,
  a: a,
});

const mkTypeKaksi = (w, a) => ({
  nom1: w + "ksi",
  wik1: w + "hde",
  str1: w + "hte",
  wik2: w + "ksi",
  str2: w + "ksi",
  par1: w + "ht" + a,
  par2: w + "ksi" + a,
  gen2: w + "ksien",
  ill1: w + "hteen",
  ill2: w + "ksiin",
  a: a,
});

const mkTypeOvi = (w, a, nom = null) => ({
  nom1: nom ?? (w + "i"),
  wik1: w + "e",
  str1: w + "e",
  wik2: w + "i",
  str2: w + "i",
  par1: w + "e" + a,
  par2: w + "i" + a,
  gen2: w + "ien",
  ill1: w + "een",
  ill2: w + "iin",
  a: a,
});

const mkTypeKäsi = (w, a) => ({
  nom1: w + "si",
  wik1: w + "de",
  str1: w + "te",
  wik2: w + "si",
  str2: w + "si",
  par1: w + "tt" + a,
  par2: w + "si" + a,
  gen2: w + "sien",
  ill1: w + "teen",
  ill2: w + "siin",
  a: a,
});

const mkTypeNainen = (w, a) => ({
  nom1: w + "nen",
  wik1: w + "se",
  str1: w + "se",
  wik2: w + "si",
  str2: w + "si",
  par1: w + "st" + a,
  par2: w + "si" + a,
  gen2: w + "sten",
  ill1: w + "seen",
  ill2: w + "siin",
  a: a,
});

const BASIC_CARDINALS = [
  mkTypeKoira("noll", "a"),
  mkTypeKaksi("y", "ä"),
  mkTypeKaksi("ka", "a"),
  mkTypeOvi("kolm", "a", "kolme"),
  mkTypeKoira("nelj", "ä", "", "nelin"),
  mkTypeKäsi("vii", "ä"),
  mkTypeKäsi("kuu", "a"),
  mkTypeKoira("seitsem", "ä", "n"),
  mkTypeKoira("kahdeks", "a", "n"),
  mkTypeKoira("yhdeks", "ä", "n"),
  {
    nom1: "kymmenen",
    wik1: "kymmene",
    str1: "kymmene",
    wik2: "kymmeni",
    str2: "kymmeni",
    par1: "kymmentä",
    par2: "kymmeniä",
    gen2: "kymmenien",
    ill1: "kymmeneen",
    ill2: "kymmeniin",
    a: "ä",
  }
];

const TOISTA = "toista";

