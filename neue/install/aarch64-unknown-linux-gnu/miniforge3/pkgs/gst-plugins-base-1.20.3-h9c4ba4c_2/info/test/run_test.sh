

set -ex



test -f $PREFIX/lib/libgstallocators-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstapp-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstaudio-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstfft-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstpbutils-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstriff-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstrtp-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstrtsp-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstsdp-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgsttag-1.0${SHLIB_EXT}
test -f $PREFIX/lib/libgstvideo-1.0${SHLIB_EXT}
test -f $PREFIX/lib/girepository-1.0/GstVideo-1.0.typelib
gst-inspect-1.0 --plugin volume
exit 0
