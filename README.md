# SanaSampo
## A compact, opinionated guide to Finnish

Hosted with GitHub Pages at <https://uwuzote.github.io/#>.
Issues and pull-requests are welcome :3

## Verb conjugation checklist
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
To build use execute `./build.lua` from the project root. It uses
[LuaJIT](https://luajit.org/luajit.html) 2.1. The build system is
*incremental* and compares the timestamp of output file with the
timestamp of input file. If you wish to force a rebuild you can delete
`docs/` directory. The build system also minifies output files by using
[minify](https://github.com/tdewolff/minify/) 2.23.1. If you don't have
`minify` or wish not to minify output files, you can edit the build file.

<!-- TODO: build sitemap -->
