#! /bin/sh
## vim:set ts=4 sw=4 et:
set -e
echo "// Using GNU C compiler."
echo "//"

test "X${top_srcdir}" = X && top_srcdir=`echo "$0" | sed 's,[^/]*$,,'`../..
UNAME_MACHINE=unknown

CC="gcc -fPIC"
CC="gcc -static"
CC="gcc"
CFLAGS="-Wall -O2 -fomit-frame-pointer"

. $top_srcdir/B/generic/build.sh
