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

CompilePPC()
{
	echo "Building cuegenerator for Power PC"
	lazbuild --bm="release os x powerpc" cuegenerator.lpi
	if [ $? != 0 ];
	then
		PrintError		
	else
		echo "Done building cuegenerator for Power PC"
	fi	
}

CompileIntel()
{
	echo "Building CueGenerator for Intel"
	lazbuild --bm="release os x i386" cuegenerator.lpi
	if [ $? != 0 ];
	then
		PrintError		
	else
		echo "Done building cuegenerator for Intel"
	fi			
}

PrintError()
{
	echo "Error building cuegenerator"
	echo "Something went really, really wrong. Check the code for errors."
	exit
}

CodeSign()
{
	# codesign the app - only works if you have a valid Dev ID
	echo "Signing code"
	codesign --force --sign "Developer ID Application" ./bin/release/CueGenerator.app
}	
	
echo "Preparing to build Cue Sheet Generator"
echo "This script creates binary files, strips them"
echo "and creates a bundle"
echo "Please select the package to build"
echo "[B] Power PC and Intel"
echo "[P] Power PC"
echo "[I] Intel"
while true; do
	read -p "Please enter your choice [B,P,I]" _choice
	case $_choice in
		[Bb]* ) CompilePPC; CompileIntel; break;;
		[Pp]* ) CompilePPC; break;;
		[Ii]* ) CompileIntel; break;;
		* ) echo "Invalid option, please pick a valid one";;
	esac
done
sh create_osx_bundle.sh
echo "Codesign?"
echo "[Y]es"
echo "[N]o"
while true; do
	read -p "Please enter your choice [Y,N]" _choicesign
	case $_choicesign in
		[Yy]* ) CodeSign; break;;
		[Nn]* ) break;;		
		* ) echo "Invalid option, please pick a valid one";;
	esac
done
echo "Create disk image?"
echo "[Y]es"
echo "[N]o"
while true; do
	read -p "Please enter your choice [Y,N]" _choicedmg
	case $_choicedmg in
		[Yy]* ) sh createdmg.sh; break;;
		[Nn]* ) break;;		
		* ) echo "Invalid option, please pick a valid one";;
	esac
done