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
#    If not, see <http://www.gnu.org/licenses/>.                          

function ExitOnError
{
	param ($ver)
	Write-Host -foregroundcolor Red "Error building CueGenerator"
	Write-Host -foregroundcolor Red "Something went really, really wrong check the code for errors."
	Exit
}

function Buildx32
{
	param ($lazbuildpath)
	Write-Host -nonewline "Building "
	Write-Host -nonewline -foregroundcolor red "CueGenerator"
	Write-Host "."		
	$lazproc = (Start-Process -FilePath ${lazbuildpath} -ArgumentList '--bm="release generic" cuegenerator.lpi' -wait -nonewwindow -passthru)	
	if (!($lazproc.ExitCode -eq 0))
	{
		ExitOnError("x32")
	}	
}

Write-Host -nonewline "Preparing to build "
Write-Host -nonewline -foregroundcolor Red "Cue Sheet Generator"
Write-Host "."
Write-Host -nonewline "Exit with "
Write-Host -foregroundcolor Cyan "Ctrl-C"
do 
{
	Write-Host -nonewline "Please input Lazarus path ("
	Write-Host -nonewline -foregroundcolor Yellow "c:\lazarus"
	Write-Host -nonewline "): "
	$path = Read-Host
	if ($path -eq "")
	{
		$path = "c:\lazarus"
	}
	$buildpath = $path + "\lazbuild.exe"
	$found = Test-Path($buildpath)
	if ($found -eq 0)
	{
		Write-Host -nonewline "Unable to find lazbuild.exe in '"
		Write-Host -nonewline $path
		Write-Host "' please try again"
	}
}
while($found -eq 0)
Buildx32 $buildpath