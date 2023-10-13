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

unit FormExtOpts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFrmExtOpts }

  TFrmExtOpts = class(TForm)
    BtnOk: TButton;
    BtnCancel: TButton;
    Label1: TLabel;
    MemoExtensions: TMemo;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmExtOpts: TFrmExtOpts;

implementation

{$R *.lfm}

{ TFrmExtOpts }

procedure TFrmExtOpts.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmExtOpts.BtnOkClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i := 0 to MemoExtensions.Lines.Count - 1 do
  begin
    s := MemoExtensions.Lines[i];
    if (length(s) >= 1) and (s[1] <> '.') then
    begin
      s := '.' + s;
      MemoExtensions.Lines[i] := s;
    end;
    if s = '' then
      MemoExtensions.Lines.Delete(i);
  end;
end;

procedure TFrmExtOpts.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key = #27 then
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

end.

