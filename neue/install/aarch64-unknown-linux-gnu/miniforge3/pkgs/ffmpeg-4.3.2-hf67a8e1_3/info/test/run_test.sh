

set -ex



ffmpeg --help
ffmpeg -loglevel panic -protocols | grep "https"
ffmpeg -loglevel panic -codecs | grep "libmp3lame"
ffmpeg -loglevel panic -codecs | grep "DEVI.S zlib"
ffmpeg -loglevel panic -codecs | grep "DEV.LS h264"
ffmpeg -loglevel panic -codecs | grep "libx264"
ffmpeg -loglevel panic -codecs | grep "libopenh264"
test -f $PREFIX/lib/libavcodec${SHLIB_EXT}
test ! -f $PREFIX/lib/libavcodec.a
test -f $PREFIX/lib/libavdevice${SHLIB_EXT}
test ! -f $PREFIX/lib/libavdevice.a
test -f $PREFIX/lib/libswresample${SHLIB_EXT}
test ! -f $PREFIX/lib/libswresample.a
test -f $PREFIX/lib/libpostproc${SHLIB_EXT}
test ! -f $PREFIX/lib/libpostproc.a
test -f $PREFIX/lib/libavfilter${SHLIB_EXT}
test ! -f $PREFIX/lib/libavfilter.a
test -f $PREFIX/lib/libswresample${SHLIB_EXT}
test ! -f $PREFIX/lib/libswresample.a
test -f $PREFIX/lib/libavcodec${SHLIB_EXT}
test ! -f $PREFIX/lib/libavcodec.a
test -f $PREFIX/lib/libavformat${SHLIB_EXT}
test ! -f $PREFIX/lib/libavformat.a
test -f $PREFIX/lib/libswscale${SHLIB_EXT}
test ! -f $PREFIX/lib/libswscale.a
test -f $PREFIX/lib/libavresample${SHLIB_EXT}
test ! -f $PREFIX/lib/libavresample.a
exit 0
