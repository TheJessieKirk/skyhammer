

set -ex



test -f ${PREFIX}/lib/libglib-2.0${SHLIB_EXT}
glib-compile-resources --help
gobject-query --help
gtester --help
exit 0
