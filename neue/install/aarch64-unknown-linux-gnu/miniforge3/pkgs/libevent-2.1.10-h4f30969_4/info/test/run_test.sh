

set -ex



test -d "${PREFIX}/include/event2"
test ! -f "${PREFIX}/lib/libevent.a"
test -f "${PREFIX}/lib/libevent.so"
test ! -f "${PREFIX}/lib/libevent_core.a"
test -f "${PREFIX}/lib/libevent_core.so"
test ! -f "${PREFIX}/lib/libevent_extra.a"
test -f "${PREFIX}/lib/libevent_extra.so"
test ! -f "${PREFIX}/lib/libevent_openssl.a"
test -f "${PREFIX}/lib/libevent_openssl.so"
test ! -f "${PREFIX}/lib/libevent_pthreads.a"
test -f "${PREFIX}/lib/libevent_pthreads.so"
test -f "${PREFIX}/lib/pkgconfig/libevent.pc"
test -f "${PREFIX}/lib/pkgconfig/libevent_openssl.pc"
test -f "${PREFIX}/lib/pkgconfig/libevent_pthreads.pc"
python event_rpcgen.py test/regress.rpc test/regress.gen.h test/regress.gen.c
exit 0
