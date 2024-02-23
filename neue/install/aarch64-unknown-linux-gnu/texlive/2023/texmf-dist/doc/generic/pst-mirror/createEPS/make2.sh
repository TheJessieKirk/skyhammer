#latex xa.tex && rm -f xa.log xa.aux
#dvips -E xa.dvi -o xa.eps
#pstoedit -dt -xscale "-1" -xshift -150 -f ps xa.eps xb.eps
pstoedit -dt -xscale "-1" -xshift -150 -f ps $1.eps $1-b.eps
scripts/filtre.pl 1 $1-b.eps
pstoedit -f ps $1-b.eps $1-c.eps
scripts/filtre.pl 2 $1-c.eps
#./test.sh
#latex xxx && dvips xxx && ps2pdf xxx.ps
rm -f *.ps *.dvi