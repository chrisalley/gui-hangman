{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UPlayerReport, UGameReport, UAllGamesReport,
  UDataModule, UConstantsAndTypes;

type
  TReportsDialog = class(TForm)
    ReportTypeRadioGroup: TRadioGroup;
    PrintPreviewButton: TButton;
    CloseButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PrintPreviewButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayPlayerReport;
    procedure DisplayGameReport;
    procedure DisplayAllGamesReport;
    procedure SetPlayerReportToDefault(var PlayerReportForm: TPlayerReportForm);
    procedure SetGameReportToDefault(var GameReportForm: TGameReportForm);
  public
    { Public declarations }
    PlayerLogin: string;
  end;

implementation

{$R *.dfm}

procedure TReportsDialog.DisplayAllGamesReport;
{ Modally creates and displays the All Games Report. }
var
  AllGamesReportForm: TAllGamesReportForm;
begin
  Self.PrintPreviewButton.Enabled := False;
  AllGamesReportForm := UAllGamesReport.TAllGamesReportForm.Create(Self);
  AllGamesReportForm.AllGamesQuickRep.PreviewModal;
  AllGamesReportForm.Release;
  Self.PrintPreviewButton.Enabled := True;
end;

procedure TReportsDialog.DisplayGameReport;
{ Modally creates and displays the Game Report. }
var
  GameReportForm: TGameReportForm;
  GamesPlayed, AverageScore, ChampionScore: integer;
  CurrentChampion, DatePlayed: string;
begin
  Self.PrintPreviewButton.Enabled := False;
  GameReportForm := UGameReport.TGameReportForm.Create(Self);
  SetGameReportToDefault(GameReportForm);

  // Get and display Easy game statistics.
  HangmanDataModule.GetGameStatistics(Easy, GamesPlayed, AverageScore,
    CurrentChampion, ChampionScore, DatePlayed);
  GameReportForm.EasyGamesPlayedQRLabel.Caption := IntToStr(GamesPlayed);
  GameReportForm.EasyAverageScoreQRLabel.Caption := IntToStr(AverageScore);
  GameReportForm.EasyCurrentChampionQRLabel.Caption := CurrentChampion;
  GameReportForm.EasyChampionScoreQRLabel.Caption := IntToStr(ChampionScore);
  GameReportForm.EasyDatePlayedQRLabel.Caption := DatePlayed;

  // Get and display Normal game statistics.
  HangmanDataModule.GetGameStatistics(Normal, GamesPlayed, AverageScore,
    CurrentChampion, ChampionScore, DatePlayed);
  GameReportForm.NormalGamesPlayedQRLabel.Caption := IntToStr(GamesPlayed);
  GameReportForm.NormalAverageScoreQRLabel.Caption := IntToStr(AverageScore);
  GameReportForm.NormalCurrentChampionQRLabel.Caption := CurrentChampion;
  GameReportForm.NormalChampionScoreQRLabel.Caption := IntToStr(ChampionScore);
  GameReportForm.NormalDatePlayedQRLabel.Caption := DatePlayed;

  // Get and display Hard game statistics.
  HangmanDataModule.GetGameStatistics(Hard, GamesPlayed, AverageScore,
    CurrentChampion, ChampionScore, DatePlayed);
  GameReportForm.HardGamesPlayedQRLabel.Caption := IntToStr(GamesPlayed);
  GameReportForm.HardAverageScoreQRLabel.Caption := IntToStr(AverageScore);
  GameReportForm.HardCurrentChampionQRLabel.Caption := CurrentChampion;
  GameReportForm.HardChampionScoreQRLabel.Caption := IntToStr(ChampionScore);
  GameReportForm.HardDatePlayedQRLabel.Caption := DatePlayed;

  GameReportForm.GameQuickRep.PreviewModal;
  GameReportForm.Release;
  Self.PrintPreviewButton.Enabled := True;
end;

procedure TReportsDialog.DisplayPlayerReport;
{ Modally creates and displays the Player Report. }
var
  PlayerReportForm: TPlayerReportForm;
  GamesPlayed, AverageScore, BestScore: integer;
begin
  Self.PrintPreviewButton.Enabled := False;
  PlayerReportForm := TPlayerReportForm.Create(Self);
  SetPlayerReportToDefault(PlayerReportForm);

  // Get and display player's Easy statistics.
  HangmanDataModule.GetIndividualGameStatistics(PlayerLogin, Easy, GamesPlayed,
    AverageScore, BestScore);
  PlayerReportForm.EasyGamesPlayedQRLabel.Caption := IntToStr(GamesPlayed);
  PlayerReportForm.EasyAverageScoreQRLabel.Caption := IntToStr(AverageScore);
  PlayerReportForm.EasyBestScoreQRLabel.Caption := IntToStr(BestScore);

  // Get and display player's Normal statistics.
  HangmanDataModule.GetIndividualGameStatistics(PlayerLogin, Normal,
    GamesPlayed, AverageScore, BestScore);
  PlayerReportForm.NormalGamesPlayedQRLabel.Caption := IntToStr(GamesPlayed);
  PlayerReportForm.NormalAverageScoreQRLabel.Caption := IntToStr(AverageScore);
  PlayerReportForm.NormalBestScoreQRLabel.Caption := IntToStr(BestScore);

  // Get and display player's Hard statistics.
  HangmanDataModule.GetIndividualGameStatistics(PlayerLogin, Hard, GamesPlayed,
    AverageScore, BestScore);
  PlayerReportForm.HardGamesPlayedQRLabel.Caption := IntToStr(GamesPlayed);
  PlayerReportForm.HardAverageScoreQRLabel.Caption := IntToStr(AverageScore);
  PlayerReportForm.HardBestScoreQRLabel.Caption := IntToStr(BestScore);

  PlayerReportForm.PlayerQuickRep.PreviewModal;
  PlayerReportForm.Release;
  Self.PrintPreviewButton.Enabled := True;
end;

procedure TReportsDialog.FormCreate(Sender: TObject);
{ Sets various settings and components to default. }
begin
  Self.ReportTypeRadioGroup.ItemIndex := 0;
  Self.PrintPreviewButton.Default := True;
end;

procedure TReportsDialog.PrintPreviewButtonClick(Sender: TObject);
{ Displays a report depending on which radio button was selected. }
begin
  case Self.ReportTypeRadioGroup.ItemIndex of
    0: Self.DisplayPlayerReport;
    1: Self.DisplayGameReport;
    2: Self.DisplayAllGamesReport;
  end;
end;

procedure TReportsDialog.SetGameReportToDefault(var GameReportForm:
  TGameReportForm);
{ Sets various labels and captions on the Game Report to default. }
begin
  GameReportForm.EasyQRLabel.Caption := Easy;
  GameReportForm.EasyGamesPlayedQRLabel.Caption := '';
  GameReportForm.EasyAverageScoreQRLabel.Caption := '';
  GameReportForm.EasyCurrentChampionQRLabel.Caption := '';
  GameReportForm.EasyChampionScoreQRLabel.Caption := '';
  GameReportForm.EasyDatePlayedQRLabel.Caption := '';
  GameReportForm.NormalQRLabel.Caption := Normal;
  GameReportForm.NormalGamesPlayedQRLabel.Caption := '';
  GameReportForm.NormalAverageScoreQRLabel.Caption := '';
  GameReportForm.NormalCurrentChampionQRLabel.Caption := '';
  GameReportForm.NormalChampionScoreQRLabel.Caption := '';
  GameReportForm.NormalDatePlayedQRLabel.Caption := '';
  GameReportForm.HardQRLabel.Caption := Hard;
  GameReportForm.HardGamesPlayedQRLabel.Caption := '';
  GameReportForm.HardAverageScoreQRLabel.Caption := '';
  GameReportForm.HardCurrentChampionQRLabel.Caption := '';
  GameReportForm.HardChampionScoreQRLabel.Caption := '';
  GameReportForm.HardDatePlayedQRLabel.Caption := '';
end;

procedure TReportsDialog.SetPlayerReportToDefault(var PlayerReportForm:
  TPlayerReportForm);
{ Sets various labels and captions on the Player Report to default. }
var
  PlayerFirstName, PlayerLastName: string;
begin
  HangmanDataModule.GetPlayerFirstAndLastNames(PlayerLogin, PlayerFirstName,
    PlayerLastName);
  PlayerReportForm.PlayerLoginQRLabel.Caption := '...for ' + PlayerFirstName +
    ' ' + PlayerLastName;
  PlayerReportForm.EasyQRLabel.Caption := Easy;
  PlayerReportForm.EasyGamesPlayedQRLabel.Caption := '';
  PlayerReportForm.EasyAverageScoreQRLabel.Caption := '';
  PlayerReportForm.EasyBestScoreQRLabel.Caption := '';
  PlayerReportForm.NormalQRLabel.Caption := Normal;
  PlayerReportForm.NormalGamesPlayedQRLabel.Caption := '';
  PlayerReportForm.NormalAverageScoreQRLabel.Caption := '';
  PlayerReportForm.NormalBestScoreQRLabel.Caption := '';
  PlayerReportForm.HardQRLabel.Caption := Hard;
  PlayerReportForm.HardGamesPlayedQRLabel.Caption := '' ;
  PlayerReportForm.HardAverageScoreQRLabel.Caption := '';
  PlayerReportForm.HardBestScoreQRLabel.Caption := '';
end;

end.
