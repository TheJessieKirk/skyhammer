#!/bin/bash

ROOT_DIR=/usr/skyhammer/neue;
TARGETS=(aarch64-unknown-linux-gnu x86_64-w64-mingw32);
export PATH=$ROOT_DIR/install/aarch64-unknown-linux-gnu/bin:$ROOT_DIR/install/x86_64-w64-mingw32/bin;
export PKG_CONFIG_PATH=$ROOT_DIR/install/aarch64-unknown-linux-gnu/lib/pkgconfig;

chmod 755 -R $ROOT_DIR/*;

read -p "Do you want to backup neue? [type 'backup' to proceed]: " ;
if [ $REPLY = "backup" ];
then
    if [ -d ../neue.bak ];
    then
      rm -r ../neue.bak;
    fi;
    cp -r ../neue ../neue.bak;
fi;
echo "You can type 'stop' whenever you are asked a question to return to prompt.";

read -p "Do you want to check all directories are present? [y to proceed]: ";
case $REPLY in
  y)
    DIRS_TO_CHECK=(build install packages src);
    cd $ROOT_DIR;
    for i in ${DIRS_TO_CHECK[@]};
    do
      if [ ! -d $i ];
      then
      echo "$ROOT_DIR/$i does not exist. Making...";
        mkdir $ROOT_DIR/$i;
      else
        echo "$ROOT_DIR/$i exists.";
      fi;
    done;
    ;;
  stop)
    exit;
    ;;
  *)
    ;;
esac;

read -p "Do you want to check all sources are present? [y to proceed]: ";
case $REPLY in
  y)
    SRCS_TO_CHECK=(acl attr autoconf automake bash bdm-gc binutils bison bzip2 cmake coreutils cpython dejagnu diffutils dmalloc file findutils flex gawk gcc gdb gettext glibc gmp gperf grep guile gzip help2man isl jdk libatomic_ops libcap libffi libtool libunistring lzip lzo lzop m4 make mingw-w64 mpc mpfr ncompress nettle openssl patch pcre2 perl readline sed tar termcap texinfo unzip valgrind wget2 xz zip zstd);
    cd $ROOT_DIR/packages;
    for i in ${SRCS_TO_CHECK[@]};
    do
      case $i in
        acl)
          if [ ! -f acl-2.3.1.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/acl-2.3.1.tar.gz does not exist. Downloading...";
            wget -q https://git.savannah.nongnu.org/cgit/acl.git/snapshot/acl-2.3.1.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/acl-2.3.1.tar.gz exists.";
          fi;
          if [ ! -f ../src/acl-*/configure ];
          then
            echo "$ROOT_DIR/src/acl-*/configure does not exist. Extracting package...";
            tar -xf acl-*.tar.gz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/acl-*;
            ./autogen.sh;
            cd $ROOT_DIR/packages;
          else
            echo "$ROOT_DIR/src/acl-*/configure exists.";
          fi;
          ;;
        attr)
          if [ ! -f attr-2.5.2.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/attr-2.5.2.tar.xz does not exist. Downloading...";
            wget -q https://download.savannah.nongnu.org/releases/attr/attr-2.5.2.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/attr-2.5.2.tar.xz exists.";
          fi;
          if [ ! -f ../src/attr-*/configure ];
          then
            echo "$ROOT_DIR/src/attr-*/configure does not exist. Extracting package...";
            tar -xf attr-*.tar.xz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/attr-*;
            ./autogen.sh;
            cd $ROOT_DIR/packages;
          else
            echo "$ROOT_DIR/src/acl-*/configure exists.";
          fi;
          ;;
        autoconf)
          if [ ! -f autoconf-2.72.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/autoconf-2.72.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/autoconf-2.72.tar.xz exists.";
          fi;
          if [ ! -f ../src/autoconf-*/configure ];
          then
            echo "$ROOT_DIR/src/autoconf-*/configure does not exist. Extracting package...";
            tar -xf autoconf-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/binutils-*/configure exists.";
          fi;
          ;;
        automake)
          if [ ! -f automake-1.16.5.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/automake-1.16.5.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/automake-1.16.5.tar.xz exists.";
          fi;
          if [ ! -f ../src/automake-*/configure ];
          then
            echo "$ROOT_DIR/src/automake-*/configure does not exist. Extracting package...";
            tar -xf automake-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/automake-*/configure exists.";
          fi;
          ;;
        bash)
          if [ ! -f bash-5.2.21.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/bash-5.2.21.tar.gz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/bash/bash-5.2.21.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/bash-5.2.21.tar.gz exists.";
          fi;
          if [ ! -f ../src/bash-*/configure ];
          then
            echo "$ROOT_DIR/src/bash-*/configure does not exist. Extracting package...";
            tar -xf bash-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/bash-*/configure exists.";
          fi;
          ;;
        bdm-gc)
          if [ ! -f bdm-gc-8.2.4.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/bdm-gc-8.2.4.tar.gz does not exist. Downloading...";
            wget -q https://www.hboehm.info/gc/gc_source/gc-8.2.4.tar.gz;
            mv gc-8.2.4.tar.gz bdm-gc-8.2.4.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/bdm-gc-8.2.4.tar.gz exists.";
          fi;
          if [ ! -f ../src/bdm-gc-*/configure ];
          then
            echo "$ROOT_DIR/src/bdm-gc-*/configure does not exist. Extracting package...";
            tar -xf bdm-gc-*.tar.gz -C $ROOT_DIR/src;
            mv $ROOT_DIR/src/gc-8.2.4 $ROOT_DIR/src/bdm-gc-8.2.4;
          else
            echo "$ROOT_DIR/src/bdm-gc-*/configure exists.";
          fi;
          ;;
        binutils)
          if [ ! -f binutils-2.41.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/binutils-2.41.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/binutils-2.41.tar.xz exists.";
          fi;
          if [ ! -f ../src/binutils-*/configure ];
          then
            echo "$ROOT_DIR/src/binutils-*/configure does not exist. Extracting package...";
            tar -xf binutils-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/binutils-*/configure exists.";
          fi;
          ;;
        bison)
          if [ ! -f bison-3.8.2.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/bison-3.8.2.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/bison-3.8.2.tar.xz exists.";
          fi;
          if [ ! -f ../src/bison-*/configure ];
          then
            echo "$ROOT_DIR/src/bison-*/configure does not exist. Extracting package...";
            tar -xf bison-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/bison-*/configure exists.";
          fi;
          ;;
        bzip2)
          if [ ! -f bzip2-1.0.8.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/bzip2-1.0.8.tar.gz does not exist. Downloading...";
            wget -q https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/bzip2-1.0.8.tar.gz exists.";
          fi;
          if [ ! -f ../src/bzip2-*/Makefile ];
          then
            echo "$ROOT_DIR/src/bzip2-*/Makefile does not exist. Extracting package...";
            tar -xf bzip2-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/bzip2-*/Makefile exists.";
          fi;
          ;;
        cmake)
          if [ ! -f cmake-3.28.1.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/cmake-3.28.1.tar.gz does not exist. Downloading...";
            wget -q https://github.com/Kitware/CMake/releases/download/v3.28.1/cmake-3.28.1.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/cmake-3.28.1.tar.gz exists.";
          fi;
          if [ ! -f ../src/cmake-*/configure ];
          then
            echo "$ROOT_DIR/src/cmake-*/configure does not exist. Extracting package...";
            tar -xf cmake-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/cmake-*/configure exists.";
          fi;
          ;;
        coreutils)
          if [ ! -f coreutils-9.4.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/coreutils-9.4.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/coreutils/coreutils-9.4.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/coreutils-9.4.tar.xz exists.";
          fi;
          if [ ! -f ../src/coreutils-*/configure ];
          then
            echo "$ROOT_DIR/src/coreutils-*/configure does not exist. Extracting package...";
            tar -xf coreutils-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/coreutils-*/configure exists.";
          fi;
          ;;
        cpython)
          if [ ! -f cpython-3.12.1.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/cpython-3.12.1.tar.gz does not exist. Downloading...";
            wget -q https://github.com/python/cpython/archive/refs/tags/v3.12.1.tar.gz;
            mv v3.12.1.tar.gz cpython-3.12.1.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/cpython-3.12.1.tar.gz exists.";
          fi;
          if [ ! -f ../src/cpython-*/configure ];
          then
            echo "$ROOT_DIR/src/cpython-*/configure does not exist. Extracting package...";
            tar -xf cpython-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/cpython-*/configure exists.";
          fi;
          ;;
        dejagnu)
          if [ ! -f dejagnu-1.6.3.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/dejagnu-1.6.3.tar.gz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/dejagnu.tar.gz exists.";
          fi;
          if [ ! -f ../src/dejagnu-*/configure ];
          then
            echo "$ROOT_DIR/src/dejagnu-*/configure does not exist. Extracting package...";
            tar -xf dejagnu-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/dejagnu-*/configure exists.";
          fi;
          ;;
        diffutils)
          if [ ! -f diffutils-3.10.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/diffutils-3.10.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/diffutils/diffutils-3.10.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/diffutils-3.10.tar.xz exists.";
          fi;
          if [ ! -f ../src/diffutils-*/configure ];
          then
            echo "$ROOT_DIR/src/diffutils-*/configure does not exist. Extracting package...";
            tar -xf diffutils-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/diffutils-*/configure exists.";
          fi;
          ;;
        dmalloc)
          if [ ! -f dmalloc-5.6.5.tgz ];
          then
            echo "$ROOT_DIR/var/packages/dmalloc-5.6.5.tgz does not exist. Downloading...";
            wget -q https://dmalloc.com/releases/dmalloc-5.6.5.tgz;
          else
            echo "$ROOT_DIR/var/packages/dmaloc-5.6.5.tgz exists.";
          fi;
          if [ ! -f ../src/dmalloc-*/configure ];
          then
            echo "$ROOT_DIR/src/dmalloc-*/configure does not exist. Extracting package...";
            tar -xf dmalloc-*.tgz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/dmalloc-*/configure exists.";
          fi;
          ;;
        file)
          if [ ! -f file-5.45.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/file-5.45.tar.gz does not exist. Downloading...";
            wget -q http://ftp.astron.com/pub/file/file-5.45.tar.gz
          else
            echo "$ROOT_DIR/var/packages/file-5.45.tar.gz exists.";
          fi;
          if [ ! -f ../src/file-*/configure ];
          then
            echo "$ROOT_DIR/src/file-*/configure does not exist. Extracting package...";
            tar -xf file-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/file-*/configure exists.";
          fi;
          ;;
        findutils)
          if [ ! -f findutils-4.9.0.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/findutils-4.9.0.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/findutils/findutils-4.9.0.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/findutils-3.10.tar.xz exists.";
          fi;
          if [ ! -f ../src/findutils-*/configure ];
          then
            echo "$ROOT_DIR/src/findutils-*/configure does not exist. Extracting package...";
            tar -xf findutils-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/findutils-*/configure exists.";
          fi;
          ;;
        flex)
          if [ ! -f flex-2.6.4.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/flex-2.6.4.tar.gz does not exist. Downloading...";
            wget -q https://github.com/westes/flex/archive/refs/tags/v2.6.4.tar.gz;
            mv v2.6.4.tar.gz flex-2.6.4.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/flex-2.6.4.tar.gz exists.";
          fi;
          if [ ! -f ../src/flex-*/configure ];
          then
            echo "$ROOT_DIR/src/flex-*/configure does not exist. Extracting package...";
            tar -xf flex-*.tar.gz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/flex-*;
            ./autogen.sh;
            cd $ROOT_DIR/packages;
          else
            echo "$ROOT_DIR/src/flex-*/configure exists.";
          fi
          ;;
        gawk)
          if [ ! -f gawk-5.3.0.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/gawk-5.3.0.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/gawk/gawk-5.3.0.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/gawk-5.3.0.tar.xz exists.";
          fi;
          if [ ! -f ../src/gawk-*/configure ];
          then
            echo "$ROOT_DIR/src/gawk-*/configure does not exist. Extracting package...";
            tar -xf gawk-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/gawk-*/configure exists.";
          fi;
          ;;
        gcc)
          if [ ! -f gcc-13.2.0.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/gcc-13.2.0.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/gcc-13.2.0.tar.xz exists.";
          fi;
          if [ ! -f ../src/gcc-*/configure ];
          then
            echo "$ROOT_DIR/src/gcc-*/configure does not exist. Extracting package...";
            tar -xf gcc-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/binutils-*/configure exists.";
          fi;
          ;;
        gdb)
          if [ ! -f gdb-14.1.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/gdb-14.1.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/gdb/gdb-14.1.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/gdb-14.1.tar.xz exists.";
          fi;
          if [ ! -f ../src/gdb-*/configure ];
          then
            echo "$ROOT_DIR/src/gdb-*/configure does not exist. Extracting package...";
            tar -xf gdb-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/gdb-*/configure exists.";
          fi;
          ;;
        gettext)
          if [ ! -f gettext-0.22.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/gettext-0.22.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/gettext/gettext-0.22.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/gettext-0.22.tar.xz exists.";
          fi;
          if [ ! -f ../src/gettext-*/configure ];
          then
            echo "$ROOT_DIR/src/gettext-*/configure does not exist. Extracting package...";
            tar -xf gettext-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/gettext-*/configure exists.";
          fi;
          ;;
        glibc)
          if [ ! -f glibc-2.38.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/glibc-2.38.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/glibc/glibc-2.38.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/glibc-2.38.tar.xz exists.";
          fi;
          if [ ! -f ../src/glibc-*/configure ];
          then
            echo "$ROOT_DIR/src/glibc-*/configure does not exist. Extracting package...";
            tar -xf glibc-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/glibc-*/configure exists.";
          fi;
          ;;
        gmp)
          if [ ! -f gmp-6.3.0.tar.lz ];
          then
            echo "$ROOT_DIR/var/packages/gmp-6.3.0.tar.lz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.lz;
          else
            echo "$ROOT_DIR/var/packages/gmp-6.3.0.tar.lz exists.";
          fi;
          if [ ! -f ../src/gmp-*/configure ];
          then
            echo "$ROOT_DIR/src/gmp-*/configure does not exist. Extracting package...";
            tar -xf gmp-*.tar.lz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/gmp-*/configure exists.";
          fi;
          ;;
        gperf)
          if [ ! -f gperf-3.1.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/gperf-3.1.tar.gz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz;
          fi;
          if [ ! -f ../src/gperf-*/configure ];
          then
            echo "$ROOT_DIR/src/gperf-*/configure does not exist. Extracting package...";
            tar -xf gperf-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/gperf-*/configure exists.";
          fi;
          ;;
        grep)
          if [ ! -f grep-3.11.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/grep-3.11.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz;
          fi;
          if [ ! -f ../src/grep-*/configure ];
          then
            echo "$ROOT_DIR/src/grep-*/configure does not exist. Extracting package...";
            tar -xf grep-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/grep-*/configure exists.";
          fi;
          ;;
        guile)
          if [ ! -f guile-3.0.9.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/guile.3.0.9.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/guile/guile-3.0.9.tar.xz;
          fi;
          if [ ! -f ../src/guile-*/configure ];
          then
            echo "$ROOT_DIR/src/guile-*/configure does not exist. Extracting package...";
            tar -xf guile-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/guile-*/configure exists.";
          fi;
          ;;
        gzip)
          if [ ! -f gzip-1.13.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/gzip-1.13.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz;
          fi;
          if [ ! -f ../src/gzip-*/configure ];
          then
            echo "$ROOT_DIR/src/gzip-*/configure does not exist. Extracting package...";
            tar -xf gzip-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/gzip-*/configure exists.";
          fi;
          ;;
        help2man)
          if [ ! -f help2man-1.49.3.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/help2man-1.49.3.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/help2man/help2man-1.49.3.tar.xz;
          fi;
          if [ ! -f ../src/help2man-*/configure ];
          then
            tar -xf help2man-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/help2man-*/configure exists.";
          fi;
          ;;
        isl)
          if [ ! -f isl-0.26.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/isl-0.26.tar.xz does not exist. Downloading...";
            wget -q https://libisl.sourceforge.io/isl-0.26.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/isl-0.26.tar.xz exists.";
          fi;
          if [ ! -f ../src/isl-*/configure ];
          then
            echo "$ROOT_DIR/src/isl-*/configure does not exist. Extracting package...";
            tar -xf isl-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/isl-*/configure exists.";
          fi;
          ;;
        jdk)
          if [ ! -f jdk-21-ga.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/jdk-21-ga.tar.gz does not exist. Downloading...";
            wget -q https://github.com/openjdk/jdk21/archive/refs/tags/jdk-21-ga.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/jdk-21-ga.tar.gz exists.";
          fi;
          if [ ! -f ../src/jdk-*/configure ];
          then
            echo "$ROOT_DIR/src/jdk-*/configure does not exist. Extracting package...";
            tar -xf jdk-*.tar.gz -C $ROOT_DIR/src;
            mv $ROOT_DIR/src/jdk21-jdk-21-ga $ROOT_DIR/src/jdk-21-ga;
            chmod +x $ROOT_DIR/src/jdk-21-ga/configure;
          else
            echo "$ROOT_DIR/src/jdk-*/configure exists.";
          fi;
          ;;
        libatomic_ops)
          if [ ! -f libatomic_ops-7.8.0.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/libatomic_ops-7.8.0.tar.gz does not exist. Downloading...";
            wget -q https://www.hboehm.info/gc/gc_source/libatomic_ops-7.8.0.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/libatomic_ops-7.8.0.tar.gz exists.";
          fi;
          if [ ! -f ../src/libatomic_ops-*/configure ];
          then
            echo "$ROOT_DIR/src/libatomic_ops-*/configure does not exist. Extracting package...";
            tar -xf libatomic_ops-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/libatomic_ops-*/configure exists.";
          fi;
          ;;
        libcap)
          if [ ! -f libcap-2.69.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/libcap-2.69.tar.gz does not exist. Downloading...";
            wget -q https://git.kernel.org/pub/scm/libs/libcap/libcap.git/snapshot/libcap-2.69.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/libcap2-69.tar.gz exists.";
          fi;
          if [ ! -f ../src/libcap-*/Makefile ];
          then
            echo "$ROOT_DIR/src/libcap-*/Makefile does not exist. Extracting package...";
            tar -xf libcap-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/libcap-*/configure exists.";
          fi;
          ;;
        libffi)
          if [ ! -f libffi-3.4.4.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/libffi-3.4.4.tar.gz does not exist. Downloading...";
            wget -q https://github.com/libffi/libffi/archive/refs/tags/v3.4.4.tar.gz;
            mv v3.4.4.tar.gz libffi-3.4.4.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/libffi-3.4.4.tar.gz exists.";
          fi;
          if [ ! -f ../src/libffi-*/configure ];
          then
            echo "$ROOT_DIR/src/libffi-*/configure does not exist. Extracting package...";
            tar -xf libffi-*.tar.gz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/libffi-*;
            ./autogen.sh;
            cd $ROOT_DIR/packages;
          else
            echo "$ROOT_DIR/src/libffi-*/configure exists.";
          fi;
          ;;
        #libselinux)
        #  if [ ! -f libselinux-3.6.tar.gz ];
        #  then
        #    echo "$ROOT_DIR/var/packages/libselinux-3.6.tar.gz does not exist. Downloading...";
        #    wget -q https://github.com/SELinuxProject/selinux/releases/download/3.6/libselinux-3.6.tar.gz;
        #  else
        #    echo "$ROOT_DIR/var/packages/libselinux-3.6.tar.gz exists.";
        #  fi;
        #  if [ ! -f ../src/libselinux-*/configure ];
        #  then
        #    echo "$ROOT_DIR/src/libselinux-*/configure does not exist. Extracting package...";
        #    tar -xf libselinux-*.tar.gz -C $ROOT_DIR/src;
        #  else
        #    echo "$ROOT_DIR/src/libselinux-*/configure exists.";
        #  fi;
        #  ;;
        #libsepol)
        #  if [ ! -f libsepol-3.6.tar.gz ];
        #  then
        #    echo "$ROOT_DIR/var/packages/libsepol-3.6.tar.gz does not exist. Downloading...";
        #    wget -q https://github.com/SELinuxProject/selinux/releases/download/3.6/libsepol-3.6.tar.gz;
        #  else
        #    echo "$ROOT_DIR/var/packages/libsepol-3.6.tar.gz exists.";
        #  fi;
        #  if [ ! -f ../src/libsepol-*/configure ];
        #  then
        #    echo "$ROOT_DIR/src/libsepol-*/configure does not exist. Extracting package...";
        #    tar -xf libsepol-*.tar.gz -C $ROOT_DIR/src;
        #  else
        #    echo "$ROOT_DIR/src/libsepol-*/configure exists.";
        #  fi;
        #  ;;
        libtool)
          if [ ! -f libtool-2.4.7.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/libtool-2.4.7.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/libtool/libtool-2.4.7.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/libtool-2.4.7.tar.xz exists.";
          fi;
          if [ ! -f ../src/libtool-*/configure ];
          then
            echo "$ROOT_DIR/src/libtool-*/configure does not exist. Extracting package...";
            tar -xf libtool-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/libtool-*/configure exists.";
          fi;
          ;;
        libunistring)
          if [ ! -f libunistring-1.1.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/libunistring-1.1.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/libunistring/libunistring-1.1.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/libunistring-1.1.tar.xz exists.";
          fi;
          if [ ! -f ../src/libunistring-*/configure ];
          then
            echo "$ROOT_DIR/src/libunistring-*/configure does not exist. Extracting package...";
            tar -xf libunistring-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/libunistring-*/configure exists.";
          fi;
          ;;
        lzip)
          if [ ! -f lzip-1.24-rc2.tar.lz ];
          then
            echo "$ROOT_DIR/var/packages/lzip-1.24-rc2.tar.lz does not exist. Downloading...";
            wget -q https://download.savannah.gnu.org/releases/lzip/lzip-1.24-rc2.tar.lz;
          else
            echo "$ROOT_DIR/var/packages/lzip-1.24-rc2 exists.";
          fi;
          if [ ! -f ../src/lzip-*/configure ];
          then
            echo "$ROOT_DIR/src/lzip-*/configure does not exist. Extracting package...";
            tar -xf lzip-*.tar.lz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/lzip-*/configure exists.";
          fi;
          ;;
        lzo)
          if [ ! -f lzo-2.10.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/lzo-2.10.tar.gz does not exist. Downloading...";
            wget -q https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/lzo-2.10.tar.gz exists.";
          fi;
          if [ ! -f ../src/lzo-*/configure ];
          then
           echo "$ROOT_DIR/src/lzo-*/configure does not exist. Extracting package...";
           tar -xf lzo-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/lzo-*/configure exists.";
          fi;
          ;;
        lzop)
          if [ ! -f lzop-1.04.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/lzop-1.04.tar.gz does not exist. Downloading...";
            wget -q https://www.lzop.org/download/lzop-1.04.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/lzop-1.04.tar.gz exists.";
          fi;
          if [ ! -f ../src/lzop-*/configure ];
          then
           echo "$ROOT_DIR/src/lzop-*/configure does not exist. Extracting package...";
           tar -xf lzop-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/lzop-*/configure exists.";
          fi;
          ;;
        m4)
          if [ ! -f m4-1.4.19.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/m4-1.4.19.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/m4-1.4.19.tar.xz exists.";
          fi;
          if [ ! -f ../src/m4-*/configure ];
          then
            echo "$ROOT_DIR/src/m4-*/configure does not exist. Extracting package...";
            tar -xf m4-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/m4-*/configure exists.";
          fi;
          ;;
        mingw-w64)
          if [ ! -f mingw-w64-6.0.2.zip ];
          then
            echo "$ROOT_DIR/var/packages/mingw-w64-6.0.2.zip does not exist. Downloading...";
            wget -q https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v6.0.1.zip/download;
            mv download mingw-w64-6.0.2.zip;
          else
            echo "$ROOT_DIR/var/packages/mingw-w64-6.0.2.zip exists.";
          fi;
          if [ ! -f ../src/mingw-w64-*/configure ];
          then
            echo "$ROOT_DIR/src/mingw-w64-*/configure does not exist. Extracting package...";
            unzip -q mingw-w64-6.0.2.zip -d $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/mingw-w64-*/configure exists.";
          fi;
          ;;
        mpc)
          if [ ! -f mpc-1.3.1.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/mpc-1.3.1.tar.gz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/mpc-1.3.1.tar.gz exists.";
          fi;
          if [ ! -f ../src/mpc-*/configure ];
          then
            echo "$ROOT_DIR/src/mpc*/configure does not exist. Extracting package...";
            tar -xf mpc-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/mpc-*/configure exists.";
          fi;
          ;;
        mpfr)
          if [ ! -f mpfr-4.2.1.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/mpfr-4.2.1.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/mpfr-4.2.1.tar.xz exists.";
          fi;
          if [ ! -f ../src/mpfr-*/configure ];
          then
            echo "$ROOT_DIR/src/mpfr-*/configure does not exist. Extracting package...";
            tar -xf mpfr-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/mpfr-*/configure exists.";
          fi;
          ;;
        ncompress)
          if [ ! -f ncompress-5.0.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/ncompress-5.0.tar.gz does not exist. Downloading...";
            wget -q https://github.com/vapier/ncompress/archive/refs/tags/v5.0.tar.gz;
          fi;
          if [ ! -f ../src/ncompress-*/GNUmakefile ];
          then
            echo "$ROOT_DIR/src/ncompress-*/GNUmakefile does not exist. Extracting package...";
            tar -xf v5.0.tar.gz -C $ROOT_DIR/src;
            mv v5.0.tar.gz ncompress-5.0.tar.gz;
          else
            echo "$ROOT_DIR/src/ncompress-*/GNUmakefile exists.";
          fi;
          ;;
        nettle)
          if [ ! -f nettle-3.9.1.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/nettle-3.9.1.tar.gz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/nettle/nettle-3.9.1.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/nettle-3.9.1.tar.gz exists.";
          fi;
          if [ ! -f ../src/nettle-*/configure ];
          then
            echo "$ROOT_DIR/src/nettle-*/configure does not exist. Extracting package...";
            tar -xf nettle-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/nettle-*/configure exists.";
          fi;
          ;;
        openssl)
          if [ ! -f openssl-3.2.0.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/openssl-3.2.0.tar.gz does not exist. Downloading...";
            wget -q https://github.com/openssl/openssl/archive/refs/tags/openssl-3.2.0.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/openssl-3.2.0.tar.gz exists.";
          fi;
          if [ ! -f ../src/openssl-*/Configure ];
          then
            echo "$ROOT_DIR/src/openssl-*/Configure does not exist. Extracting package...";
            tar -xf openssl-*.tar.gz -C $ROOT_DIR/src;
            mv $ROOT_DIR/src/openssl* $ROOT_DIR/src/openssl-3.2.0;
          else
            echo "$ROOT_DIR/src/openssl-*/Configure exists.";
          fi;
          ;;
        patch)
          if [ ! -f patch-2.7.6.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/patch-2.7.6.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz;
          else
            echo "$ROOT_DIR/var/packages/patch-2.7.6.tar.xz exists.";
          fi;
          if [ ! -f ../src/patch-*/configure ];
          then
            echo "$ROOT_DIR/src/patch-*/configure does not exist. Extracting package...";
            tar -xf patch-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/patch-*/configure exists.";
          fi;
          ;;
        pcre2)
          if [ ! -f pcre2-10.42.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/pcre2-10.42.tar.gz does not exist. Downloading...";
            wget -q https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/pcre2-10.42.tar.gz exists.";
          fi;
          if [ ! -f ../src/pcre2-*/configure ];
          then
            echo "$ROOT_DIR/src/pcre2-*/configure does not exist. Extracting package...";
            tar -xf pcre2-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/pcre2-*/Configure exists.";
          fi;
          ;;
        perl)
          if [ ! -f perl-5.38.2.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/perl-5.38.2.tar.gz does not exist. Downloading...";
            wget -q https://www.cpan.org/src/5.0/perl-5.38.2.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/perl-5.38.2.tar.gz exists.";
          fi;
          if [ ! -f ../src/perl-*/Configure ];
          then
            echo "$ROOT_DIR/src/perl-*/Configure does not exist. Extracting package...";
            tar -xf perl-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/perl-*/Configure exists.";
          fi;
          ;;
        readline)
          if [ ! -f readline-8.2.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/readline-8.2.tar.gz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/readline/readline-8.2.tar.lz;
          fi;
          if [ ! -f ../src/readline-*/configure ];
          then
            echo "$ROOT_DIR/src/readline-*/configure does not exist. Extracting package...";
            tar -xf readline-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/readline-*/configure exists.";
          fi;
          ;;
        sed)
          if [ ! -f sed-4.9.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/sed-4.9.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz;
          fi;
          if [ ! -f ../src/sed-*/configure ];
          then
            echo "$ROOT_DIR/src/sed-*/configure does not exist. Extracting package...";
            tar -xf sed-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/sed-*/configure exists.";
          fi;
          ;;
        tar)
          if [ ! -f tar-1.35.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/tar-1.35.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz;
          fi;
          if [ ! -f ../src/tar-*/configure ];
          then
            echo "$ROOT_DIR/src/tar-*/configure does not exist. Extracting package...";
            tar -xf tar-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/tar-*/configure exists.";
          fi;
          ;;
        termcap)
          if [ ! -f termcap-1.3.1.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/termcap-1.3.1.tar.gz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/termcap/termcap-1.3.1.tar.gz;
          fi;
          if [ ! -f ../src/termcap-*/configure ];
          then
            echo "$ROOT_DIR/src/termcap-*/configure does not exist. Extracting package...";
            tar -xf termcap-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/termcap-*/configure exists.";
          fi;
          ;;
        texinfo)
          if [ ! -f texinfo-7.1.tar.xz ];
          then
            echo "$ROOT_DIR/var/packages/texinfo-7.1.tar.xz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/texinfo/texinfo-7.1.tar.xz;
          fi;
          if [ ! -f ../src/texinfo-*/configure ];
          then
            echo "$ROOT_DIR/src/texinfo-*/configure does not exist. Extracting package...";
            tar -xf texinfo-*.tar.xz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/texinfo-*/configure exists.";
          fi;
          ;;
        unzip)
          if [ ! -f unzip-6.0.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/unzip-6.0.tar.gz does not exist. Downloading...";
            wget -q https://sourceforge.net/projects/infozip/files/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz;
            mv unzip60.tar.gz unzip-6.0.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/unzip-6.0.tar.gz exists.";
          fi;
          if [ ! -f ../src/unzip-*/unix/configure ];
          then
            echo "$ROOT_DIR/src/unzip-*/unix/configure does not exist. Extracting package...";
            tar -xf unzip-*.tar.gz -C $ROOT_DIR/src;
            mv $ROOT_DIR/src/unzip60 $ROOT_DIR/src/unzip-6.0;
            cp -r $ROOT_DIR/src/unzip-6.0/unix/* $ROOT_DIR/src/unzip-6.0;
            cp -r $ROOT_DIR/src/bzip2-*/* $ROOT_DIR/src/unzip-6.0/bzip2;
          else
            echo "$ROOT_DIR/src/unzip-*/configure exists.";
          fi;
          ;;
        valgrind)
          if [ ! -f valgrind-3.22.0.tar.bz2 ];
          then
            echo "$ROOT_DIR/var/packages/valgrind-3.22.0.tar.bz2 does not exist. Downloading...";
            wget -q https://sourceware.org/pub/valgrind/valgrind-3.22.0.tar.bz2;
          fi;
          if [ ! -f ../src/valgrind-*/configure ];
          then
            echo "$ROOT_DIR/src/valgrind-*/configure does not exist. Extracting package...";
            tar -xf valgrind-*.tar.bz2 -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/valgrind-*;
            ./autogen.sh;
            cd $ROOT_DIR/packages;
          else
            echo "$ROOT_DIR/src/valgrind-*/configure exists.";
          fi;
          ;;
        wget2)
          if [ ! -f wget2-2.1.0.tar.lz ];
          then
            echo "$ROOT_DIR/var/packages/wget2-2.1.0.tar.lz does not exist. Downloading...";
            wget -q https://ftp.gnu.org/gnu/wget/wget2-1.35.tar.lz;
          fi;
          if [ ! -f ../src/wget2-*/configure ];
          then
            echo "$ROOT_DIR/src/wget2-*/configure does not exist. Extracting package...";
            tar -xf wget2-*.tar.lz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/wget2-*/configure exists.";
          fi;
          ;;
        xz)
          if [ ! -f xz-5.4.5.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/xz-5.4.5.tar.gz does not exist. Downloading...";
            wget -q https://github.com/tukaani-project/xz/archive/refs/tags/v5.4.5.tar.gz;
            mv v5.4.5.tar.gz xz-5.4.5.tar.gz;
          fi;
          if [ ! -f ../src/xz-*/configure ];
          then
            echo "$ROOT_DIR/src/xz-*/configure does not exist. Extracting package...";
            tar -xf xz-*.tar.gz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/xz-*;
            ./autogen.sh;
            cd $ROOT_DIR/packages;
          else
            echo "$ROOT_DIR/src/tar-*/configure exists.";
          fi;
          ;;
        zip)
          if [ ! -f zip-3.0.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/zip-3.0.tar.gz does not exist. Downloading...";
            wget -q https://sourceforge.net/projects/infozip/files/Zip%203.x%20%28latest%29/3.0/zip30.tar.gz;
            mv zip30.tar.gz zip-3.0.tar.gz;
          else
            echo "$ROOT_DIR/var/packages/zip-3.0.tar.gz exists.";
          fi;
          if [ ! -f ../src/zip-*/unix/configure ];
          then
            echo "$ROOT_DIR/src/zip-*/unix/configure does not exist. Extracting package...";
            tar -xf zip-*.tar.gz -C $ROOT_DIR/src;
            mv $ROOT_DIR/src/zip30 $ROOT_DIR/src/zip-3.0;
            cp -r $ROOT_DIR/src/zip-3.0/unix/* $ROOT_DIR/src/zip-3.0;
            cp -r $ROOT_DIR/src/bzip2-*/* $ROOT_DIR/src/zip-3.0/bzip2;
          else
            echo "$ROOT_DIR/src/zip-*/configure exists.";
          fi;
          ;;
        zstd)
          if [ ! -f zstd-1.5.5.tar.gz ];
          then
            echo "$ROOT_DIR/var/packages/zstd-1.5.5.tar.gz does not exist. Downloading...";
            wget -q https://github.com/facebook/zstd/archive/refs/tags/v1.5.5.tar.gz;
            mv v1.5.5.tar.gz zstd-1.5.5.tar.gz;
          fi;
          if [ ! -f ../src/zstd-*/Makefile ];
          then
            echo "$ROOT_DIR/src/zstd-*/Makefile does not exist. Extracting package...";
            tar -xf zstd-*.tar.gz -C $ROOT_DIR/src;
          else
            echo "$ROOT_DIR/src/zstd-*/Makefile exists.";
          fi;
          ;;
      esac;
    done;
    ;;
  stop)
    exit;
    ;;
  *)
    ;;
esac;

for i in ${TARGETS[@]};
do
  if [ $i = "aarch64-unknown-linux-gnu" ];
  then
    SOFTWARE_TO_BUILD=(gdb valgrind cpython jdk perl m4 autoconf automake file make libcap libtool readline acl attr bash bdm-gc bison bzip2 coreutils dejagnu diffutils dmalloc file findutils flex gawk gettext glibc gperf grep guile gzip help2man libatomic_ops libffi lzip lzo lzop ncompress nettle openssl patch pcre2 sed tar termcap texinfo unzip wget2 zip zstd gmp isl mpfr mpc binutils cmake gcc);
  else
    SOFTWARE_TO_BUILD=(binutils mingw-w64-headers gcc mingw-w64 gcc-pass2);
  fi;
  for j in ${SOFTWARE_TO_BUILD[@]};
  do
    if [ ! $j = "bzip2" ] && [ ! $j = "gcc-pass2" ] && [ ! $j = "libcap" ] && [ ! $j = "libselinux" ] && [ ! $j = "libsepol" ] && [ ! $j = "unzip" ] && [ ! $j = "zip" ] && [ ! $j = "zstd" ];
    then
      read -p "Do you want to configure $j for $i? [y to proceed]: ";
      case $REPLY in
        y)
          if [ ! $j = "ncompress" ];
          then
            if [ ! -d $ROOT_DIR/build/$i/$j ];
            then
              mkdir $ROOT_DIR/build/$i/$j;
            fi;
            cd $ROOT_DIR/build/$i/$j;
            rm -r *;
          fi;
          case $j in
            acl)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-year2038 --with-aix-soname=both;
              ;;
            attr)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --with-aix-soname=both;
              ;;
            autoconf)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            automake)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            bash)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-alias --enable-alt-array-implementation --enable-arith-for-command --enable-array-variables --enable-bang-history --enable-brace-expansion --enable-casemod-attributes --enable-casemod-expansions --enable-command-timing --enable-cond-command --enable-cond-regexp --enable-coprocesses --enable-directory-stack --enable-dparen-arithmetic --enable-extended-glob --enable-help-builtin --enable-history --enable-job-control --enable-multibyte --enable-net-redirections --enable-process-substitution --enable-progcomp --enable-readline --enable-restricted --enable-select --enable-translatable-strings --enable-threads=posix;
              ;;
            bdm-gc)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-cplusplus --enable-dependency-tracking --enable-emscrypten-asyncify --enable-shared --enable-static --enable-threads=posix --with-aix-soname=both --with-libatomic-ops=yes;
              ;;
            binutils)
            #--enable-jansson
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --disable-multilib --enable-checking --enable-compressed-debug-sections=all --enable-default-hash-style=both --enable-dependency-tracking --enable-error-handling-script --enable-gold --enable-gprofng --enable-install-libbfd --enable-install-libiberty --enable-ld --enable-leading-mingw-underscores --enable-libada --enable-liboffloadmic=target --enable-libssp --enable-lto --enable-new-dtags --enable-objc-gc --enable-plugins --enable-shared --enable-static --enable-textrel-check=yes --enable-vtable-verify --enable-warn-execstack --enable-warn-rwx-segments --enable-year2038;
              ;;
            bison)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-threads=posix;
              ;;
            cmake)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i;
              ;;
            coreutils)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$j/include --target=$i --enable-dependency-tracking --enable-install-program=arch,coreutils,hostname --enable-systemd --enable-threads=posix --with-linux-crypto --with-openssl=yes;
              ;;
            cpython)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-optimizations;
              ;;
            dejagnu)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            diffutils)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$j/include --target=$i --enable-dependency-tracking --enable-threads=posix;
              ;;
            dmalloc)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$j/include --target=$i --enable-threads=posix CXX=g++;
              ;;
            file)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include;
              ;;
            findutils)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$j/include --target=$i --enable-d_type-optimization --enable-dependency-tracking --enable-leaf-optimisation --enable-threads=posix;
              ;;
            flex)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --target=$i --enable-dependency-tracking --with-aix-soname=both;
              ;;
            gawk)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$j/include --target=$i --enable-builtin-intdiv0 --enable-dependency-tracking;
              ;;
            gdb)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            gcc)
              if [ $i = "x86_64-w64-mingw32" ]
              then
                ./../../../src/gcc-*/configure --prefix=$ROOT_DIR/install/$i --target=$i --disable-multilib --enable-languages=c,c++,d,fortran,lto,m2,objc,obj-c++ --enable-threads=posix;
              else
                ./../../../src/gcc-*/configure --prefix=$ROOT_DIR/install/$i --target=$i --disable-multilib --enable-languages=ada,c,c++,d,fortran,go,lto,m2,objc,obj-c++ --enable-threads=posix;
              fi;
              ;;
            gettext)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-shared --enable-static --enable-threads=posix --enable-year2038 --with-aix-soname=both;
              ;;
            glibc)
            #--with-selinux
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-crypt --enable-pt_chown --enable-stack-protector=strong;
              ;;
            gmp)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --build=$i --enable-assert --enable-cxx --enable-fat --enable-profiling=gprof --with-aix-soname=both --with-gnu-ld --with-readline;
              ;;
            gperf)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            grep)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-threads=posix;
              ;;
            guile)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-lto --enable-shared --enable-static --enable-year2038 --with-aix-soname=both --with-threads;
              ;;
            gzip)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking;
              ;;
            help2man)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-nls;
              ;;
            isl)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --enable-dependency-tracking --with-aix-soname=both;
              ;;
            jdk)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-headless-only;
              ;;
            libatomic_ops)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-assertions --enable-dependency-tracking --enable-shared --enable-static --with-aix-soname=both;
              ;;
            libffi)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking;
              ;;
            libtool)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-ltdl-install --enable-static --enable-shared --with-aix-soname=both;
              ;;
            libunistring)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-threads=posix;
              ;;
            lzip)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i;
              ;;
            lzo)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking --enable-shared;
              ;;
            lzop)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-dependency-tracking;
              ;;
            m4)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-c++ --enable-changeword --enable-dependency-tracking --enable-threads=posix --with-dmalloc;
              ;;
            mingw-w64)
              ./../../../src/mingw-w64-*/configure --prefix=$ROOT_DIR/install/$i/$i --host=$i --with-libraries=winpthreads CXXFLAGS="-std=c++14";
              ;;
            mingw-w64-headers)
              ./../../../src/mingw-w64-*/$j/configure --prefix=$ROOT_DIR/install/$i/$i --host=$i;
              ;;
            mpc)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --enable-dependency-tracking --enable-valgrind-tests --with-aix-soname=both;
              ;;
            mpfr)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --enable-assert --enable-dependency-tracking --enable-shared-cache --enable-thread-safe --enable-warnings --with-aix-soname=both;
              ;;
            ncompress)
              cd $ROOT_DIR/src/$j-*;
              ln -s $ROOT_DIR/install/$i/bin/gcc $ROOT_DIR/install/$i/bin/cc;
              ./build CC=gcc;
              rm $ROOT_DIR/install/$i/bin/cc;
              ;;
            nettle)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --enable-gcov;
              ;;
            openssl)
              ./../../../src/$j-*/Configure --openssldir=$ROOT_DIR/install/$i --prefix=$ROOT_DIR/install/$i shared;
              ;;
            patch)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            pcre2)
              #--enable-coverage --enable-valgrind
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --enable-dependency-tracking --enable-fuzz-support --enable-jit --enable-pcre2-16 --enable-pcre2-32 --with-aix-soname=both;
              ;;
            perl)
              ./../../../src/$j-*/Configure -Dprefix=$ROOT_DIR/install/$i -Dcc=gcc -Dlocincpth=$ROOT_DIR/install/$i/include -Dloclibpth=$ROOT_DIR/install/$i/lib -Aldflags=-L$ROOT_DIR/install/$i/lib -Dmksymlinks -Duseshrplib -Dusethreads -O;
              ;;
            readline)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            sed)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            tar)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-backup-scripts --enable-dependency-tracking --with-bzip2=bzip2 --with-compress=compress --with-gzip=gzip --with-lzip=lzip --with-lzma=lzma --with-xz=xz --with-zstd=zstd;
              ;;
            termcap)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --target=$i;
              ;;
            texinfo)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            valgrind)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --enable-dependency-tracking --enable-lto --enable-tls;
              ;;
            wget2)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --with-linux-crypto=yes --with-openssl=yes;
              ;;
            xz)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --enable-dependency-tracking --enable-threads=posix --enable-year2038 --with-aix-soname=both;
              ;;
          esac;
          ;;
        stop)
          exit;
          ;;
        *)
          ;;
      esac;
    fi;

    if [ ! $j = "ncompress" ];
    then
      read -p "Do you want to build $j for $i? [y to proceed]: ";
      case $REPLY in
        y)
          if [ $j = "gcc-pass2" ];
          then
            cd $ROOT_DIR/build/$i/gcc*;
          elif [ ! $j = "bzip2" ] && [ ! $j = "libcap" ] && [ ! $j = "libselinux" ] && [ ! $j = "libsepol" ] && [ ! $j = "unzip" ] && [ ! $j = "zip" ] && [ ! $j = "zstd" ];
          then
            cd $ROOT_DIR/build/$i/$j;
          fi;
          if [ $j = "gcc" ] && [ $i = "x86_64-w64-mingw32" ];
          then
            make all-gcc -j 4;
          elif [ $j = "bash" ];
          then
            make;
          elif [ $j = "bzip2" ];
          then
            rm -r $ROOT_DIR/src/bzip2*;
            tar -xf $ROOT_DIR/packages/bzip2-*.tar.gz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/bzip2*;
            make PREFIX=$ROOT_DIR/install/$i -j 4;
          elif [ $j = "dmalloc" ];
          then
            make -j 4;
            make threads -j 4;
            make threadscxx -j 4;
          elif [ $j = "jdk" ];
          then
            make JOBS=4;
          elif [ $j = "libcap" ];
          then
            rm -r $ROOT_DIR/src/libcap*;
            tar -xf $ROOT_DIR/packages/libcap-*.tar.gz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/libcap*;
            make prefix=$ROOT_DIR/install/$i bin=bin lib=lib sbin=bin -j 4;
          #elif [ $j = "libselinux" ];
          #then
          #  rm -r $ROOT_DIR/src/libselinux*;
          #  tar -xf $ROOT_DIR/packages/libselinux-*.tar.gz -C $ROOT_DIR/src;
          #  cd $ROOT_DIR/src/libselinux*;
          #  make CC=gcc PREFIX=$ROOT_DIR/install/$i -j 4;
          #elif [ $j = "libsepol" ];
          #then
          #  rm -r $ROOT_DIR/src/libsepol*;
          #  tar -xf $ROOT_DIR/packages/libsepol-*.tar.gz -C $ROOT_DIR/src;
          #  cd $ROOT_DIR/src/libsepol*;
          #  make CC=gcc PREFIX=$ROOT_DIR/install/$i -j 4;
          elif [ $j = "unzip" ];
          then
            rm -r $ROOT_DIR/src/unzip-*;
            tar -xf $ROOT_DIR/packages/unzip-*.tar.gz -C $ROOT_DIR/src;
            mv $ROOT_DIR/src/unzip60 $ROOT_DIR/src/unzip-6.0;
            cd $ROOT_DIR/src/unzip-*;
            cp -r $ROOT_DIR/src/unzip*/unix/* $ROOT_DIR/src/unzip*;
            cp -r $ROOT_DIR/src/bzip2-*/* $ROOT_DIR/src/unzip-6.0/bzip2;
            make generic CC=gcc prefix=$ROOT_DIR/install/$i -j 4;
          elif [ $j = "zip" ];
          then
            rm -r $ROOT_DIR/src/zip-*;
            tar -xf $ROOT_DIR/packages/zip-*.tar.gz -C $ROOT_DIR/src;
            mv $ROOT_DIR/src/zip30 $ROOT_DIR/src/zip-3.0;
            cd $ROOT_DIR/src/zip-*;
            cp -r $ROOT_DIR/src/zip*/unix/* $ROOT_DIR/src/zip*;
            cp -r $ROOT_DIR/src/bzip2-*/* $ROOT_DIR/src/zip-3.0/bzip2;
            make generic CC=gcc prefix=$ROOT_DIR/install/$i -j 4;
          elif [ $j = "zstd" ];
          then
            rm -r $ROOT_DIR/src/zstd*;
            tar -xf $ROOT_DIR/packages/zstd-*.tar.gz -C $ROOT_DIR/src;
            cd $ROOT_DIR/src/zstd*;
            make CC=gcc PREFIX=$ROOT_DIR/install/$i -j 4;
          else
            make -j 4;
          fi;
          ;;
        stop)
          exit;
          ;;
        *)
          ;;
      esac;
    fi;

    if [ ! $j = "ncompress" ];
    then
      read -p "Do you want to install $j for $i? [y to proceed]: ";
      case $REPLY in
        y)
          if [ $j = "gcc-pass2" ];
          then
            cd $ROOT_DIR/build/$i/gcc;
          elif [ $j = "libcap" ] || [ $j = "libselinux" ] || [ $j = "libsepol" ] || [ $j = "unzip" ] || [ $j = "zip" ];
          then
            cd $ROOT_DIR/src/$j-*;
          else
            cd $ROOT_DIR/build/$i/$j;
          fi;
          if [ $j = "gcc" ] && [ $i = "x86_64-w64-mingw32" ];
          then
            make install-gcc -j 4;
          elif [ $j = "bash" ];
          then
            make install;
            if [ -L $ROOT_DIR/install/$i/bin/bash ];
            then
              ln -s $ROOT_DIR/install/$i/bin/bash $ROOT_DIR/install/$i/bin/sh;
            fi;
          elif [ $j = "bzip2" ];
          then
            make install PREFIX=$ROOT_DIR/install/$i -j 4;
          elif [ $j = "dmalloc" ];
          then
            make install -j 4;
            make installth -j 4;
            make installthcxx -j 4;
          elif [ $j = "jdk" ];
          then
            make install JOBS=4;
          elif [ $j = "libcap" ];
          then
            make install prefix=$ROOT_DIR/install/$i bin=bin lib=lib sbin=bin -j 4;
          #elif [ $j = "libselinux" ];
          #then
          #  make install PREFIX=$ROOT_DIR/install/$i -j 4;
          #elif [ $j = "libsepol" ];
          #then
          #  make install PREFIX=$ROOT_DIR/install/$i lib=$ROOT_DIR/install/$i/lib -j 4;
          elif [ $j = "unzip" ];
          then
            make install CC=gcc prefix=$ROOT_DIR/install/$i -j 4;
          elif [ $j = "zip" ];
          then
            make install CC=gcc prefix=$ROOT_DIR/install/$i -j 4;
          elif [ $j = "zstd" ];
          then
            make install CC=gcc PREFIX=$ROOT_DIR/install/$i -j 4;
          else
            make install -j 4;
          fi;
          ;;
        stop)
          exit;
          ;;
        *)
          ;;
      esac;

      read -p "Do you want to check $j for $i? [y to proceed]: ";
      case $REPLY in
        y)
          if [ $j = "libcap" ];
          then
            cd $ROOT_DIR/src/libcap*;
          else
            cd $ROOT_DIR/build/$i/$j;
          fi;
          make check -j 4;
          make test -j 4;
          ;;
        stop)
          exit;
          ;;
        *)
          ;;
      esac;
    fi;

  done;
done;

