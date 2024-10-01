#!/bin/bash

ARCH=aarch64-unknown-linux-gnu;
SYS_ROOT=/opt/skyhammer;

export PATH=$SYS_ROOT/$ARCH/bin:$PATH;

STUFF_TO_BUILD=(jdk perl python make automake autoconf m4 flex bison bash gmp isl mpfr mpc libffi zlib dejagnu dmalloc libtool ncurses binutils gcc cmake);

echo "Skyhammer";
echo "Eating my own dogfood...";
echo "You can enter 'stop' at any of Skyhammer's prompts to stop this script.";

echo "Checking directories...";
if [ ! -d "tmp" ]; then
  echo "tmp does not exist. Skyhammer will create it.";
  mkdir tmp;
fi;
if [ ! -d "tmp/builds" ]; then
  echo "tmp/builds does not exist. Skyhammer will create it.";
  mkdir tmp/builds;
fi;

for i in ${STUFF_TO_BUILD[@]}; do
    while true; do
        cd $SYS_ROOT/tmp/builds;
        configureOptions="";
        configureCFlags="";
        read -p "Do you want to configure $i? [y/n]: " answer;
        case $i in
            autoconf | automake | bison | dejagnu | dmalloc | libffi | libtool | m4 | make )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH";
                ;;
            bash )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --with-curses";
                configureCFlags="-Wno-implicit-function-declaration";
                ;;
            binutils )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH --with-isl=$SYS_ROOT/$ARCH --with-mpc=$SYS_ROOT/$ARCH --with-mpfr=$SYS_ROOT/$ARCH";
                ;;
            cmake )
                configureOptions="--prefix=$SYS_ROOT/$ARCH";
                ;;
            flex | gmp )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static";
                ;;
            gcc )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-languages=ada,c,c++,d,fortran,go,lto,m2,objc,obj-c++,rust --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH --with-isl=$SYS_ROOT/$ARCH --with-mpc=$SYS_ROOT/$ARCH --with-mpfr=$SYS_ROOT/$ARCH";
                ;;
            isl )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH";
                ;;
            jdk )
                configureOptions="--build=$ARCH --enable-headless-only --enable-openjdk-only";
                ;;
            mpc )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH --with-mpfr=$SYS_ROOT/$ARCH";
                ;;
            mpfr )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-shared --enable-static --with-gmp=$SYS_ROOT/$ARCH";
                ;;
            ncurses )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --includedir=$SYS_ROOT/$ARCH/include --oldincludedir=$SYS_ROOT/$ARCH/include --with-cxx-shared --with-pkg-config --with-profile --with-shared";
                ;;
            perl )
                configureOptions="-des -Dprefix=$SYS_ROOT/$ARCH -Dcc=gcc -Dmksymlinks";
                ;;
            python )
                configureOptions="--build=$ARCH --prefix=$SYS_ROOT/$ARCH --enable-optimizations --enable-shared";
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
                if [ ! -z "$(find $i -mindepth 1 -maxdepth 1)" ]; then
                    yes | rm -r $i/*;
                fi;
                cd $i;
                case $i in
                    perl )
                        ../../../src/$i*/Configure $configureOptions CFLAGS="$configureCFlags";
                        ;;
                    jdk | zlib )
                        ../../../src/$i*/configure $configureOptions;
                        ;;
                    * )
                        ../../../src/$i*/configure $configureOptions CFLAGS="$configureCFlags";
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
        makeCFlags="";
        read -p "Do you want to make $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is making $i...";
                case $i in
                    bash )
                        make CLAGS="$makeCFlags";
                        ;;
                    jdk )
                        make JOBS=4;
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
        if [ $i == cmake ] || [ $i == jdk ] || [ $i == ncurses ] || [ $i == python ]; then
            break;
        fi;
        read -p "Do you want to test $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is testing $i...";
                if [ $i == perl ]; then
                    make test -j4;
                else
                    make check -j4;
                fi;
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
        installCFlags="";
        read -p "Do you want to install $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is install $i...";
                case $i in
                    bash )
                        make install CFLAGS="$installCFlags";
                        ;;
                    jdk )
                        make images JOBS=4;
                        cp -f -r images/jdk/* $SYS_ROOT/$ARCH;
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
        if [ $i == autoconf ] || [ $i == automake ] || [ $i == dejagnu ] || [ $i == gmp ] || [ $i == isl ] || [ $i == libffi ] || [ $i == libtool ] || [ $i == mpc ] || [ $i == mpfr ] || [ $i == zlib ]; then
            break;
        fi;
	cd $SYS_ROOT/$ARCH
        read -p "Do you want to clean $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is cleaning $i...";
                stuffToCleanInArch="";
                stuffToCleanInBin="";
                stuffToCleanInLibExec="";
                case $i in
                    binutils )
                        stuffToCleanInBin=(addr2line ar as c++filt elfedit gcov gcov-dump gcov-tool gp-archive gp-collect-app gp-display-src gp-display-text gprof gprofng ld ld.bfd lto-dump nm objcopy objdump ranlib readelf size strings);
                        stuffToCleanInArch=(ar as ld ld.bfd objcopy objdump ranlib readelf);
                        ;;
                    bison )
                        stuffToCleanInBin=(bison);
                        ;;
                    cmake )
                        stuffToCleanInBin=(cmake ctest);
                        ;;
                    flex )
                        stuffToCleanInBin=(flex);
                        ;;
                    gcc )
                        stuffToCleanInBin=($ARCH-c++ $ARCH-g++ $ARCH-gcc $ARCH-gcc-14.2.0 $ARCH-gcc-ar $ARCH-gcc-nm $ARCH-gcc-ranlib $ARCH-gccgo $ARCH-gdc $ARCH-gfortran $ARCH-gm2 c++ g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gccrs gdc gfortran gm2 gnat gnatbind gnatchop gnatclean gnatkr gnatlink gnatls gnatmake gnatprep go gofmt);
                        stuffToCleanInLibExec=(buildid cc1 cc1gm2 cc1obj cc1objplus cc1plus cgo collect2 crab1 d21 f951 g++-mapper-server gnat1 go1 lto-wrapper lto1 test2json vet);
                        ;;
                    gettext )
                        stuffToCleanInBin=(envsubst gettext gettextize msgattrib msgcmt msgcomm msgconv msgen msgexec msgdilter msgfmt msggrep msginit msgmerge msgunfmt msguniq ngettext recode-sr-latin xgettext);
                        ;;
                    jdk )
                        stuffToCleanInBin=(jar jarsigner java javac javadoc javap jcmd jconsole jdb jdeprscan jdeps jfr jhsdb jimage jinfo jlink jmap jmod jpackage jps jrunscript jshell jstack jstat jstatd jwebserver keytool rmiregistry serialver);
                        ;;
                    m4 )
                        stuffToCleanInBin=(m4);
                        ;;
                    make )
                        stuffToCleanInBin=(make);
                        ;;
                    ncurses )
                        stuffToCleanInBin=(infocmp tic toe tput tset);
                        ;;
                    perl )
                        stuffToCleanInBin=(perl perl5.40.0);
                        ;;
                    python )
                        stuffToCleanInBin=(python3.12);
                        ;;
                esac;
                for j in ${stuffToCleanInArch[@]}; do
                    strip $ARCH/bin/$j;
                done
                for j in ${stuffToCleanInBin[@]}; do
                    strip bin/$j;
                done
                for j in ${stuffToCleanInLibExec[@]}; do
                    strip libexec/gcc/$ARCH/14.2.0/$j;
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
