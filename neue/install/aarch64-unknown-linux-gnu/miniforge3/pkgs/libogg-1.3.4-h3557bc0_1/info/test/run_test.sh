

set -ex



test ! -f $PREFIX/lib/libogg.a
test -f $PREFIX/lib/libogg${SHLIB_EXT}
test -f $PREFIX/include/ogg/ogg.h
test -f $PREFIX/include/ogg/config_types.h
test -f $PREFIX/include/ogg/os_types.h
exit 0
