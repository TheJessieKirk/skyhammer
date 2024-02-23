#!/bin/sh
 
for i in default infolines sidebar tree; do (
      lualatex \\def\\outername\{"$i"\}\\def\\colorname\{"magpie"\}\\input example.tex;
      mv example.pdf magpieexample"$i".pdf; 
   )
done
