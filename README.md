# SanaSampo
## A compact, opinionated guide to Finnish

Hosted with GitHub Pages at <https://uwuzote.github.io/#>.
Issues and pull-requests are welcome :3

## Pages
 * Verb conjugation (formation of all forms)
 * Object rules
 * Number generator
 * Nominal declension (formation of all forms)
 * Orthograpy (beta)

## Building
To build use execute `./build.lua` from the project root. It uses
[LuaJIT](https://luajit.org/luajit.html) 2.1. The build system is
*incremental* and compares the timestamp of output file with the
timestamp of input file. If you wish to force a rebuild you can delete
`docs/` directory. The build system also minifies output files by using
[minify](https://github.com/tdewolff/minify/) 2.23.1. If you don't have
`minify` or wish not to minify output files, you can edit the build file.

<!-- TODO: build sitemap -->
