#!/bin/bash

xelatex pascaltriangle.tex &&\
makeindex -s gind.ist -o pascaltriangle.ind pascaltriangle.idx &&\
makeindex -s gglo.ist -o pascaltriangle.gls pascaltriangle.glo &&\
xelatex pascaltriangle.tex &&\
xelatex pascaltriangle.tex &&\
xelatex pascaltriangle.tex
