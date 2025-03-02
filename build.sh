#/bin/sh

set -xe

BUILD=docs

rm -rf $BUILD/*
mkdir -p $BUILD

cp -vr static $BUILD

m4 -DLANG=FI src/std.m4 src/index.html > $BUILD/index.html
m4 -DLANG=RU src/std.m4 src/index.html > $BUILD/index.ru.html
