#!/bin/sh
 
#for i in default sidebar ; do (
for i in default infolines sidebar tree; do (
      lualatex \\def\\outername\{"$i"\}\\def\\colorname\{"cormorant"\}\\input example.tex;
      mv example.pdf cormorantexample"$i".pdf; 
   )
done
