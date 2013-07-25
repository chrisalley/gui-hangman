{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UNewPlayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TNewPlayerDialog = class(TForm)
    FirstNameLabeledEdit: TLabeledEdit;
    LastNameLabeledEdit: TLabeledEdit;
    OKButton: TButton;
    Cancel: TButton;
    WelcomeLabel: TLabel;
    procedure FirstNameLabeledEditChange(Sender: TObject);
    procedure LastNameLabeledEditChange(Sender: TObject);
    procedure LastNameLabeledEditEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TNewPlayerDialog.FirstNameLabeledEditChange(Sender: TObject);
begin
  Self.LastNameLabeledEditChange(Self);
end;

procedure TNewPlayerDialog.LastNameLabeledEditChange(Sender: TObject);
{ Disables the New Player form's OK Button unless the strings in
  FirstNameLabeledEdit and LastNameLabeledEdit consist of only letters and
  are not empty. }
var
  Count: integer;
begin
  if (Self.FirstNameLabeledEdit.Text = '') or
    (Self.LastNameLabeledEdit.Text = '') then
    Self.OKButton.Enabled := False
  else
  begin
    Self.OKButton.Enabled := True;
    for Count := 1 to length(Self.FirstNameLabeledEdit.Text) do
    begin
      if not(Upcase(Self.FirstNameLabeledEdit.Text[Count]) in ['A'..'Z']) then
        Self.OKButton.Enabled := False;
    end;
    for Count := 1 to length(Self.LastNameLabeledEdit.Text) do
    begin
      if not(Upcase(Self.LastNameLabeledEdit.Text[Count]) in ['A'..'Z']) then
        Self.OKButton.Enabled := False;
    end;
  end;
end;

procedure TNewPlayerDialog.LastNameLabeledEditEnter(Sender: TObject);
{ Makes the OK button the default component for the form, after Enter is pushed
  on the last Edit box. }
begin
  Self.OKButton.Default := True;
end;

end.
