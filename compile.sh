#!/bin/bash

OLD_PATH=$PATH;

echo "Skyhammer";
echo "I am not currently very smart, so cannot do much."

echo "Checking directories...";
if [ ! -d "compile_this" ]; then
  echo "compile_this does not exist. Skyhammer will create it.";
  mkdir compile_this;
fi;
if [ ! -d "compiled_that" ]; then
  echo "compiled_that does not exist. Skyhammer will create it.";
  mkdir compiled_that;
fi;
if [ ! -d "compiled_that/bin" ]; then
  echo "compiled_that/bin does not exist. Skyhammer will create it.";
  mkdir compiled_that/bin;
fi;
if [ -z "$( ls -A 'compile_this' )" ]; then
  echo "compile_this is empty, so there's nothing to do.";
  exit;
fi;

echo "Compiling main.cxx...";
export PATH=/opt/skyhammer/x86_64-w64-mingw32/bin:$OLD_PATH;
cd compiled_that;
x86_64-w64-mingw32-g++ -m64 ../compile_this/main.cxx -o bin/main.exe;
x86_64-w64-mingw32-strip bin/main.exe;
