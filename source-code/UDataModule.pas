{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UDataModule;

interface

uses
  SysUtils, Classes, DB, ADODB, UConstantsAndTypes, Dialogs, Forms;

type
  THangmanDataModule = class(TDataModule)
    HangmanADOConnection: TADOConnection;
    PlayersADOTable: TADOTable;
    GamesADOTable: TADOTable;
    PlayersDataSource: TDataSource;
    GamesDataSource: TDataSource;
    CalcPlayerGamesPlayed: TADOStoredProc;
    CalcPlayerGamesPlayedPlayerLogin: TWideStringField;
    CalcPlayerGamesPlayedGameDifficultyLevel: TWideStringField;
    CalcPlayerGamesPlayedCountOfGameDateTimeCompleted: TIntegerField;
    CalcPlayerAverageScore: TADOStoredProc;
    CalcPlayerBestScore: TADOStoredProc;
    CalcAllGamesPlayed: TADOStoredProc;
    CalcAllAverageScore: TADOStoredProc;
    CalcChampionDetails: TADOStoredProc;
    PlayersADOTablePlayerLogin: TWideStringField;
    PlayersADOTablePlayerFirstName: TWideStringField;
    PlayersADOTablePlayerLastName: TWideStringField;
    PlayersADOTablePlayerDateTimeRegistered: TDateTimeField;
  private
    { Private declarations }
  public
    function CheckIfLoginExistsInDatabase(ALogin: string): boolean;
    function AddNewPlayerToDatabase(ALogin, AFirstName, ALastName: string):
      boolean;
    function AddGameScoreToDatabase(ALogin, ADifficultyLevel: string; AScore:
      integer): boolean;
    function GetPlayerFirstAndLastNames(ALogin: string; var AFirstName,
      ALastName: string): boolean;
    function GetIndividualGameStatistics(ALogin, ADifficultyLevel: string; var
      AGamesPlayed, AAverageScore, ABestScore: integer):
      boolean;
    procedure GetGameStatistics(ADifficultyLevel: string; var
      AGamesPlayed, AAverageScore: integer; var ACurrentChampion: string; var
      AChampionScore: integer; var AChampionGameDateTime: string);
    procedure ConnectToDatabase;
  end;

var
  HangmanDataModule: THangmanDataModule;

implementation

{$R *.dfm}

{ THangmanDataModule }

function THangmanDataModule.CheckIfLoginExistsInDatabase(ALogin: string):
  boolean;
{ Returns true if the login exists in the database, otherwise it will return
  false. }
begin
  Result := Self.PlayersADOTable.Locate('PlayerLogin', ALogin,
    [loCaseInsensitive]);
end;

function THangmanDataModule.AddNewPlayerToDatabase(ALogin, AFirstName,
  ALastName: string): boolean;
{ If the player doesn't already exist in the database, then the function will
  add the new player's details to the database and then return true. }
begin
  if Self.PlayersADOTable.Locate('PlayerLogin', ALogin, [loCaseInsensitive]) =
    False then
  begin
    if (not(ALogin = '') and not(AFirstName = '') and not(ALastName = '')) then
    begin
      Self.PlayersADOTable.Insert;
      Self.PlayersADOTable.FieldByName('PlayerLogin').Value := ALogin;
      Self.PlayersADOTable.FieldByName('PlayerFirstName').Value := AFirstName;
      Self.PlayersADOTable.FieldByName('PlayerLastName').Value := ALastName;
      Self.PlayersADOTable.FieldByName('PlayerDateTimeRegistered').Value := Now;
      Self.PlayersADOTable.Post;
      Result := True;
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

function THangmanDataModule.AddGameScoreToDatabase(ALogin, ADifficultyLevel:
  string; AScore: integer): boolean;
{ Adds the game's details to the database, depending on what Difficulty Level
  and Login were passed into the function. }
begin
  if Self.PlayersADOTable.Locate('PlayerLogin', ALogin, [loCaseInsensitive]) =
    False then
    Result := False
  else
  begin
    if (not(ADifficultyLevel = Easy)) and (not(ADifficultyLevel = Normal)) and
      (not(ADifficultyLevel = Hard)) then
      Result := False
    else
    begin
      if (AScore < 0) or (AScore > 10) then
        Result := False
      else
      begin
      Self.GamesADOTable.Insert;
      Self.GamesADOTable.FieldByName('GamePlayerLogin').Value := ALogin;
      Self.GamesADOTable.FieldByName('GameDifficultyLevel').Value :=
        ADifficultyLevel;
      Self.GamesADOTable.FieldByName('GameScore').Value := AScore;
      Self.GamesADOTable.FieldByName('GameDateTimeCompleted').Value := Now;
      Self.GamesADOTable.Post;
        Result := True;
      end;
    end;
  end;
end;

function THangmanDataModule.GetPlayerFirstAndLastNames(ALogin: string; var
  AFirstName, ALastName: string): boolean;
{ Grabs the player's first and last names out of the database. Returns false if
  the player's login cannot be found. }
begin
  if Self.PlayersADOTable.Locate('PlayerLogin', ALogin, [loCaseInsensitive]) =
    False then
  begin
    AFirstName := 'Error';
    ALastName := 'Error';
    Result := False;
  end
  else
  begin
    AFirstName := Self.PlayersADOTable.FieldByName('PlayerFirstName').Value;
    ALastName := Self.PlayersADOTable.FieldByName('PlayerLastName').Value;
    Result := True;
  end;
end;

function THangmanDataModule.GetIndividualGameStatistics(ALogin,
  ADifficultyLevel: string; var AGamesPlayed, AAverageScore, ABestScore:
  integer): boolean;
{ Gets the number of games played, average score, and best score of the player
  whose login name was passed into the function, on the difficulty level
  passed into the function. }
begin

  AGamesPlayed := 0;
  AAverageScore := 0;
  ABestScore := 0;

  if Self.PlayersADOTable.Locate('PlayerLogin', ALogin, [loCaseInsensitive]) =
    False then
    Result := False
  else
  begin

    // Get the number of games that the player has finished.
    Self.CalcPlayerGamesPlayed.Parameters.ParamValues['PlayerLogin'] :=
      ALogin;
    Self.CalcPlayerGamesPlayed.Parameters.ParamValues['GameDifficultyLevel']
      := ADifficultyLevel;
    Self.CalcPlayerGamesPlayed.Active := False;
    Self.CalcPlayerGamesPlayed.Active := True;
    if not(Self.CalcPlayerGamesPlayed.BOF and
      Self.CalcPlayerGamesPlayed.EOF) then
      AGamesPlayed :=
      Self.CalcPlayerGamesPlayed.FieldValues['CountOfGameDateTimeCompleted'];

    // Get the average of the player's scores on ADifficultyLevel.
    Self.CalcPlayerAverageScore.Parameters.ParamValues['PlayerLogin'] :=
      ALogin;
    Self.CalcPlayerAverageScore.Parameters.ParamValues['GameDifficultyLevel']
      := ADifficultyLevel;
    Self.CalcPlayerAverageScore.Active := False;
    Self.CalcPlayerAverageScore.Active := True;
    if not(Self.CalcPlayerAverageScore.BOF and
      Self.CalcPlayerAverageScore.EOF) then
      AAverageScore :=
      Self.CalcPlayerAverageScore.FieldValues['AvgOfGameScore'];

    // Get the best score that the player has made on ADifficultyLevel.
    Self.CalcPlayerBestScore.Parameters.ParamValues['PlayerLogin'] :=
      ALogin;
    Self.CalcPlayerBestScore.Parameters.ParamValues['GameDifficultyLevel']
      := ADifficultyLevel;
    Self.CalcPlayerBestScore.Active := False;
    Self.CalcPlayerBestScore.Active := True;
    if not(Self.CalcPlayerBestScore.BOF and
      Self.CalcPlayerBestScore.EOF) then
      ABestScore :=
      Self.CalcPlayerBestScore.FieldValues['MaxOfGameScore'];

    Result := True;

  end;
end;

procedure THangmanDataModule.GetGameStatistics(ADifficultyLevel: string;
  var AGamesPlayed, AAverageScore: integer; var ACurrentChampion: string; var
  AChampionScore: integer; var AChampionGameDateTime: string);
{ Gets the numbers of games played, average score, current champion, champion's
  score, and the date and time that the champion made the score on the
  difficulty level passed into the procedure. }
begin

  AGamesPlayed := 0;
  AAverageScore := 0;
  ACurrentChampion := '';
  AChampionScore := 0;
  AChampionGameDateTime := '';

  // Get the amount of games played on ADifficultyLevel.
  Self.CalcAllGamesPlayed.Parameters.ParamValues['GameDifficultyLevel'] :=
    ADifficultyLevel;
  Self.CalcAllGamesPlayed.Active := False;
  Self.CalcAllGamesPlayed.Active := True;
  if not(Self.CalcAllGamesPlayed.BOF and
    Self.CalcAllGamesPlayed.EOF) then
    AGamesPlayed :=
    Self.CalcAllGamesPlayed.FieldValues['CountOfGameDateTimeCompleted'];

  // Get the average score of all games played on ADifficultyLevel.
  Self.CalcAllAverageScore.Parameters.ParamValues['GameDifficultyLevel'] :=
    ADifficultyLevel;
  Self.CalcAllAverageScore.Active := False;
  Self.CalcAllAverageScore.Active := True;
  if not(Self.CalcAllAverageScore.BOF and
    Self.CalcAllAverageScore.EOF) then
    AAverageScore :=
    Self.CalcAllAverageScore.FieldValues['AvgOfGameScore'];

  // Get Champion details on ADifficultyLevel.
  Self.CalcChampionDetails.Parameters.ParamValues['GameDifficultyLevel'] :=
    ADifficultyLevel;
  Self.CalcChampionDetails.Active := False;
  Self.CalcChampionDetails.Active := True;
  if not(Self.CalcChampionDetails.BOF and Self.CalcChampionDetails.EOF) then
  begin
    ACurrentChampion := Self.CalcChampionDetails.FieldValues['GamePlayerLogin'];
    AChampionScore :=
      Self.CalcChampionDetails.FieldValues['GameScore'];
    AChampionGameDateTime :=
      Self.CalcChampionDetails.FieldValues['MaxOfGameDateTimeCompleted'];
  end;

end;

procedure THangmanDataModule.ConnectToDatabase;
{ Connects to the game's database using a dynamically created connection
  string. It also makes the database's tables active. }
const
  DatabaseFilePath = 'Database\HangmanDatabase.mdb';
var
  ApplicationFilePath: string;
begin
  ApplicationFilePath := ExtractFilePath(Application.ExeName);
  Self.HangmanADOConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;' +
    'Data Source=' + ApplicationFilePath + DatabaseFilePath +
    ';Mode=Share Deny None;Extended Properties="";' +
    'Persist Security Info=False;Jet OLEDB:System database="";' +
    'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";' +
    'Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;' +
    'Jet OLEDB:Global Partial Bulk Ops=2;' +
    'Jet OLEDB:Global Bulk Transactions=1;' +
    'Jet OLEDB:New Database Password="";' +
    'Jet OLEDB:Create System Database=False;' +
    'Jet OLEDB:Encrypt Database=False;' +
    'Jet OLEDB:Don''t Copy Locale on Compact=False;Jet OLEDB:' +
    'Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
  Self.HangmanADOConnection.Connected := True;
  Self.PlayersADOTable.Active := True;
  Self.GamesADOTable.Active := True;
end;

end.
