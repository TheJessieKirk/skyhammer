#! /bin/bash

# prepdata.sh - prepare the datasets for the bookshelf package
# which creates a bookshelf image from a BiBTeX file.
#
# Peter Flynn, 2020-05-14 <peter@silmaril.ie>
#
# Dependencies: the standard UNIX/GNU Linux text utilities
# and builtins : cat, grep, awk, mkdir, rm, echo, sed, sort
# PLUS the font-cache program fc-list (1) and the TeX utility
# kpsewhich (1).
#
# Note that if you have not updated your font-cach to take
# account of fonts added since installation (eg fonts
# distributed with TeX which are not installed in the system
# fonts directories) then you should edit /etc/fonts/conf.avail
# to add the directories where they are installed to (eg)
# 09-texlive.conf and then alias that file to conf.d, and then
# run fc-cache as root.

if [ -z "$1" ]; then
    echo You must give the full name of your BiBTeX file
    exit 1
else
    if [ ! -s "$1" ]; then
echo I can\'t find the file "$1" anywhere here
exit 1
    else
BIBFILE="$1"
    fi
fi

###########################################################
#
# Make a list of all the entries in the bib file. This is
# in effect the 'driver' which creates each book spine image
# and the entries.tex file is \input in the test.tex file.

cat "$BIBFILE" |\
    grep '^@' |\
    grep -viE '(@Preamble|@String)' |\
    awk -F\{ '{print $2}' |\
    awk -F, '{print "\\makebook{" $1 "}%"}' >entries.tex

echo `cat entries.tex|wc -l` bibliographic entries

##########################################################
#
# Make a list of all the fonts available: this omits PFB
# fonts (Postscript Type 1) and deduplicates the entries
# on the first token of their name. CRITICALLY it then
# applies a (typically) VERY LONG list of disallowed font
# names so as to exclude non-text fonts: math, symbols,
# display fonts, bogus and broken fonts, and fonts not
# providing the Latin alphabet.
#
# Note that the current list includes many names which
# ought not be there, because problems were encountered
# when using them, especially as they returned a value
# for the title length of 0.0pt, which is clearly a bug.

mkdir -p fontsel
rm -f fontsel/*

if [[ "$OSTYPE" =~ ^darwin ]]; then

    system_profiler SPFontsDataType 2>/dev/null |\
        awk -F: '/^[ ]{4}[A-Za-z0-9\;\ ]*.[ot]tf*:$/ {font=substr($1,5)} \
                 /^[ ]{10}Family:/ {if(font!="") \
                 {print substr($2,2);font=""}}' |\
        grep -Ev '^[\.\ ]' |\
        sort |\
        uniq |\
        grep -Evi '(Bitmap|Emoji|Dingbats|Jazz|STIX|dings|Symbol|Numeric|DIN|Ornament|OCR|CJK|Awesome|Dummy|Math)' |\
        awk '{file="fontsel/" NR ".tex";\
              print "\\newfontface{\\SILmfont}{" $0 "}" >file;
              print "\\def\\SILmfontname{" $0 "}" >file;
              close(file)} \
         END {print "\\setcounter{SIL@maxfont}{" NR "}"}' >pickfont.tex

elif [[ "$OSTYPE" =~ ^linux ]]; then

    fc-list |\
        grep -v '\.[ot]tf' |\
        grep -Ev '(fontsite|bitstrea)' |\
        awk -F: '{print substr($2,2)}' |\
        awk -F, '{print $1}' |\
        awk '{print $1 "," length($0) "," $0}' |\
        sort -t, -k 1,1 -k 2n |\
        awk -F, '{if($1!=last)print $3;last=$1}' |\
        grep -Evi '(Bitmap|Emoji|Dingbats|Jazz|STIX|dings|Symbol|Numeric|DIN|Ornament|OCR|CJK|Awesome|Dummy|Math)' |\
        awk '{file="fontsel/" NR ".tex";\
              print "\\newfontface{\\SILmfont}{" $0 "}" >file;
              print "\\def\\SILmfontname{" $0 "}" >file;
              close(file)} \
         END {print "\\setcounter{SIL@maxfont}{" NR "}"}' >pickfont.tex

fi

echo `ls -1 fontsel|wc -l` fonts

###########################################################
#
# Make a list of the colour selection from the SVG palette
# of the xcolor LaTeX package, with calculation of the
# brightness/darkness value according to
# https://www.nbdtech.com/Blog/archive/2008/04/27/Calculating-the-Perceived-Brightness-of-a-Color.aspx

PALETTE=`kpsewhich svgnam.def`
cat $PALETTE |\
    grep '^[A-Z][A-Za-z]*,[\.0-9][0-9]*,[\.0-9][0-9]*,[\.0-9][0-9]*' |\
    awk -F\; '{print $1}' |\
    awk -F, '{r=$2;g=$3;b=$4} \
      {brightness=sqrt((0.241*r*r)+(0.691*g*g)+(0.068*b*b))} \
      {print $1,r,g,b,brightness}' >svgnam.csv
    cat svgnam.csv |\
    awk 'BEGIN {print "\\newcommand{\\SIL@svgcolname}[1]{\\ifcase#1 "} \
               {print $1 "\\or"} END {print "Black\\fi}\n"}' >svgnam.tex
    cat svgnam.csv |\
    awk 'BEGIN {print "\\newcommand{\\SIL@svgcolval}[1]{\\ifcase#1 "} \
               {print $5 "\\or"} END {print ".666666666\\fi}\n"}' >>svgnam.tex
    cat svgnam.csv | wc -l |\
    awk '{print "\\setcounter{SIL@maxcolno}{" $1 "}"}' >>svgnam.tex

echo `cat svgnam.csv|wc -l` colors

exit 0


