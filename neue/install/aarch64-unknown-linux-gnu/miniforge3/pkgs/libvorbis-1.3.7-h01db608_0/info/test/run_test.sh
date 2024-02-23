

set -ex



test -f $PREFIX/lib/pkgconfig/vorbis.pc
test -f $PREFIX/lib/pkgconfig/vorbisenc.pc
test -f $PREFIX/lib/pkgconfig/vorbisfile.pc
test -f $PREFIX/include/vorbis/codec.h
test -f $PREFIX/include/vorbis/vorbisenc.h
test -f $PREFIX/include/vorbis/vorbisfile.h
test -f $PREFIX/lib/libvorbis${SHLIB_EXT}
test -f $PREFIX/lib/libvorbisenc${SHLIB_EXT}
test -f $PREFIX/lib/libvorbisfile${SHLIB_EXT}
exit 0
