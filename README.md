# SanaSampo
## A compact, opinionated guide to Finnish

Hosted with GitHub Pages at <https://uwuzote.github.io/#>.
Issues and pull-requests are welcome :3

## Verb conjugation Checklist
- [x] Moods
  - [x] Indicative mood (present, past, perfect, pluperfect)
  - [x] Conditional mood (present, perfect)
  - [x] Imperative mood (present, perfect)
  - [x] Potential mood (present, perfect)
- [x] Infinitives
  - [x] First A-infinitive
  - [x] Long first infinitive
  - [x] Second e-infinitive
  - [x] Third mA-infinitive
  - [x] Fourth minen-infinitive
  - [x] Fifth mAinen-infinitive
- [x] Participles
  - [x] Active present vA-participle
  - [x] Active past nUt-participle
  - [x] Passive present tAvA-participle
  - [x] Passive perfect tU-participle
  - [x] Agent mA-participle
  - [x] Negative agent mAtOn-participle

## Building
To build use [GNU M4](https://www.gnu.org/software/m4/m4.html)
(I use M4 version `1.4.19`) from project root:
```sh
m4 m4/build.m4
```
The build system is _incremental_ and compares the timestamp of output file
with the timestamp of input file. If you wish to force a rebuild you can define
`FORCE_REBUILD` to `1`:
```sh
m4 -DFORCE_REBUILD=1 m4/build.m4
```
The build system also minifies output files by using [minify](https://github.com/tdewolff/minify/).
If you don't have `minify` or wish not to minify output files, you can define `DONT_MINIFY` to `1`
