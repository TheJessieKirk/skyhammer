#!/bin/bash

ARCH=aarch64-unknown-linux-gnu;
SYS_ROOT=/opt/skyhammer;

export PATH=$SYS_ROOT/$ARCH/bin:$PATH;

STUFF_TO_BUILD=(binutils gcc);

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
        read -p "Do you want to configure $i? [y/n]: " answer;
        case $i in
            binutils )
                configureOptions="--enable-shared --enable-static";
                ;;
            gcc )
                configureOptions="--enable-languages=ada,c,c++,d,fortran,go,lto,m2,objc,obj-c++,rust --enable-shared --enable-static";
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
                ../../../src/$i*/configure --build=$ARCH --prefix=$SYS_ROOT/$ARCH $configureOptions;
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
        read -p "Do you want to make $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is making $i...";
                make -j4;
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
        read -p "Do you want to install $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is install $i...";
                make install -j4;
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
	cd $SYS_ROOT/$ARCH
        read -p "Do you want to clean $i? [y/n]: " answer;
        case $answer in
            y )
                echo "Skyhammer is cleaning $i...";
                stuffToCleanInArch="";
                stuffToCleanInBin="";
                stuffToCleanInLibExec="";
                case $i in
                    autoconf )
                        stuffToCleanInBin=(aclocal aclocal-1.17 autoconf autoheader autom4te autoreconf autoheader autopoint);
                        ;;
                    automake )
                        stuffToCleanInBin=(automake automake-1.17);
                        ;;
                    binutils )
                        stuffToCleanInBin=(addr2line ar as c++filt elfedit gcov gcov-dump gcov-tool gp-archive gp-collect-app gp-display-src gp-display-text gprof gprofng ld ld.bfd lto-dump nm objcopy objdump ranlib readelf size strings);
                        stuffToCleanInArch=(ar as ld ld.bfd objcopy objdump ranlib readelf strip);
                        $ARCH/bin/strip bin/strip;
                        ;;
                    bison )
                        stuffToCleanInBin=(bison yacc);
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
                    m4 )
                        stuffToCleanInBin=(m4);
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
