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

echo "Cue Sheet Generator"
echo "Building CueGenerator"
lazbuild --bm="release generic" cuegenerator.lpi
if [ $? != 0 ];
then
	echo "Error building cuegenerator"
	echo "Something went really, really wrong. Check the code for errors."
	exit
else
	echo "Done building cuegenerator"
fi