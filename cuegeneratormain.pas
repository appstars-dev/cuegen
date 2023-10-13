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

unit CueGeneratorMain;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Forms, StdCtrls, Spin, ActnList, XMLPropStorage, Menus, StdActns,
  CueGen, formextopts, Controls, ComCtrls, Buttons, SynEdit, About,
  Classes, CueGenHighlighter, Dialogs;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    actGenerate: TAction;
    actExtOpts: TAction;
    actAbout: TAction;
    ActionList1: TActionList;
    ApplicationProperties1: TApplicationProperties;
    ChkDataTrack: TCheckBox;
    ComboExtensions: TComboBox;
    EditCopy1: TEditCopy;
    EditCut1: TEditCut;
    EditDelete1: TEditDelete;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    ImageList1: TImageList;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MnuDataTrackMode: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MnuMode22336: TMenuItem;
    MnuMode22352: TMenuItem;
    MnuMode12352: TMenuItem;
    MnuAudioModes: TMenuItem;
    MnuRedBook: TMenuItem;
    MnuCompressedFiles: TMenuItem;
    MenuItem5: TMenuItem;
    MemoCue: TSynEdit;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PopupMenu1: TPopupMenu;
    SpeedButton1: TSpeedButton;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    TxtDataTrackName: TEdit;
    FileExit1: TFileExit;
    Label5: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    TxtFileName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpnStartTrack: TSpinEdit;
    SpnEndTrack: TSpinEdit;
    XMLPropStorage1: TXMLPropStorage;
    FCueGenSynHL: TCueGenSynHl;
    procedure actAboutExecute(Sender: TObject);
    procedure actExtOptsExecute(Sender: TObject);
    procedure actGenerateExecute(Sender: TObject);
    procedure ApplicationProperties1Idle(Sender: TObject; var {%H-}Done: boolean);
    procedure FileOpen1Accept(Sender: TObject);
    procedure FileSaveAs1Accept(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure HandleAudioOptions(Sender: TObject);
    procedure HandleTrackModesMenu(Sender: TObject);
  private
    FFileCount: integer;
    FCurrentFileName: string;
    FAudioMode: TAudioModes;
    FCanClose: boolean;
  public
    { Public Declarations}
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.lfm}

{ TFrmMain }

procedure TFrmMain.HandleTrackModesMenu(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MnuDataTrackMode.Count - 1 do
    MnuDataTrackMode.Items[i].Checked := False;
  (Sender as TMenuItem).Checked := True;
end;

procedure TFrmMain.actGenerateExecute(Sender: TObject);
var
  CueGen: TCueGen;
  i: integer;
begin
  MemoCue.Lines.Clear;
  CueGen := TCueGen.Create;
  try
    CueGen.StartTrack := SpnStartTrack.Value;
    CueGen.EndTrack := SpnEndTrack.Value;
    CueGen.FileName := TxtFileName.Text;
    CueGen.Extension := ComboExtensions.Text;
    CueGen.UseDataTrack := ChkDataTrack.Checked;
    CueGen.DataTrackName := TxtDataTrackName.Text;
    CueGen.AudioMode := FAudioMode;
    for i := 0 to MnuDataTrackMode.Count - 1 do
    begin
      if MnuDataTrackMode.Items[i].Checked then
      begin
        CueGen.TrackMode := TTrackModes(i);
        break;
      end;
    end;
    CueGen.GenerateCueFile;
    MemoCue.Lines := CueGen.CueStrings;
    MemoCue.Modified := True;
  finally
    CueGen.Free;
  end;
end;

procedure TFrmMain.ApplicationProperties1Idle(Sender: TObject; var Done: boolean);
begin
  StatusBar1.Panels[0].Text :=
    Format('Ln: %.2D  Col: %.2D', [MemoCue.CaretY, MemoCue.CaretX]);
  FCanClose := not MemoCue.Modified;
  if (MemoCue.Modified) and (StatusBar1.Panels[1].Text <> '*') then
    StatusBar1.Panels[1].Text := '*';
  if (MemoCue.Modified = False) and (StatusBar1.Panels[1].Text <> '') then
    StatusBar1.Panels[1].Text := '';
end;

procedure TFrmMain.FileOpen1Accept(Sender: TObject);
begin
  TxtDataTrackName.Text := ExtractFileName(FileOpen1.Dialog.FileName);
end;

procedure TFrmMain.FileSaveAs1Accept(Sender: TObject);
var
  FileName: string;
begin
  FileName := FileSaveAs1.Dialog.FileName;
  MemoCue.Lines.SaveToFile(FileName);
  MemoCue.Modified := False;
  FCanClose := True;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  MsgResult: integer;
begin
  if FCanClose = False then
  begin
    MsgResult := MessageDlg('You have unsaved changes', 'Save modified cue file?',
      mtConfirmation, [mbYes, mbNo, mbAbort], 0);
  end;
  case MsgResult of
    mrYes: FileSaveAs1.Execute;
    mrNo: FCanClose := True;
    mrAbort: FCanClose := False;
  end;
  CanClose := FCanClose;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  FCanClose := True;
  FFileCount := 1;
  Application.Title := 'Cue Sheet Generator - noname1.cue';
  FrmMain.Caption := 'Cue Sheet Generator - noname1.cue';
  FCurrentFileName := 'noname1.cue';
  FileSaveAs1.Dialog.FileName := 'noname1.cue';
  FAudioMode := amCompressed;
  FrmMain.Position := poDesigned;
  FCueGenSynHl := TCueGenSynHl.Create(self);
  MemoCue.Highlighter := FCueGenSynHl;
end;

procedure TFrmMain.actExtOptsExecute(Sender: TObject);
var
  FrmExtOpts: TFrmExtOpts;
begin
  FrmExtOpts := TFrmExtOpts.Create(nil);
  try
    FrmExtOpts.MemoExtensions.Lines := ComboExtensions.Items;
    if FrmExtOpts.ShowModal = mrOk then
    begin
      ComboExtensions.Items.Clear;
      ComboExtensions.Items := FrmExtOpts.MemoExtensions.Lines;
    end;
  finally
    FrmExtOpts.Release;
  end;
end;

procedure TFrmMain.actAboutExecute(Sender: TObject);
var
  FrmAbout: TFrmAbout;
begin
  FrmAbout := TFrmAbout.Create(nil);
  try
    FrmAbout.ShowModal;
  finally
    FrmAbout.Release;
  end;
end;

procedure TFrmMain.HandleAudioOptions(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MnuAudioModes.Count - 1 do
    MnuAudioModes.Items[i].Checked := False;
  (Sender as TMenuItem).Checked := True;
  case (Sender as TMenuItem).Name of
    'MnuCompressedFiles': FAudioMode := amCompressed;
    'MnuRedBook': FAudioMode := amRedBook;
  end;
end;

end.
