{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ULogin, UAbout, UReports, UGameLogic, Jpeg, StdCtrls,
  ExtCtrls, ComCtrls, MPlayer, UDataModule, USplashScreen;

type
  TMainForm = class(TForm)
    MainMainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    FileLoginMenuItem: TMenuItem;
    FileExitMenuItem: TMenuItem;
    GameMenuItem: TMenuItem;
    GameNewGameMenuItem: TMenuItem;
    GameEndGameMenuItem: TMenuItem;
    SeperatorMenuItem2: TMenuItem;
    GameReportsMenuItem: TMenuItem;
    HelpMenuItem: TMenuItem;
    HelpAboutMenuItem: TMenuItem;
    FileLogoutMenuItem: TMenuItem;
    SeperatorMenuItem1: TMenuItem;
    ScorePanel: TPanel;
    WordPanel: TPanel;
    HangmanImage: TImage;
    DifficultyLevelRadioGroup: TRadioGroup;
    NewGameButton: TButton;
    EndGameButton: TButton;
    HangmanMediaPlayer: TMediaPlayer;
    SplashScreenTimer: TTimer;
    procedure FileLoginMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileExitMenuItemClick(Sender: TObject);
    procedure HelpAboutMenuItemClick(Sender: TObject);
    procedure FileLogoutMenuItemClick(Sender: TObject);
    procedure GameEndGameMenuItemClick(Sender: TObject);
    procedure EndGameButtonClick(Sender: TObject);
    procedure NewGameButtonClick(Sender: TObject);
    procedure GameNewGameMenuItemClick(Sender: TObject);
    procedure GameReportsMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SplashScreenTimerTimer(Sender: TObject);
  private
    { Private declarations }
    GameLogic: TGameLogic;
    ImageNumber: integer;
    ImageStringList: TStringList;
    SoundStringList: TStringList;
    PlayerLogin: string;
    SplashScreenTimerCount: integer;
    SplashScreen: TSplashScreen;
    CheatMode: boolean;
    procedure CreateLetterPanels;
    procedure EnableAllLetterPanels;
    procedure DisableSingleLetterPanel(ALetter: char);
    procedure DisableAllLetterPanels;
    procedure DisableGameControls;
    procedure EnableGameControls;
    procedure DisableLoggedInControls;
    procedure EnableLoggedInControls;
    function EndCurrentGame: boolean;
    procedure DynamicLetterPanelClick(Sender: TObject);
    procedure DealWithChosenLetter(ChosenLetter: char);
    procedure UpdatePanels;
    procedure CreateStringLists;
    procedure PlaySound(SoundNumber: integer);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FileLoginMenuItemClick(Sender: TObject);
{ Opens the Login window, and if the user clicks OK on it then the player will
  be logged in and the logged in controls enabled. }
var
  LoginForm: TLoginForm;
begin
  LoginForm := ULogin.TLoginForm.Create(Self);
  LoginForm.OKButton.Enabled := False;
  LoginForm.ShowModal;
  if LoginForm.ModalResult = mrOK then
  begin
    EnableLoggedInControls;
    Self.PlayerLogin := LoginForm.PlayerLogin;
  end;
  LoginForm.Release;
end;

procedure TMainForm.FormCreate(Sender: TObject);
{ Creates the game's splash screen and sets various settings and components to
  default. }
begin
  // Creates the Splash Screen and blends it on to the screen.
  SplashScreen := TSplashScreen.Create(Application);
  SplashScreen.Show;
  while SplashScreen.AlphaBlendValue < 255 do
  begin
    SplashScreen.AlphaBlendValue := SplashScreen.AlphaBlendValue + 5;
    SplashScreen.Update;
  end;
  Self.SplashScreenTimerCount := 0;

  HangmanDataModule.ConnectToDatabase;
  Self.DisableLoggedInControls;
  Self.HangmanImage.Picture.LoadFromFile('Images/Hangman10.jpg');
  Self.CreateLetterPanels;
  Self.DifficultyLevelRadioGroup.ItemIndex := 0;
  Self.NewGameButton.Default := True;
end;

procedure TMainForm.FileExitMenuItemClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TMainForm.HelpAboutMenuItemClick(Sender: TObject);
{ Displays the About window, and turns cheat mode on or off if need be. }
var
  AboutDialog: TAboutDialog;
begin
  AboutDialog := UAbout.TAboutDialog.Create(Self);
  AboutDialog.ShowModal;
  if AboutDialog.ModalResult = mrYes then
  begin
    if Self.CheatMode = False then
    begin
      Self.CheatMode := True;
      ShowMessage('Congratulations, you have successfully activated cheat mode.'
        + #13 + #10 + 'Vowels will now automatically show up at the start of' +
        ' each new game.');
    end
    else
    begin
      Self.CheatMode := False;
      ShowMessage('Cheat mode has been turned off.');
    end;
  end;
  AboutDialog.Release;
end;

procedure TMainForm.FileLogoutMenuItemClick(Sender: TObject);
begin
  // Checks to see if a game is currently in progress.
  if Self.HangmanImage.Visible = True then
  begin
    if Self.EndCurrentGame = True then
      DisableLoggedInControls;
  end
  else
    DisableLoggedInControls;
end;

procedure TMainForm.CreateLetterPanels;
{ Dynamically creates the Panels labelled A to Z on the main form. }
var
  PanelTopPosition: integer;
  PanelLeftPosition: integer;
  PanelWidth: integer;
  PanelHeight: integer;
  Count: integer;
  ParentForm: TMainForm;
begin
  PanelWidth := 20;
  PanelHeight := 20;
  PanelLeftPosition := 8;
  PanelTopPosition := 300;
  for Count := 0 to 25 do
  begin
    ParentForm := Self;
    if Count = 13 then
    begin
      PanelTopPosition := PanelTopPosition + 21;
      PanelLeftPosition := PanelLeftPosition - 273;
    end;
    with TPanel.Create(Self) do
    begin
      Caption := Chr(Count + 65);
      Top := PanelTopPosition;
      Left := PanelLeftPosition;
      Width := PanelWidth;
      Height := PanelHeight;
      Visible := True;
      Enabled := False;
      Parent := ParentForm;
      BevelOuter := bvSpace;
      Font.Color := clInactiveCaption;
      Tag := 42;
      OnClick := DynamicLetterPanelClick;
    end;
    PanelTopPosition := PanelTopPosition + 0;
    PanelLeftPosition := PanelLeftPosition + 21;
    Application.ProcessMessages;
  end;
end;

procedure TMainForm.GameEndGameMenuItemClick(Sender: TObject);
begin
  Self.EndCurrentGame;
end;

procedure TMainForm.EndGameButtonClick(Sender: TObject);
begin
  Self.GameEndGameMenuItemClick(Self);
end;

procedure TMainForm.NewGameButtonClick(Sender: TObject);
begin
  Self.GameNewGameMenuItemClick(Self);
end;

procedure TMainForm.GameNewGameMenuItemClick(Sender: TObject);
{ Enables the game controls and sets up a few other settings needed for a fresh
  game. }
begin
  Self.EnableGameControls;
  GameLogic.PrepareGame;
  GameLogic.GetRandomMysteryWord(Self.DifficultyLevelRadioGroup.Items.Strings
    [Self.DifficultyLevelRadioGroup.ItemIndex]);
  Self.UpdatePanels;
end;

procedure TMainForm.GameReportsMenuItemClick(Sender: TObject);
{ Opens up a new window that displays the list of different types of reports. }
var
  ReportsDialog: TReportsDialog;
begin
  ReportsDialog := UReports.TReportsDialog.Create(Self);
  ReportsDialog.PlayerLogin := Self.PlayerLogin;
  ReportsDialog.ShowModal;
  ReportsDialog.Release;
end;

procedure TMainForm.DisableSingleLetterPanel(ALetter: char);
{ Makes a letter panel appear lowered. }
var
  Count: integer;
begin
  for Count := 0 to Self.ControlCount - 1 do
  begin
    if (TPanel(Self.Controls[Count]).Caption = ALetter) and
      (Self.Controls[Count].Tag = 42) then
    begin
      TPanel(Self.Controls[Count]).Enabled := False;
      TPanel(Self.Controls[Count]).BevelOuter := bvLowered;
      TPanel(Self.Controls[Count]).Font.Color := clInactiveCaption;
    end;
  end;
end;

procedure TMainForm.EnableAllLetterPanels;
{ Makes all of the letter panels appear raised. }
var
  Count: integer;
begin
  for Count := 0 to Self.ControlCount - 1 do
  begin
    if Self.Controls[Count].Tag = 42 then
    begin
      TPanel(Self.Controls[Count]).Enabled := True;
      TPanel(Self.Controls[Count]).BevelOuter := bvSpace;
      TPanel(Self.Controls[Count]).Font.Color := clWindowText;
    end;
  end;
end;

procedure TMainForm.DisableAllLetterPanels;
var
  Count: integer;
begin
  for Count := 0 to 25 do
  begin
    // ASCII 65 is the same as capital A.
    Self.DisableSingleLetterPanel(chr(Count + 65));
  end;
end;

procedure TMainForm.DisableGameControls;
{ Disables all of the controls used in the game when the game ends. }
begin
  Self.GameLogic.Free;
  Self.GameNewGameMenuItem.Enabled := True;
  Self.GameEndGameMenuItem.Enabled := False;
  Self.ScorePanel.Caption := '';
  Self.WordPanel.Caption := '';
  Self.HangmanImage.Visible := False;
  Self.HangmanMediaPlayer.Close;
  Self.ImageStringList.Destroy;
  Self.SoundStringList.Destroy;
  Self.DisableAllLetterPanels;
  Self.DifficultyLevelRadioGroup.Enabled := True;
  Self.NewGameButton.Enabled := True;
  Self.EndGameButton.Enabled := False;
end;

procedure TMainForm.EnableGameControls;
{ Enables all of the game's controls at the start of a new game. }
begin
  GameLogic := TGameLogic.Create;
  if Self.CheatMode = True then
    GameLogic.SetCheatModeToTrue;
  Self.GameNewGameMenuItem.Enabled := False;
  Self.GameEndGameMenuItem.Enabled := True;
  Self.CreateStringLists;
  Self.HangmanImage.Picture.LoadFromFile(Self.ImageStringList[10]);
  Self.HangmanImage.Visible := True;
  Self.EnableAllLetterPanels;
  Self.DifficultyLevelRadioGroup.Enabled := False;
  Self.NewGameButton.Enabled := False;
  Self.EndGameButton.Enabled := True;
  Self.EndGameButton.Default := True;
end;

procedure TMainForm.DisableLoggedInControls;
{ Disables a number of controls when the user logs out. }
begin
  Self.FileLoginMenuItem.Enabled := True;
  Self.FileLogoutMenuItem.Enabled := False;
  Self.GameNewGameMenuItem.Enabled := False;
  Self.GameEndGameMenuItem.Enabled := False;
  Self.GameReportsMenuItem.Enabled := False;
  Self.HangmanImage.Visible := False;
  Self.DisableAllLetterPanels;
  Self.DifficultyLevelRadioGroup.Enabled := False;
  Self.NewGameButton.Enabled := False;
  Self.EndGameButton.Enabled := False;
  Self.PlayerLogin := '';
end;

procedure TMainForm.EnableLoggedInControls;
{ Enables a number of controls when the user logs in. }
begin
  Self.FileLoginMenuItem.Enabled := False;
  Self.FileLogoutMenuItem.Enabled := True;
  Self.GameNewGameMenuItem.Enabled := True;
  Self.GameReportsMenuItem.Enabled := True;
  Self.DifficultyLevelRadioGroup.Enabled := True;
  Self.NewGameButton.Enabled := True;
  Self.NewGameButton.Default := True;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Checks to see if a game is currently in progress.
  if Self.HangmanImage.Visible = True then
  begin
    if Self.EndCurrentGame = True then
      CanClose := True
    else
      CanClose := False;
  end;
end;

function TMainForm.EndCurrentGame: boolean;
{ Opens a dialog box asking if the player wants to quit the game. If the player
  clicks Yes then the game controls are disabled. }
begin
  if MessageDlg('Do you really want to abandon this game?', mtCustom,
    [mbYes, mbNo], 0) = mrYes then
  begin
    Self.DisableGameControls;
    Result := True;
  end
  else
    Result := False;
end;

procedure TMainForm.DynamicLetterPanelClick(Sender: TObject);
{ When a letter panel is clicked then the chosen letter becomes the first
  character on the panel and then the DealWithChosenLetter method is called. }
var
  ChosenLetter: char;
begin
  ChosenLetter := TPanel(Sender).Caption[1];
  DealWithChosenLetter(ChosenLetter);
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
{ When a key is pressed, this method checks to see if it is between A and Z. If
  it is then the DealWithChosenLetter method is called. }
begin
  Key := UpCase(Key);
  if (Key in ['A' .. 'Z']) then
  begin
    if not(Self.WordPanel.Caption = '') then
      Self.DealWithChosenLetter(Key);
  end;
end;

procedure TMainForm.DealWithChosenLetter(ChosenLetter: char);
{ This is the main "Play Game" method of the program. It updates the various
  components of the game, and plays any sound effects. If the game is over then
  the score is added to the database, an appropriate message is displayed, and
  finally the game controls are disabled. }
begin
  DisableSingleLetterPanel(ChosenLetter);
  if GameLogic.CheckIfGuessedLetterIsWrong(ChosenLetter) = True then
    PlaySound(2);
  Self.UpdatePanels;
  Self.ImageNumber := GameLogic.GetGuessesLeft;
  Self.HangmanImage.Picture.LoadFromFile
    (Self.ImageStringList[Self.ImageNumber]);
  if GameLogic.CheckIfPlayerHasWon = True then
  begin
    PlaySound(1);
    ShowMessage('Congratulations! You have won the game!');
    HangmanDataModule.AddGameScoreToDatabase(Self.PlayerLogin,
      Self.DifficultyLevelRadioGroup.Items.Strings
      [Self.DifficultyLevelRadioGroup.ItemIndex],
      GameLogic.GetGuessesLeft);
    Self.DisableGameControls;
  end
  else
  begin
    if GameLogic.CheckIfPlayerHasLost = True then
    begin
      PlaySound(0);
      ShowMessage('You lost! The mystery word was "' + GameLogic.GetMysteryWord
        + '".');
      HangmanDataModule.AddGameScoreToDatabase(Self.PlayerLogin,
        Self.DifficultyLevelRadioGroup.Items.Strings
        [Self.DifficultyLevelRadioGroup.ItemIndex], GameLogic.GetGuessesLeft);
      Self.DisableGameControls;
    end;
  end;
end;

procedure TMainForm.UpdatePanels;
{ Updates the captions of the Score and Word Panels. }
begin
  Self.ScorePanel.Caption := 'Guesses Left: ' +
    IntToStr(GameLogic.GetGuessesLeft);
  Self.WordPanel.Caption := GameLogic.UpdateCurrentStateOfMysteryWord;
end;

procedure TMainForm.CreateStringLists;
{ Creates string lists that contain the file paths of the images and sounds
  that are used in the program. }
begin
  Self.ImageStringList := TStringList.Create;
  Self.ImageStringList.Add('Images/Hangman00.jpg');
  Self.ImageStringList.Add('Images/Hangman01.jpg');
  Self.ImageStringList.Add('Images/Hangman02.jpg');
  Self.ImageStringList.Add('Images/Hangman03.jpg');
  Self.ImageStringList.Add('Images/Hangman04.jpg');
  Self.ImageStringList.Add('Images/Hangman05.jpg');
  Self.ImageStringList.Add('Images/Hangman06.jpg');
  Self.ImageStringList.Add('Images/Hangman07.jpg');
  Self.ImageStringList.Add('Images/Hangman08.jpg');
  Self.ImageStringList.Add('Images/Hangman09.jpg');
  Self.ImageStringList.Add('Images/Hangman10.jpg');
  Self.SoundStringList := TStringList.Create;
  Self.SoundStringList.Add('Sounds/GameLost.wav');
  Self.SoundStringList.Add('Sounds/GameWon.wav');
  Self.SoundStringList.Add('Sounds/Hurt.wav');
  Self.SoundStringList.Add('Sounds/HighScore.wav');
end;

procedure TMainForm.PlaySound(SoundNumber: integer);
begin
  Self.HangmanMediaPlayer.FileName := Self.SoundStringList[SoundNumber];
  Self.HangmanMediaPlayer.Open;
  Self.HangmanMediaPlayer.Play;
end;

procedure TMainForm.SplashScreenTimerTimer(Sender: TObject);
{ Hides and then destroys the splash screen after it has been there for two
  seconds. }
begin
  Inc(Self.SplashScreenTimerCount);
  if Self.SplashScreenTimerCount = 2 then
  begin
    Self.SplashScreenTimer.Enabled := False;
    SplashScreen.Hide;
    SplashScreen.Free;
  end;
end;

end.
