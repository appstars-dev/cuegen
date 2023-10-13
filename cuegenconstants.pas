{******************************************************************************}
{                      Cue Sheet Generator                                     }
{                                                                              }
{       Copyright (C) 2013, 2014 Cue Sheet Generator Developement Team.        }
{                                                                              }
{   This file is part of Cue Sheet Generator.                                  }
{                                                                              }
{    Cue Sheet Generator is free software: you can redistribute it
    and/or modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation, either version 3 of the License,
    or (at your option) any later version.                                     }
{                                                                              }
{    Cue Sheet Generator is distributed in the hope that it will be
    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.                       }
{                                                                              }
{   You should have received a copy of the GNU General Public License
   along with Cue Sheet Generator.
    If not, see <http://www.gnu.org/licenses/>.                                }
{******************************************************************************}

unit CueGenConstants;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

const

  ProgramName = 'Cue Sheet Generator';
  ProgramMajor = 1;
  ProgramMinor = 2;
  ProgramRevision = 2;
  SVN = False;

function GetProgramVersion: string;

implementation

function GetProgramVersion: string;
var
  Str: string;
begin
  Str := IntToStr(ProgramMajor) + '.' + IntToStr(ProgramMinor) + '.' +
    IntToStr(ProgramRevision);
  if SVN = True then
    {%H-}Str += ' SVN';
  Result := Str;
end;

end.

