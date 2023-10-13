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

unit CueGenHighlighter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, SynEditHighlighter, StrUtils;

type

  TCueGenSynHl = class(TSynCustomHighlighter)
  private
    FCueElementAttr: TSynHighlighterAttributes;
    FIdentifierAttr: TSynHighlighterAttributes;
    FRemElementAttr: TSynHighlighterAttributes;
    FFileElementAttr: TSynHighlighterAttributes;
    FStructureElementAttr: TSynHighlighterAttributes;
    FTrackTypeElementAttr: TSynHighlighterAttributes;
    FStructureLine: integer;
    FRemLine: integer;
    procedure SetIdentifierAttr(Value: TSynHighlighterAttributes);
    procedure SetCueElementAttr(Value: TSynHighlighterAttributes);
    procedure SetRemElementAttr(Value: TSynHighlighterAttributes);
    procedure SetFileElementAttr(Value: TSynHighlighterAttributes);
    procedure SetStructureElementAttr(Value: TSynHighlighterAttributes);
    procedure SetTrackTypeElementAttr(Value: TSynHighlighterAttributes);
  protected
    FTokenPos, FTokenEnd: integer;
    FLineText: string;
  public
    procedure SetLine(const NewValue: string; LineNumber: integer); override;
    procedure Next; override;
    function GetEol: boolean; override;
    procedure GetTokenEx(out TokenStart: PChar; out TokenLength: integer); override;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetToken: string; override;
    function GetTokenPos: integer; override;
    function GetTokenKind: integer; override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes; override;
    constructor Create(TheOwner: TComponent); override;
  published
    property CueElementAttr: TSynHighlighterAttributes
      read FCueElementAttr write SetCueElementAttr;
    property IdentifierAttr: TSynHighlighterAttributes
      read FIdentifierAttr write SetIdentifierAttr;
    property RemElementAttr: TSynHighlighterAttributes
      read FRemElementAttr write SetRemElementAttr;
    property FileElementAttr: TSynHighlighterAttributes
      read FFileElementAttr write SetFileElementAttr;
    property StructureElementAttr: TSynHighlighterAttributes
      read FStructureElementAttr write SetStructureElementAttr;
    property TrackTypeElementAttr: TSynHighlighterAttributes
      read FTrackTypeElementAttr write SetTrackTypeElementAttr;
  end;

implementation

constructor TCueGenSynHl.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  FCueElementAttr := TSynHighlighterAttributes.Create('cueelement', 'cueelement');
  AddAttribute(FCueElementAttr);
  FCueElementAttr.Foreground := clRed;
  FCueElementAttr.Style := [fsBold];
  FRemElementAttr := TSynHighlighterAttributes.Create('remelement', 'remelement');
  AddAttribute(FRemElementAttr);
  FRemElementAttr.Foreground := clBlue;
  FFileElementAttr := TSynHighlighterAttributes.Create('fileelement', 'fileelement');
  AddAttribute(FFileElementAttr);
  FFileElementAttr.Foreground := clBlack;
  FFileElementAttr.Style := [fsItalic, fsBold];
  FStructureElementAttr := TSynHighlighterAttributes.Create('structureelement',
    'structureelement');
  AddAttribute(FStructureElementAttr);
  FStructureElementAttr.Foreground := clBlack;
  FStructureElementAttr.Style := [fsBold];
  FTrackTypeElementAttr := TSynHighlighterAttributes.Create('tracktypeelement',
    'tracktypeelement');
  AddAttribute(FTrackTypeElementAttr);
  FTrackTypeElementAttr.Foreground := clMaroon;
  FTrackTypeElementAttr.Style := [fsBold];
  FIdentifierAttr := TSynHighlighterAttributes.Create('ident', 'ident');
  AddAttribute(FIdentifierAttr);
end;

procedure TCueGenSynHl.SetLine(const NewValue: string; LineNumber: integer);
begin
  inherited;
  FLineText := NewValue;
  // Next will start at "FTokenEnd", so set this to 1
  FTokenEnd := 1;
  Next;
end;

procedure TCueGenSynHl.Next;
var
  l: integer;
begin
  // FTokenEnd should be at the start of the next Token (which is the Token we want)
  FTokenPos := FTokenEnd;
  // assume empty, will only happen for EOL
  FTokenEnd := FTokenPos;

  // Scan forward
  // FTokenEnd will be set 1 after the last char. That is:
  // - The first char of the next token
  // - or past the end of line (which allows GetEOL to work)

  l := Length(FLineText);
  if FTokenPos > l then
    // At line end
    exit
  else
  if FLineText[FTokenEnd] in [#9, ' '] then
    // At Space? Find end of spaces
    while (FTokenEnd <= l) and (FLineText[FTokenEnd] in [#0..#32]) do
      Inc(FTokenEnd)
  else
    // At None-Space? Find end of None-spaces
    while (FTokenEnd <= l) and not (FLineText[FTokenEnd] in [#9, ' ']) do
      Inc(FTokenEnd);
end;

function TCueGenSynHl.GetEol: boolean;
begin
  Result := FTokenPos > Length(FLineText);
end;

procedure TCueGenSynHl.GetTokenEx(out TokenStart: PChar; out TokenLength: integer);
begin
  TokenStart := @FLineText[FTokenPos];
  TokenLength := FTokenEnd - FTokenPos;
end;

function TCueGenSynHl.GetTokenAttribute: TSynHighlighterAttributes;
var
  Str: string;
begin
  //Str := LowerCase(copy(FLineText, FTokenPos, FTokenEnd - FTokenPos));
  Str := copy(FLineText, FTokenPos, FTokenEnd - FTokenPos);
  // Match the text, specified by FTokenPos and FTokenEnd
  //Actors and scenes need to be on top to bypass the "hasnumbers"
  //FIXME: This logic keeps getting messier, it could probably be improved
  if Str = 'REM' then
  begin
    Result := RemElementAttr;
    FRemLine := Self.LineIndex;
  end
  else if Self.LineIndex = FRemLine then
  begin
    Result := RemElementAttr;
  end
  else
  if ((Str = 'FILE') or (Str = 'AUDIO') or (Str = 'MP3') or (Str = 'BINARY')) and
    (Self.LineIndex <> FStructureLine) then
    Result := CueElementAttr
  else
  if AnsiContainsText(Str, '"') then
    Result := FileElementAttr
  else
  if ((Str = 'TRACK') and not AnsiContainsText(Str, '"')) or (Str = 'INDEX') then
  begin
    Result := TrackTypeElementAttr;
    FStructureLine := Self.LineIndex;
  end
  else
  if Self.LineIndex = FStructureLine then
  begin
    if (AnsiContainsStr(Str, 'MODE')) or (AnsiContainsStr(Str, 'AUDIO')) then
      Result := TrackTypeElementAttr
    else
      Result := StructureElementAttr;
  end
  else
    Result := IdentifierAttr;
end;

function TCueGenSynHl.GetToken: string;
begin
  Result := copy(FLineText, FTokenPos, FTokenEnd - FTokenPos);
end;

function TCueGenSynHl.GetTokenPos: integer;
begin
  Result := FTokenPos - 1;
end;

function TCueGenSynHl.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  // Some default attributes
  case Index of
    SYN_ATTR_IDENTIFIER: Result := FIdentifierAttr;
    else
      Result := nil;
  end;
end;

function TCueGenSynHl.GetTokenKind: integer;
var
  a: TSynHighlighterAttributes;
begin
  // Map Attribute into a unique number
  a := GetTokenAttribute;
  Result := 0;
  if a = FCueElementAttr then
    Result := 1;
  if a = FIdentifierAttr then
    Result := 2;
  if a = FRemElementAttr then
    Result := 3;
  if a = FFileElementAttr then
    Result := 4;
  if a = FStructureElementAttr then
    Result := 5;
  if a = FTrackTypeElementAttr then
    Result := 6;
end;

procedure TCueGenSynHl.SetIdentifierAttr(Value: TSynHighlighterAttributes);
begin
  FIdentifierAttr.Assign(Value);
end;

procedure TCueGenSynHl.SetCueElementAttr(Value: TSynHighlighterAttributes);
begin
  FCueElementAttr.Assign(Value);
end;

procedure TCueGenSynHl.SetRemElementAttr(Value: TSynHighlighterAttributes);
begin
  FRemElementAttr.Assign(Value);
end;

procedure TCueGenSynHl.SetFileElementAttr(Value: TSynHighlighterAttributes);
begin
  FFileElementAttr.Assign(Value);
end;

procedure TCueGenSynHl.SetStructureElementAttr(Value: TSynHighlighterAttributes);
begin
  FStructureElementAttr.Assign(Value);
end;

procedure TCueGenSynHl.SetTrackTypeElementAttr(Value: TSynHighlighterAttributes);
begin
  FTrackTypeElementAttr.Assign(Value);
end;

end.
