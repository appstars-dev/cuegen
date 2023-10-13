#!/bin/bash
#                      Cue Sheet Generator                              
#
#       Copyright (C) 2013, 2014 Cue Sheet Generator Developement Team.                
#
#   This file is part of Cue Sheet Generator.                       
#
#    Cue Sheet Generator is free software: you can redistribute it
#    and/or modify it under the terms of the GNU General Public License as
#    published by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.                                     
#
#    Cue Sheet Generator is distributed in the hope that it will be
#    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.                       
#
#   You should have received a copy of the GNU General Public License
#   along with Cue Sheet Generator.
#   If not, see <http://www.gnu.org/licenses/>.

echo "Creating OS X Bundle."
if [ -d ./bin/release/CueGenerator.app ]; then
  rm -r ./bin/release/CueGenerator.app
fi
if [ -f ./bin/release/PPC/cuegenerator ] && [ -f ./bin/release/i386/cuegenerator ]; then
  echo "Creating Universal binary bundle"
  echo "Stripping executable files"
  strip -u -r ./bin/release/PPC/cuegenerator
  strip -u -r ./bin/release/i386/cuegenerator
  echo "Stripping done"
  lipo -create ./bin/release/PPC/cuegenerator ./bin/release/i386/cuegenerator -output ./bin/release/cuegenerator
  cp -r ./bin/release/i386/CueGenerator.app ./bin/release/CueGenerator.app
else
  if [ -f ./bin/release/PPC/cuegenerator ]; then
    echo "Creating PPC bundle"
    echo "Stripping executable file"
    strip -u -r ./bin/release/PPC/cuegenerator
    echo "Stripping done"
    cp -r ./bin/release/PPC/CueGenerator.app ./bin/release/CueGenerator.app
    cp ./bin/release/PPC/cuegenerator ./bin/release/cuegenerator
  else
    if [ -f ./bin/release/i386/cuegenerator ]; then
      echo "Creating i386 bundle"
      echo "Stripping executable file"
      strip -u -r ./bin/release/i386/cuegenerator
      echo "Stripping done"
      cp -r ./bin/release/i386/CueGenerator.app ./bin/release/CueGenerator.app
      cp ./bin/release/i386/cuegenerator ./bin/release/cuegenerator
    else
      echo "Can't create a bundle without a binary; compile at least one binary and run me again"
      exit
    fi
  fi
fi
cp -r -f ./bin/release/cuegenerator ./bin/release/cuegenerator.app/Contents/MacOS/cuegenerator
rm ./bin/release/CueGenerator
cp -p ./cuegen.icns ./bin/release/CueGenerator.app/Contents/Resources
cp -r -f ./Info.plist ./bin/release/CueGenerator.app/Contents/Info.plist
echo "Your bundle is done"