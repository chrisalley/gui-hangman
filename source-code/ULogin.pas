{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UNewPlayer, UDataModule;

type
  TLoginForm = class(TForm)
    LoginRadioGroup: TRadioGroup;
    LoginNameLabeledEdit: TLabeledEdit;
    LoginLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LoginNameLabeledEditChange(Sender: TObject);
    procedure LoginNameLabeledEditEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PlayerLogin: string;
  end;

implementation

{$R *.dfm}

procedure TLoginForm.OKButtonClick(Sender: TObject);
{ When the user clicks OK, this method checks to see what radio button is
  selected. Depending on several factors, the method will either log the player
  in, open up the New Player window, or report an error if the inputted login
  in LoginNameLabeledEdit is invalid. }
var
  NewPlayerDialog: TNewPlayerDialog;
begin

  if Self.LoginRadioGroup.ItemIndex = 0 then
  begin
    if HangmanDataModule.CheckIfLoginExistsInDatabase(
      Self.LoginNameLabeledEdit.Text) = True then
    begin
      PlayerLogin := Self.LoginNameLabeledEdit.Text;
      Self.ModalResult := mrOK;
    end
    else
      ShowMessage('Login not found.');
  end;

  if Self.LoginRadioGroup.ItemIndex = 1 then
  begin
    if HangmanDataModule.CheckIfLoginExistsInDatabase(
      Self.LoginNameLabeledEdit.Text) = True then
      ShowMessage('That login name has already been chosen.')
    else
    begin
      NewPlayerDialog := UNewPlayer.TNewPlayerDialog.Create(Self);
      NewPlayerDialog.WelcomeLabel.Caption := 'Welcome to GUI Hangman. ' +
        'You will be registered on the ' + chr(13) + chr(10) +
        'database with a login of "' + Self.LoginNameLabeledEdit.Text + '". ' +
        chr(13) + chr(10) + 'Please enter your first and last names and ' +
        'click OK.';
      NewPlayerDialog.OKButton.Enabled := False;
      NewPlayerDialog.ShowModal;
      if NewPlayerDialog.ModalResult = mrOK then
      begin
        if HangmanDataModule.AddNewPlayerToDatabase(
          Self.LoginNameLabeledEdit.Text,
          NewPlayerDialog.FirstNameLabeledEdit.Text,
          NewPlayerDialog.LastNameLabeledEdit.Text) = True then
        begin
          ShowMessage('Your new profile was added to the database.');
          Self.LoginRadioGroup.ItemIndex := 0;
        end;
      end;
      NewPlayerDialog.Release;
    end;
  end;
  
end;

procedure TLoginForm.FormCreate(Sender: TObject);
{ Sets the LoginRadioGroup to the default radio button. }
begin
  Self.LoginRadioGroup.ItemIndex := 0;
end;

procedure TLoginForm.LoginNameLabeledEditChange(Sender: TObject);
{ Disables the Login form's OK Button unless the string in LoginNameLabeledEdit
  consists of only letters, numbers, and underscores and is not empty. }
var
  Count: integer;
begin
  if Self.LoginNameLabeledEdit.Text = '' then
    Self.OKButton.Enabled := False
  else
  begin
    Self.OKButton.Enabled := True;
    for Count := 1 to length(Self.LoginNameLabeledEdit.Text) do
    begin
      if not(Upcase(Self.LoginNameLabeledEdit.Text[Count]) in ['A'..'Z']) and
        not(Self.LoginNameLabeledEdit.Text[Count] in ['0'..'9']) and
        not(Self.LoginNameLabeledEdit.Text[Count] = '_') then
        Self.OKButton.Enabled := False;
    end;
  end;
end;

procedure TLoginForm.LoginNameLabeledEditEnter(Sender: TObject);
{ Calls the OKButtonClick procedure when the user presses Enter straight after
  typing in his or her name. }
begin
  Self.OKButton.Default := True;
end;

end.
