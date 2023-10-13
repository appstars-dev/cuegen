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

MakeSVNDMG()
{
	echo "Creating SVN snapshot DMG"
	# getting revision number of SVN to put that in the diskimage title
	REVISION=" r$(/usr/bin/svnversion)"
	hdiutil create -ov -format UDZO -imagekey zlib-level=9 -fs HFS+ -srcfolder diskimage -volname "Cue Sheet Generator SVN snapshot$REVISION" CueGenerator-Snapshot.dmg	
}

MakeReleaseDMG()
{
	echo "Creating release DMG"
	# get version number from source
	VERS=$(grep -i "programmajor" cuegenconstants.pas | grep -Eo [0-9]+)
	VERS+=.
	VERS+=$(grep -i "programminor" cuegenconstants.pas | grep -Eo [0-9]+)
	VERS+=.
	VERS+=$(grep -i "programrevision" cuegenconstants.pas | grep -Eo [0-9]+)
	hdiutil create -ov -format UDZO -imagekey zlib-level=9 -fs HFS+ -srcfolder diskimage -volname "Cue Sheet Generator $VERS" CueGenerator.dmg
}

# make the disk image
echo "Creating DMG disk image"
mkdir diskimage
CpMac -r  ./bin/release/CueGenerator.app ./diskimage
cp ./COPYING.txt ./diskimage/License
cp ./readme.txt ./diskimage/ReadMe
SetFile -t ttro -c ttxt ./diskimage/License
SetFile -t ttro -c ttxt ./diskimage/ReadMe
echo "Querying release status"
IsSvn=$(grep 'SVN' cuegenconstants.pas -m 1 | grep -i false -q)

if [[ $IsSvn -gt 0 ]]; then
	MakeSVNDMG
else
	MakeReleaseDMG
fi

#clean up - removing the disk image folder, we now have the diskimage
	rm -r diskimage
