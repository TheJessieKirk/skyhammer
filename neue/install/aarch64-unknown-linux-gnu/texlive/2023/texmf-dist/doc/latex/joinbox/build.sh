#!/bin/bash

xelatex joinbox.tex &&\
makeindex -s gind.ist -o joinbox.ind joinbox.idx &&\
makeindex -s gglo.ist -o joinbox.gls joinbox.glo &&\
xelatex joinbox.tex &&\
xelatex joinbox.tex &&\
xelatex joinbox.tex
