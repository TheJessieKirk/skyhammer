

set -ex



gst-inspect-1.0 --version
gst-launch-1.0  --version
gst-stats-1.0 --version
gst-typefind-1.0 --version
test -f $PREFIX/lib/girepository-1.0/Gst-1.0.typelib
exit 0
