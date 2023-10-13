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

unit About;

{$mode objfpc}{$H+}

interface

uses
  Forms, StdCtrls, ExtCtrls, LCLIntf, SysUtils, CueGenConstants, LCLVersion;

type

  { TFrmAbout }

  TFrmAbout = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.lfm}

{ TFrmAbout }

procedure TFrmAbout.FormShow(Sender: TObject);
var
  LameDate: string = {$I %DATE%};
begin
  Label2.Caption := 'Built on: ' + LameDate[9] + LameDate[10] + '/' +
    LameDate[6] + LameDate[7] + '/' + LameDate[1] + LameDate[2] +
    LameDate[3] + LameDate[4];
  Label3.Caption := 'FPC version: ' + IntToStr(FPC_VERSION) + '.' +
    IntToStr(FPC_RELEASE) + '.' + IntToStr(FPC_PATCH);
  Label4.Caption := 'Lazarus version: ' + lcl_version;
  Label1.Caption := ProgramName + ' ' + GetProgramVersion;
  Label1.Left := (Self.Width div 2) - (Label1.Width div 2);
  Memo1.Lines.Add(ProgramName + ' ' + GetProgramVersion);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Copyright (C) 2013, 2014');
  Memo1.Lines.Add('Cue Sheet Generator Developement Team.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('The Team');
  Memo1.Lines.Add('Bloodbat / La Serpiente y la Rosa Producciones.');
  Memo1.Lines.Add('Dominus');
  Memo1.Lines.Add('All Rights Reserved.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('CD image originally by Decosigner');
  Memo1.Lines.Add('Sheet image originally by Ousia');
  Memo1.Lines.Add('Images originally from http://openclipart.org/');
  Memo1.Lines.Add('Application icons from Tiicon http://projects.ff22.de/tiicon/');
  Memo1.Lines.Add('');
  Memo1.Lines.Add(
    'Cue Sheet Generator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add(
    'Cue Sheet Generator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('See COPYING.txt for a copy of the license.');
end;

procedure TFrmAbout.Image2Click(Sender: TObject);
begin
  OpenUrl('https://sourceforge.net/projects/cuegen/');
end;

procedure TFrmAbout.Image3Click(Sender: TObject);
begin
  OpenUrl('http://www.gnu.org/licenses/gpl-3.0.html');
end;

end.
