#!/bin/bash

xelatex chinesechess.tex &&\
makeindex -s gind.ist -o chinesechess.ind chinesechess.idx &&\
makeindex -s gglo.ist -o chinesechess.gls chinesechess.glo &&\
xelatex chinesechess.tex &&\
xelatex chinesechess.tex &&\
xelatex chinesechess.tex
