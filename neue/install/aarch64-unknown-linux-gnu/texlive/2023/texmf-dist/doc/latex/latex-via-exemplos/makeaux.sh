#!/bin/bash

# To create auxiliar file for latex-via-exemplos (only for development)

# compile auxiliar files
pdflatex latex-via-exemplos-fig
pdflatex latex-via-exemplos-poster
pdflatex latex-via-exemplos-slides
pdflatex latex-via-exemplos-slides
pdflatex latex-via-exemplos-certificado
pdflatex latex-via-exemplos-cracha
pdflatex latex-via-exemplos-folder
pdflatex latex-via-exemplos-todonotes
pdflatex latex-via-exemplos-todonotes

# clean up
rm *.aux
rm *.bbl
rm *.blg
rm *.idx
rm *.ilg
rm *.ind
rm *.log
rm *.lol
rm *.out
rm *.synctex.gz
rm *.tmp
rm *.toc

rm *.nav
rm *.snm
rm *.vrb

rm *.tdo

# rm *.csv

#end

