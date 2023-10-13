
# Cue Sheet Generator
Copyright (C) 2013, 2014
Cue Sheet Generator Developement Team

A simple program to automate the process of creating cue sheets for CD images with audio as separate tracks.

## Installing


## Windows
 The program doesn't require additional libraries or registry entries, therefore, you just unzip it somewhere you like and double click to run it.
 
## OS X

An official binary is provided in the SourceForge repository, keep in mind the binary is for Intel Macs only.

## Linux

There are no provided binaries at the moment, but the program will compile "out of the box" provided you have a working Lazarus install (1.2 RC2 or later); after
compilation your binary will be placed wherever you stored the source in the bin/release or bin/debug subfolder depending on the build mode you chose. 
If you want to contribute binaries for the platforms, please do :), an advantage of Lazarus is that compiled binaries will work under most Linux installations, albeit they are CPU dependant (e.g: an Intel binary won't work for ARM).

## Program use

Using the program is easy, just fill in the necessary data (the number of the first and last audio tracks) and, optionally, check the "Use Data Track" box
and use the open file button text box to locate your binary (or type in a name) to create a complete cue sheet for a mixed mode CD with compressed audio tracks (or uncompressed .wav audio tracks, if you desire).
You can add and remove audio file extensions under the "Options" menu, the program will remember your entries.
You can save your cue sheet clicking the "Save As..." button or by copying and pasting into a text file.

## FAQ

1.-Your program doesn't work, when I try to mount the cue file MSCDEX barfs or I get invalid image!

That is not a question; anyway, first and foremost, your program must support compressed audio (unless doing an uncompressed cue sheet with separate audio tracks); your files must be properly named (according to whatever name you set in the program), and they must be present in the same folder your cue sheet resides or in the correct folder it points to, if the above conditions are met, try changing the data track mode under Options -> Data Track Mode.

## Version History
1.2.2 Dominus is now part of the development team; the program can now be used as a general purpose cue sheet editor with syntax highlighting for the most common 		elements; improvements on general program presentation; added the ability to create separate track cue sheets for uncompressed audio as well; added different modes for binary files; minor bug fixes. An OS X official binary is now available.
1.1.2 Added a Readme, updated some license text.
1.1.1 Initial Release

Compressed Cue Sheet Generator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Compressed Cue Sheet Generator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

See LICENSE for a copy of the license.