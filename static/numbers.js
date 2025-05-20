'use strict';

const SEP = "¦\u200B";

const CARDINALS10 = [
    "nolla",
    "yksi",
    "kaksi",
    "kolme",
    "neljä",
    "viisi",
    "kuusi",
    "seitsemän",
    "kahdeksan",
    "yhdeksän",
    "kymmenen"
];

const BIG_CARDINALS_NOM = [
    "yksi",
    "tuhat",
    "miljoona",
    "miljardi",
    "biljoona",
    "biljardi",
    "triljoona",
    "triljardi",
    "kvadriljoona",
    "kvintiljoona",
    "sekstiljoona",
    "septiljoona",
    "oktiljoona",
]

const BIG_CARDINALS_PART = [
    "",
    SEP + "tuhatta",
    SEP + "miljoonaa",
    SEP + "miljardia",
    SEP + "biljoonaa",
    SEP + "biljardia",
    SEP + "triljoonaa",
    SEP + "triljardia",
    SEP + "kvadriljoonaa",
    SEP + "kvintiljoonaa",
    SEP + "sekstiljoonaa",
    SEP + "septiljoonaa",
    SEP + "oktiljoonaa",
]

const div = (a, b) => (a - a%b) / b;

const cardinal = (n) => {
    if (n < 0) return "error";

    else if (0 <= n && n <= 10)
        return CARDINALS10[n];

    else if (11 <= n && n <= 19)
        return CARDINALS10[n - 10] + SEP + "toista";

    else if (20 <= n && n <= 99)
        return CARDINALS10[div(n, 10)] + SEP + "kymmentä" + (n%10? SEP + CARDINALS10[n%10] : "");

    else if (100 <= n && n <= 999)
        return (n>199? CARDINALS10[div(n, 100)] + SEP + "sataa" : "sata") + (n%100? SEP + cardinal(n%100) : "");

    else {
        let chunks = [];

        while (n >= 1000) {
            chunks.push(n % 1000);
            n = div(n, 1000);
        }

        console.log()

        chunks.push(n);

        let output = [];

        for (let i = 0; i < chunks.length; i += 1) {
            if (i > 12) return "error: too big";

            if (chunks[i] == 0) continue;
            else if (chunks[i] == 1) {
                output.push(BIG_CARDINALS_NOM[i])
            } else {
                output.push(cardinal(chunks[i]) + BIG_CARDINALS_PART[i])
            }
        }

        output.reverse();

        return output.reduce((a, b) => a + SEP + b);
    }
}

const number_elem = document.getElementById("number");
const result_elem = document.getElementById("result");

const entry = (_) => {
    const value = parseInt(number_elem.value);

    if (Number.isInteger(value))
        result_elem.innerHTML = cardinal(value);
    else
        result_elem.innerHTML = "error";
}

number_elem.onchange = entry;

entry();
