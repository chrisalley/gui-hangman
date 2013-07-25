{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg;

type
  TAboutDialog = class(TForm)
    AboutGroupBox: TGroupBox;
    OKButton: TButton;
    TitleLabel: TLabel;
    VersionLabel: TLabel;
    CopyrightLabel: TLabel;
    FreewareLabel: TLabel;
    ProgrammedByLabel: TLabel;
    GraphicsAndSoundEffectsLabel: TLabel;
    CreatedWithLabel: TLabel;
    DividerPanel: TPanel;
    ImagePanel: TPanel;
    AboutImage: TImage;
    BasedOnLabel: TLabel;
    CheatPanel1: TPanel;
    CheatPanel2: TPanel;
    CheatPanel3: TPanel;
    CheatPanel4: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure CheatPanelClick(Sender: TObject);
    procedure CheatPanel1Click(Sender: TObject);
    procedure CheatPanel2Click(Sender: TObject);
    procedure CheatPanel3Click(Sender: TObject);
    procedure CheatPanel4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TAboutDialog.FormCreate(Sender: TObject);
{ Sets all of the components on the About form to their default states. }
begin
  Self.OKButton.Default := True;
  Self.AboutImage.Picture.LoadFromFile('Images/AboutScreen.jpg');
  Self.CheatPanel1.Enabled := True;
  Self.CheatPanel2.Enabled := False;
  Self.CheatPanel3.Enabled := False;
  Self.CheatPanel4.Enabled := False;
end;

procedure TAboutDialog.CheatPanelClick(Sender: TObject);
{ The following procedures are used to activate and deactivate the game's
  cheats. If the user presses the four hidden panels in the correct order then
  the cheat will turn on. }
begin
  Self.ModalResult := mrYes;
end;

procedure TAboutDialog.CheatPanel1Click(Sender: TObject);
begin
  Self.CheatPanel2.Enabled := True;
  Self.CheatPanel1.Enabled := False;
end;

procedure TAboutDialog.CheatPanel2Click(Sender: TObject);
begin
  Self.CheatPanel3.Enabled := True;
  Self.CheatPanel2.Enabled := False;
end;

procedure TAboutDialog.CheatPanel3Click(Sender: TObject);
begin
  Self.CheatPanel4.Enabled := True;
  Self.CheatPanel3.Enabled := False;
end;

procedure TAboutDialog.CheatPanel4Click(Sender: TObject);
begin
  Self.ModalResult := mrYes;
  Self.CheatPanel1.Enabled := False;
end;

end.


