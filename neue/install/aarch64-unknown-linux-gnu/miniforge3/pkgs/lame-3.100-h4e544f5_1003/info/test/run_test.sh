

set -ex



lame --genre-list testcase.mp3
lame --longhelp
test -f $PREFIX/include/lame/lame.h
exit 0
