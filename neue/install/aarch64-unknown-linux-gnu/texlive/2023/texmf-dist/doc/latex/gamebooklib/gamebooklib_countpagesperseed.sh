#!/bin/bash
# Copyright (C) 2021 by Robert J Lee
# 
# This file may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either
# version 1.3 of this license or (at your option) any later
# version. The latest version of this license is in:
# 
# http://www.latex-project.org/lppl.txt
# 
# and version 1.3 or later is part of all distributions of
# LaTeX version 2005/12/01 or later.
#
# A utility script to find the best seed number for a particular gamebook
#
# Prerequisites: bash, tee, tail, egrep, pdflatex, perl with Sort::Naturally
#
# To install Sort::Naturally, you can simply type "cpan install Sort::Naturally"
# assuming Perl is installed.
#
# First keep a backup of your .tex file, just in case.
#
# Next, ensure that you have a line containing "seed=<numerals>,"
# (including the comma) in your .tex file.
#
# The first occurence will be replaced with a sequence of numbers in turn,
# the PDF regenerated, and the number of output pages with each number reported
# on, first by seed number, then by reversed number of pages (smallest last).
# It's then up to you to choose the seed number appropriate for your work.
#
# Use this script with caution as it will edit your source file.
#
# The script may be placed on the system path or copied to the working directory.

file=${1}

if [[ -z $file ]]; then
    echo "Usage: $0 <file>.tex"
    exit 1
fi

egrep -q "seed=[0-9]+," $file || (
    echo "$1 Does not contain \\usepackage[seed=123,quiet]{lcg}"
    exit 2
);

pdf="pdflatex -interaction=nonstopmode $file"

cp $file $file~ || exit 3

# FOR seed in (1..1000)
for seed in $(perl -e 'for (1..1000){print "$_\n"}'); do
    # edit $file and replace any seed values
    perl -i -pe "s/seed=[0-9]*,/seed=$seed,/" $file
    # Run it through LaTeX, stripping out the line of output containing the number of pages, and then
    # add the seed value
    echo $($pdf 2>&1 | grep 'pages' | tail -n 1 | perl -pe "chomp") "; seed=$seed"; 
done | \
    # report on the output as we get it, and report on the sorted pages at the end.
    # (sort numerically by first numeral on lines with identical prefix)
    perl -MSort::Naturally -pe \
	 '{push @lines, $_}; END{print "SORTED:"; print reverse nsort(@lines)}'
