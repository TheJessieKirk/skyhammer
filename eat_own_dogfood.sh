#!/bin/bash

ARCH=aarch64-unknown-linux-gnu;
BUG_URL="https://github.com/TheJessieKirk/skyhammer/issues";
PACKAGER="Skyhammer";
PACKAGE_VERSION="0.1.0";
PKG_VERSION="$PACKAGER-$PACKAGE_VERSION";
SYS_ROOT=/opt/skyhammer;
TARGET=$ARCH;

export PATH=$SYS_ROOT/$ARCH/bin;

#grep is removed as it needs eperf to build
#newlib, gettext and indent are removed due to breaking libc builds
#jansson is removed due to failing it's tests
STUFF_TO_BUILD=(tar jdk perl help2man python make automake autoconf m4 flex bison bash gperf pkg-config sed gmp isl mpfr mpc cryptlib libatomic_ops gc libffi zlib dejagnu dmalloc gawk grep libtool ncurses binutils coreutils diffutils findutils gawk gcc cmake ncompress gzip bzip2 lzip lzo lzop lzma xz lz4 zstd tar);
STUFF_TO_BUILD_FOR_WINDOWS=(gmp isl mpfr mpc mingw-w64 binutils gcc);

echo "Skyhammer";
echo "Eating my own dogfood...";
echo "You can enter 'stop' at any of Skyhammer's prompts to stop this script.";

echo "Checking directories...";
if [ ! -d "src" ]; then
    echo "src does not exist. Skyhammer will create it.";
    mkdir src;
fi;
if [ ! -d "tmp" ]; then
    echo "tmp does not exist. Skyhammer will create it.";
    mkdir tmp;
fi;
if [ ! -d "tmp/builds" ]; then
    echo "tmp/builds does not exist. Skyhammer will create it.";
    mkdir tmp/builds;
fi;

while true; do
    read -p "Do you want to build for a Microsoft Windows target? [y/n]: " answer;
    case $answer in
        y )
            echo "Target set to x86_64-mingw32-w64.";
            TARGET=x86_64-w64-mingw32;
            STUFF_TO_BUILD="";
            STUFF_TO_BUILD=${STUFF_TO_BUILD_FOR_WINDOWS[@]};
            export PATH=$SYS_ROOT/$ARCH/bin:$SYS_ROOT/$TARGET/bin:$OLD_PATH;
            break;
            ;;
        n)
            echo "No target set.";
            break;
            ;;
        stop )
            echo "Skyhammer is stopping...";
            exit;
            ;;
        * )
            echo "Please answer 'y' or 'n'.";
            ;;
    esac;
done;

for i in ${STUFF_TO_BUILD[@]}; do
while true; do
	cd $SYS_ROOT/src;
        read -p "Do you want to (re)extract $i source files? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is (re)extracting $i source files...";
                if [ -d "$i-*" ]; then
                    yes | rm -r "$i-*";
                fi;
                tar -xf ../etc/packages/$i-*;
                break;
                ;;
            n )
                break;
                ;;
            stop )
                echo "Skyhammer is stopping...";
                exit;
                ;;
            * )
                echo "Please answer 'y' or 'n'.";
                ;;
        esac;
    done;
    while true; do
        cd $SYS_ROOT/tmp/builds;
        configureOptions="";
        configureCFlags="";
        case $i in
            bzip2 | cryptlib | lz4 | zstd )
                read -p "Do you want to copy $i source files ready for building? [y/n]: " answer;
                ;;
            ncompress )
                read -p "Do you want to setup $i? [y/n]: " answer;
                ;;
            * )
                read -p "Do you want to configure $i? [y/n]: " answer;
                ;;
        esac;
        case $i in
            autoconf | automake | bison | coreutils | dejagnu | diffutils | dmalloc | findutils | gawk | grep | gperf | guile | indent | libffi | libtool | make | sed )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH";
                ;;
            bash )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --with-curses";
                configureCFlags="-Wno-implicit-function-declaration";
                ;;
            binutils )
                if [ $TARGET == x86_64-w64-mingw32 ]; then
                    configureOptions="--build=$ARCH --target=$TARGET --prefix=$SYS_ROOT/$TARGET --disable-isl-version-check --enable-checking --enable-install-libbfd --enable-install-libiberty --enable-plugins --enable-shared --enable-static --enable-gprofng --enable-ld --enable-host-shared --enable-libada --enable-libgm2 --enable-libssp --enable-lto --enable-objc-gc --enable-vtable-verify --enable-year2038 --with-bugurl=$BUG_URL --with-gmp=$SYS_ROOT/$TARGET --with-isl=$SYS_ROOT/$TARGET --with-jdk=$SYS_ROOT/$ARCH --with-mpc=$SYS_ROOT/$TARGET --with-mpfr=$SYS_ROOT/$TARGET --with-pkgversion=GNU-Binutils-$PKG_VERSION";
                else
                    #supports jansson with options
                    configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --disable-isl-version-check --enable-checking --enable-install-libbfd --enable-install-libiberty --enable-plugins --enable-shared --enable-static --enable-gprofng --enable-ld --enable-host-shared --enable-libada --enable-libgm2 --enable-libssp --enable-lto --enable-objc-gc --enable-vtable-verify --enable-year2038 --with-bugurl=$BUG_URL --with-gmp=$SYS_ROOT/$ARCH --with-isl=$SYS_ROOT/$ARCH --with-jdk=$SYS_ROOT/$ARCH --with-libiconv-prefix=$SYS_ROOT/$ARCH --with-libintl-prefix=$SYS_ROOT/$ARCH --with-mpc=$SYS_ROOT/$ARCH --with-mpfr=$SYS_ROOT/$ARCH --with-pkgversion=GNU-Binutils-$PKG_VERSION --with-system-zlib --with-target-bdw-gc=$SYS_ROOT/$ARCH";
                fi;
                ;;
            cmake )
                configureOptions="--prefix=$SYS_ROOT/$ARCH";
                ;;
            flex )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static";
                ;;
            gc )
                #supports Emscrypten with options
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --disable-gcj-support --enable-cplusplus --enable-dependency-tracking --enable-gc-assertions --enable-gcov --enable-static --enable-threads=pthreads --with-aix-soname=both --with-gnu-ld --with-libatomic-ops=yes --with-sysroot=$SYS_ROOT/$ARCH";
                ;;
            gcc )
                if [ $TARGET == x86_64-w64-mingw32 ]; then
                    configureOptions="--build=$ARCH --target=$TARGET --prefix=$SYS_ROOT/$TARGET --enable-languages=ada,c,c++,d,fortran,lto,m2,objc,obj-c++,rust --enable-shared --enable-static --with-sysroot=$SYS_ROOT/$TARGET";
                else
                    configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-languages=ada,c,c++,d,fortran,go,lto,m2,objc,obj-c++,rust --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH --with-isl=$SYS_ROOT/$ARCH --with-mpc=$SYS_ROOT/$ARCH --with-mpfr=$SYS_ROOT/$ARCH";
                fi;
                ;;
            gmp )
                if [ $TARGET == x86_64-w64-mingw32 ]; then
                    configureOptions="--build=$ARCH --host=$TARGET --prefix=$SYS_ROOT/$TARGET --enable-static --with-sysroot=$SYS_ROOT/$TARGET";
                else
                    configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static";
                fi;
                ;;
            gzip )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-dependency-tracking --oldincludedir=$SYS_ROOT/$ARCH";
                ;;
            help2man )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-nls";
                ;;
            isl )
                if [ $TARGET == x86_64-w64-mingw32 ]; then
                    configureOptions="--build=$ARCH --host=$TARGET --prefix=$SYS_ROOT/$TARGET --disable-shared --enable-static --with-gmp-prefix=$SYS_ROOT/$TARGET";
                else
                    configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static";
                fi;
                ;;
            jansson )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-dependency-tracking --with-aix-soname=both --with-gnu-ld --with-sysroot=$SYS_ROOT/$ARCH";
                ;;
            jdk )
                configureOptions="--build=$ARCH --enable-headless-only --enable-openjdk-only";
                ;;
            libatomic_ops )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-assertions --enable-dependency-tracking --enable-gcov --enable-shared --with-aix-soname=both --with-gnu-ld --with-sysroot=$SYS_ROOT/$ARCH";
                ;;
            lzip )
                configureOptions="--prefix=$SYS_ROOT/$ARCH";
                ;;
            lzma )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-dependency-tracking --with-gnu-ld";
                ;;
            lzo )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-dependency-tracking --enable-shared --with-gnu-ld --with-sysroot=$SYS_ROOT/$ARCH";
                ;;
            lzop )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-dependency-tracking";
                ;;
            m4 )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH";
                ;;
            mingw-w64 )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$TARGET --host=$TARGET";
                configureCFlags="-Wno-expansion-to-defined";
                ;;
            mpc )
                if [ $TARGET == x86_64-w64-mingw32 ]; then
                    configureOptions="--build=$ARCH --host=$TARGET --prefix=$SYS_ROOT/$TARGET --disable-shared --enable-static --with-gmp=$SYS_ROOT/$TARGET --with-mpfr=$SYS_ROOT/$TARGET";
                else
                    configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH --with-mpfr=$SYS_ROOT/$ARCH";
                fi;
                ;;
            mpfr )
                if [ $TARGET == x86_64-w64-mingw32 ]; then
                    configureOptions="--build=$ARCH --host=$TARGET --prefix=$SYS_ROOT/$TARGET --disable-shared --enable-static --with-gmp=$SYS_ROOT/$TARGET";
                else
                    configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH";
                fi;
                ;;
            ncurses )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --includedir=$SYS_ROOT/$ARCH/include --oldincludedir=$SYS_ROOT/$ARCH/include --with-cxx-shared --with-pkg-config --with-profile --with-shared";
                ;;
            newlib )
                #configureOptions="--build=$ARCH --host=$ARCH --target=$ARCH --prefix=$SYS_ROOT/$ARCH --srcdir=$SYS_ROOT/src/newlib-4.4.0 --disable-isl-version-check --enable-dependency-tracking --enable-gold=yes --enable-host-shared --enable-ld=yes --enable-libada --enable-libssp --enable-lto --enable-newlib-iconv --enable-newlib-multithread --enable-objc-gc --enable-static-libjava=yes --enable-vtable-verify --with-gmp=$SYS_ROOT/$ARCH --with-isl=$SYS_ROOT/$ARCH --with-mpc=$SYS_ROOT/$ARCH --with-mpfr=$SYS_ROOT/$ARCH --with-sysroot=$SYS_ROOT/$ARCH --with-system-zlib";
                configureOptions="--build=$ARCH --host=$ARCH --target=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-newlib-iconv --enable-newlib-multithread";
                ;;
            perl )
                configureOptions="-Dprefix=$SYS_ROOT/$ARCH -Dcc=gcc -Dmksymlinks";
                ;;
            pkg-config )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --with-internal-glib";
                ;;
            python )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-optimizations --enable-shared";
                ;;
            tar )
                #--with-rmt=FILE --without-selinux
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-backup-scripts --enable-dependency-tracking --oldincludedir=$SYS_ROOT/$ARCH --with-bzip2=$SYS_ROOT/$ARCH/bin/bzip2 --with-compress=$SYS_ROOT/$ARCH/bin/compress --with-gnu-ld --with-gzip=$SYS_ROOT/$ARCH/bin/gzip --with-libiconv-prefix=$SYS_ROOT/$ARCH --with-libintl-prefix=$SYS_ROOT/$ARCH --with-lzip=$SYS_ROOT/$ARCH/bin/lzip --with-lzma=$SYS_ROOT/$ARCH/bin/lzma --with-lzop=$SYS_ROOT/$ARCH/bin/lzop --with-packager=$PACKAGER --with-packager-bug-reports=$BUG_URL --with-packager-version=GNU-Tar-$PACKAGE_VERSION --with-xz=$SYS_ROOT/$ARCH/bin/xz --with-zstd=$SYS_ROOT/$ARCH/bin/zstd";
                ;;
            xz )
                #supports doxygen with --enable-doxygen
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --disable-lzma-links --enable-aix-soname=both --enable-dependency-tracking --enable-year2038 --with-gnu-ld --with-libiconv-prefix=$SYS_ROOT/$ARCH --with-libintl-prefix=$SYS_ROOT/$ARCH --with-sysroot=$SYS_ROOT/$ARCH";
                ;;
            zlib )
                configureOptions="--prefix=$SYS_ROOT/$ARCH";
                ;;
        esac;
        case $answer in
            y )
                echo "Skyhammer is configuring $i...";
                if [ ! -d "$i" ]; then
                    mkdir $i;
                fi;
                if [ $i == ncompress ] && [ -f $i/compress.def ] ; then
                    cp $i/compress.def ../compress.def.bak;
                fi;
                if [ ! -z "$(find $i -mindepth 1 -maxdepth 1)" ]; then
                    yes | rm -r $i/*;
                fi;
                if [ $i == ncompress ] ; then
                    cp ../compress.def.bak $i/compress.def;
                fi;
                cd $i;
                case $i in
                    bzip2 | cryptlib | lz4 | zstd )
                        cp -r ../../../src/$i*/* .;
                        ;;
                    newlib )
                        ../../../src/$i-*/newlib/configure $configureOptions CFLAGS="$configureCFlags";
                        ;;
                    ncompress )
                        cp -r ../../../src/$i*/* .;
                        ./build;
                        ;;
                    perl )
                        ../../../src/$i-*/Configure $configureOptions CFLAGS="$configureCFlags";
                        ;;
                    jdk | zlib )
                        ../../../src/$i-*/configure $configureOptions;
                        ;;
                    * )
                        ../../../src/$i-*/configure $configureOptions CFLAGS="$configureCFlags";
                        ;;
                esac;
                break;
                ;;
            n )
                break;
                ;;
            stop )
                echo "Skyhammer is stopping...";
                exit;
                ;;
            * )
                echo "Please answer 'y' or 'n'.";
                ;;
        esac;
    done;
    while true; do
	cd $SYS_ROOT/tmp/builds/$i;
        if [ $i == ncompress ]; then
            break;
        fi;
        makeCFlags="";
        read -p "Do you want to make $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is making $i...";
                case $i in
                    bash )
                        make CFLAGS="$makeCFlags";
                        ;;
                    cryptlib )
                        make;
                        make shared;
                        ;;
                    jdk )
                        make JOBS=4;
                        ;;
                    lz4 )
                        make -j4;
                        ;;
                    zstd )
                        make -j4 CFLAGS="-fPIC";
                        ;;
                    *)
                        make -j4 CFLAGS="$makeCFlags";
                        ;;
                esac;
                break;
                ;;
            n )
                break;
                ;;
            stop )
                echo "Skyhammer is stopping...";
                exit;
                ;;
            * )
                echo "Please answer 'y' or 'n'.";
                ;;
        esac;
    done;
    while true; do
	cd $SYS_ROOT/tmp/builds/$i;
        if [ $TARGET == x86_64-w64-mingw32 ]; then
            break;
        fi;
        if [ $i == bzip2 ] || [ $i == cmake ] || [ $i == jdk ] || [ $i == lzop ] || [ $i == ncompress ] || [ $i == ncurses ] || [ $i == python ]; then
            break;
        fi;
        read -p "Do you want to test $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is testing $i...";
                case $i in
                    cryptlib )
                        make testlib;
                        make stestlib;
                        ;;
                    lzo )
                        make check -j4;
                        make test -j4;
                        ;;
                    perl )
                        make test -j4;
                        ;;
                    * )
                        make check -j4;
                        ;;
                esac;
                break;
                ;;
            n )
                break;
                ;;
            stop )
                echo "Skyhammer is stopping...";
                exit;
                ;;
            * )
                echo "Please answer 'y' or 'n'.";
                ;;
        esac;
    done;
    while true; do
	cd $SYS_ROOT/tmp/builds/$i;
        if [ $i == ncompress ]; then
            break;
        fi;
        installCFlags="";
        read -p "Do you want to install $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is install $i...";
                case $i in
                    bash )
                        make install CFLAGS="$installCFlags";
                        ;;
                    bzip2 )
                        make install -j4 PREFIX=$SYS_ROOT/$ARCH;
                        ;;
                    cryptlib )
                        cp -f libcl.a $SYS_ROOT/$ARCH/lib;
                        ;;
                    jdk )
                        make images JOBS=4;
                        cp -f -r images/jdk/* $SYS_ROOT/$ARCH;
                        ;;
                    lz4 | zstd )
                        make install -j4 CFLAGS="-fPIC" PREFIX=$SYS_ROOT/$ARCH;
                        ;;
                    * )
                        make install -j4 CFLAGS="$installCFlags";
                        ;;
                esac;
                break;
                ;;
            n )
                break;
                ;;
            stop )
                echo "Skyhammer is stopping...";
                exit;
                ;;
            * )
                echo "Please answer 'y' or 'n'.";
                ;;
        esac;
    done;
    while true; do
        if [ $i == autoconf ] || [ $i == automake ] || [ $i == cryptlib ] || [ $i == dejagnu ] || [ $i == gc ] || [ $i == gmp ] || [ $i == isl ] || [ $i == libatomic_ops ] || [ $i == libffi ] || [ $i == libtool ] || [ $i == lzo ] || [ $i == mingw-w64 ] || [ $i == mpc ] || [ $i == mpfr ] || [ $i == zlib ]; then
            break;
        fi;
        if [ $TARGET == x86_64-w64-mingw32 ]; then
            cd $SYS_ROOT/$TARGET
        else
 	    cd $SYS_ROOT/$ARCH
        fi;
        read -p "Do you want to clean $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is cleaning $i...";
                stuffToCleanInArch="";
                stuffToCleanInBin="";
                stuffToCleanInLibExec="";
                case $i in
                    binutils )
                        if [ $TARGET == x86_64-w64-mingw32 ]; then
                            stuffToCleanInBin=($TARGET-addr2line $TARGET-ar $TARGET-as $TARGET-c++filt $TARGET-dlltool $TARGET-dllwrap $TARGET-elfedit $TARGET-gcov $TARGET-gcov-dump $TARGET-gcov-tool $TARGET-gprof $TARGET-ld $TARGET-ld.bfd $TARGET-lto-dump $TARGET-nm $TARGET-objcopy $TARGET-objdump $TARGET-ranlib $TARGET-readelf $TARGET-size $TARGET-strings $TARGET-windmc $TARGET-windres);
                            stuffToCleanInArch=(ar as dlltool ld ld.bfd nm objcopy objdump ranlib readelf);
                        else
                            stuffToCleanInBin=(addr2line ar as c++filt elfedit gcov gcov-dump gcov-tool gp-archive gp-collect-app gp-display-src gp-display-text gprof gprofng ld ld.bfd lto-dump nm objcopy objdump ranlib readelf size strings);
                            stuffToCleanInArch=(ar as ld ld.bfd objcopy objdump ranlib readelf);
                        fi;
                        ;;
                    bison )
                        stuffToCleanInBin=(bison);
                        ;;
                    bzip2 )
                        stuffToCleanInBin=(bunzip2 bzcat bzip2);
                        ;;
                    cmake )
                        stuffToCleanInBin=(cmake ctest);
                        ;;
                    coreutils )
                        stuffToCleanInBin=(b2sum base32 base64 basename basenc cat chcon chgrp chmod chown chroot cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand expr factor false fmt fold groups head hostid id install join kill link ln logname ls md5sum mkdir mkfifo mknod mktemp mv nice nl nohup nproc numfmt od paste pathchk pinky pr printenv printf ptx pwd readlink realpath rm rmdir runcon sha1sum sha224sum sha256sum sha384sum sha512sum shred shuf sleep sort split stat stdbuf stty sum sync tac tail tee test timeout touch tr true truncate tsort tty uname unexpand uniq unlink uptime users vdir wc who whoami yes);
                        ;;
                    diffutils )
                        stuffToCleanInBin=(cmp diff diff3 sdiff);
                        ;;
                    findutils )
                        stuffToCleanInBin=(find xargs);
                        ;;
                    flex )
                        stuffToCleanInBin=(flex);
                        ;;
                    gawk )
                        stuffToCleanInBin=(gawk gawk-5.3.1);
                        ;;
                    gcc )
                        if [ $TARGET == x86_64-w64-mingw32 ]; then
                            stuffToCleanInBin=($TARGET-c++ $TARGET-g++ $TARGET-gcc $TARGET-gcc-14.2.0 $TARGET-gcc-ar $TARGET-gcc-nm $TARGET-gcc-ranlib $TARGET-gdc $TARGET-gfortran $TARGET-gm2);
                            stuffToCleanInLibExec=(cc1 cc1gm2 cc1obj cc1objplus cc1plus collect2 crab1 d21 f951 g++-mapper-server gnat1 lto-wrapper lto1);
                        else
                            stuffToCleanInBin=($ARCH-c++ $ARCH-g++ $ARCH-gcc $ARCH-gcc-14.2.0 $ARCH-gcc-ar $ARCH-gcc-nm $ARCH-gcc-ranlib $ARCH-gccgo $ARCH-gdc $ARCH-gfortran $ARCH-gm2 c++ g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gccrs gdc gfortran gm2 gnat gnatbind gnatchop gnatclean gnatkr gnatlink gnatls gnatmake gnatprep go gofmt);
                            stuffToCleanInLibExec=(buildid cc1 cc1gm2 cc1obj cc1objplus cc1plus cgo collect2 crab1 d21 f951 g++-mapper-server gnat1 go1 lto-wrapper lto1 test2json vet);
                        fi;
                        ;;
                    gettext )
                        stuffToCleanInBin=(envsubst gettext gettextize msgattrib msgcmt msgcomm msgconv msgen msgexec msgdilter msgfmt msggrep msginit msgmerge msgunfmt msguniq ngettext recode-sr-latin xgettext);
                        ;;
                    gperf )
                        stuffToCleanInBin=(gperf);
                        ;;
                    grep )
                        stuffToCleanInBin=(grep);
                        ;;
                    gzip )
                        stuffToCleanInBin=(gzip);
                        ;;
                    jdk )
                        stuffToCleanInBin=(jar jarsigner java javac javadoc javap jcmd jconsole jdb jdeprscan jdeps jfr jhsdb jimage jinfo jlink jmap jmod jpackage jps jrunscript jshell jstack jstat jstatd jwebserver keytool rmiregistry serialver);
                        ;;
                    lz4 )
                        stuffToCleanInBin=(lz4);
                        ;;
                    lzip )
                        stuffToCleanInBin=(lzip);
                        ;;
                    lzma )
                        stuffToCleanInBin=(lzma lzmadec lzmainfo);
                        ;;
                    m4 )
                        stuffToCleanInBin=(m4);
                        ;;
                    make )
                        stuffToCleanInBin=(make);
                        ;;
                    ncompress )
                        stuffToCleanInBin=(compress compress.old uncompress  zcat);
                        ;;
                    ncurses )
                        stuffToCleanInBin=(infocmp tic toe tput tset);
                        ;;
                    perl )
                        stuffToCleanInBin=(perl perl5.40.0);
                        ;;
                    pkg-config )
                        stuffToCleanInBin=(pkg-config);
                        ;;
                    python )
                        stuffToCleanInBin=(python3.13);
                        ;;
                    sed )
                        stuffToCleanInBin=(sed);
                        ;;
                    tar )
                        stuffToCleanInBin=(tar);
                        ;;
                    xz )
                        stuffToCleanInBin=(xz xzdec);
                        ;;
                    zstd )
                        stuffToCleanInBin=(zstd);
                        ;;
                esac;
                for j in ${stuffToCleanInArch[@]}; do
                    if [ $TARGET = x86_64-w64-mingw32 ]; then
                        strip $TARGET/bin/$j;
                    else
                        strip $ARCH/bin/$j;
                    fi;
                done
                for j in ${stuffToCleanInBin[@]}; do
                    strip bin/$j;
                done
                for j in ${stuffToCleanInLibExec[@]}; do
                    if [ $TARGET = x86_64-w64-mingw32 ]; then
                        strip libexec/gcc/$TARGET/14.2.0/$j;
                    else
                        strip libexec/gcc/$ARCH/14.2.0/$j;
                    fi;
                done
                break;
                ;;
            n )
                break;
                ;;
            stop )
                echo "Skyhammer is stopping...";
                exit;
                ;;
            * )
                echo "Please answer 'y' or 'n'.";
                ;;
        esac;
    done;
done;
