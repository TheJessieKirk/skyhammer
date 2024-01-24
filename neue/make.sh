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
    SRCS_TO_CHECK=(acl attr autoconf automake bash bdm-gc binutils bison coreutils dejagnu diffutils findutils flex gawk gcc gettext gmp gperf grep guile gzip help2man isl libatomic_ops libcap libffi libtool libunistring m4 make mingw-w64 mpc mpfr openssl patch perl readline sed tar termcap texinfo wget2);
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
          if [ ! -f automake-*.tar.xz ];
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
            echo "$ROOT_DIR/var/packages/bdm-gc-8.2.4tar.gz does not exist. Downloading...";
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
    SOFTWARE_TO_BUILD=(coreutils perl m4 autoconf automake make libcap libtool readline acl attr bash bdm-gc bison coreutils dejagnu diffutils findutils flex gawk gettext gperf grep guile gzip help2man libatomic_ops libffi openssl patch sed tar termcap texinfo wget2 gmp isl mpfr mpc binutils gcc);
  else
    SOFTWARE_TO_BUILD=(binutils mingw-w64-headers gcc mingw-w64 gcc-pass2);
  fi;
  for j in ${SOFTWARE_TO_BUILD[@]};
  do
    if [ ! $j = "gcc-pass2" ] && [ ! $j = "libcap" ];
    then
      read -p "Do you want to configure $j for $i? [y to proceed]: ";
      case $REPLY in
        y)
          if [ ! -d $ROOT_DIR/build/$i/$j ];
          then
            mkdir $ROOT_DIR/build/$i/$j;
          fi;
          cd $ROOT_DIR/build/$i/$j;
          rm -r *;
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
            coreutils)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$j/include --target=$i --enable-dependency-tracking --enable-install-program=arch,coreutils,hostname --enable-systemd --enable-threads=posix --with-linux-crypto --with-openssl=yes;
              ;;
            dejagnu)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            diffutils)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$j/include --target=$i --enable-dependency-tracking --enable-threads=posix;
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
            gmp)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
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
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            help2man)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-nls;
              ;;
            isl)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
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
            m4)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i --enable-c++ --enable-changeword --enable-dependency-tracking --enable-threads=posix;
              ;;
            mingw-w64)
              ./../../../src/mingw-w64-*/configure --prefix=$ROOT_DIR/install/$i/$i --host=$i --with-libraries=winpthreads CXXFLAGS="-std=c++14";
              ;;
            mingw-w64-headers)
              ./../../../src/mingw-w64-*/$j/configure --prefix=$ROOT_DIR/install/$i/$i --host=$i;
              ;;
            mpc)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            mpfr)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            openssl)
              ./../../../src/$j-*/Configure --openssldir=$ROOT_DIR/install/$i --prefix=$ROOT_DIR/install/$i shared;
              ;;
            patch)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            perl)
            #-Dusesocks
              ./../../../src/$j-*/Configure -Dprefix=$ROOT_DIR/install/$i -Dcc=gcc -Duselongdouble -Dmksymlinks -Duseshrplib -O;
              ;;
            readline)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            sed)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            tar)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            termcap)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            texinfo)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
              ;;
            wget2)
              ./../../../src/$j-*/configure --prefix=$ROOT_DIR/install/$i --oldincludedir=$ROOT_DIR/install/$i/include --target=$i;
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

    read -p "Do you want to build $j for $i? [y to proceed]: ";
    case $REPLY in
      y)
        if [ $j = "gcc-pass2" ];
        then
          cd $ROOT_DIR/build/$i/gcc*;
        else
          cd $ROOT_DIR/build/$i/$j;
        fi;
        if [ $j = "gcc" ] && [ $i = "x86_64-w64-mingw32" ];
        then
          make all-gcc -j 4;
        elif [ $j = "bash" ];
        then
          make;
        elif [ $j = "libcap" ];
        then
          rm -r $ROOT_DIR/src/libcap*;
          tar -xf $ROOT_DIR/packages/libcap-*.tar.gz -C $ROOT_DIR/src;
          cd $ROOT_DIR/src/libcap*;
          make prefix=$ROOT_DIR/install/$i bin=bin lib=lib sbin=bin -j 4;
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

    read -p "Do you want to install $j for $i? [y to proceed]: ";
    case $REPLY in
      y)
        if [ $j = "gcc-pass2" ];
        then
          cd $ROOT_DIR/build/$i/gcc;
        elif [ $j = "libcap" ];
        then
          cd $ROOT_DIR/src/libcap*;
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
        elif [ $j = "libcap" ];
        then
          make install prefix=$ROOT_DIR/install/$i bin=bin lib=lib sbin=bin -j 4;
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
  done;
done;

