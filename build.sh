#/bin/sh

set -xeu

BUILD=docs
DATETIME=$(date '+%Y-%m-%d %H:%M:%S' --utc | tr -d '\n')

rm -rf $BUILD/*
mkdir -p $BUILD

cp -r static $BUILD

m4 "-DDATETIME=$DATETIME" -DLANG=FI src/std.m4 src/index.html > $BUILD/index.html
m4 "-DDATETIME=$DATETIME" -DLANG=RU src/std.m4 src/index.html > $BUILD/index.ru.html
