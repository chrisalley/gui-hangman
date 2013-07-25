{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UGameLogic;

interface

uses
  UConstantsAndTypes;

type
  TGameLogic = class(TObject)
  private
    MysteryWord: string;
    WordListFile: textfile;
    GuessesLeft: integer;
    AvailableLetters: TLetterSet;
    UsedLetters: TLetterSet;
    GuessedLetter: char;
    CheatMode: boolean;
    function GetAmountOfWordsInTextFile: integer;
    procedure SetGuessesLeftToDefault;
    procedure SetAvailableLettersToDefault;
    procedure SetUsedLettersToDefault;
    procedure AddVowelsToUsedLetters;
    procedure DecrementGuessesLeftByOne;
    procedure UpdateLetterSets;
  public
    procedure SetCheatModeToTrue;
    procedure GetRandomMysteryWord(DifficultyLevel: string);
    procedure PrepareGame;
    function UpdateCurrentStateOfMysteryWord: string;
    function CheckIfGuessedLetterIsWrong(ALetter: char): boolean;
    function GetGuessesLeft: integer;
    function CheckIfPlayerHasLost: boolean;
    function CheckIfPlayerHasWon: boolean;
    function GetMysteryWord: string;
  end;

implementation

procedure TGameLogic.AddVowelsToUsedLetters;
{ Carries out a cheat that gives the player all the vowels at the start of a
  new game. }
begin
  if Self.CheatMode = True then
    Self.UsedLetters := Self.UsedLetters + ['A', 'E', 'I', 'O', 'U', 'Y'];
end;

function TGameLogic.GetAmountOfWordsInTextFile: integer;
begin
  Result := 0;
  reset(Self.WordListFile);
  while not eof(Self.WordListFile) do
  begin
    readln(Self.WordListFile);
    Result := Result + 1;
  end;
  closefile(Self.WordListFile);
end;

procedure TGameLogic.GetRandomMysteryWord(DifficultyLevel: string);
{ Gets a random mystery word from a text file, depending on the difficulty
  level. }
var
  Count, RandomNumber: integer;
begin
  Count := 0;
  if DifficultyLevel = Easy then
    assignfile(WordListFile, EasyWordListFilePath);
  if DifficultyLevel = Normal then
    assignfile(WordListFile, NormalWordListFilePath);
  if DifficultyLevel = Hard then
    assignfile(WordListFile, HardWordListFilePath);
  Randomize;
  RandomNumber := Random(Self.GetAmountOfWordsInTextFile);
  reset(Self.WordListFile);
  while not eof(Self.WordListFile) do
  begin
    Count := Count + 1;
    readln(Self.WordListFile, Self.MysteryWord);
    if Count = RandomNumber then
      break;
  end;
  closefile(Self.WordListFile);
end;

procedure TGameLogic.PrepareGame;
{ Sets various game settings to default, before a new game is started. }
begin
  Self.SetGuessesLeftToDefault;
  Self.SetAvailableLettersToDefault;
  Self.SetUsedLettersToDefault;
  Self.AddVowelsToUsedLetters;
  Self.UpdateLetterSets;
  Self.CheckIfPlayerHasLost;
end;

procedure TGameLogic.SetAvailableLettersToDefault;
begin
  Self.AvailableLetters := ['A' .. 'Z'];
end;

procedure TGameLogic.SetGuessesLeftToDefault;
begin
  Self.GuessesLeft := 10;
end;

procedure TGameLogic.SetUsedLettersToDefault;
begin
  Self.UsedLetters := [];
end;

function TGameLogic.UpdateCurrentStateOfMysteryWord: string;
{ Returns the current state of the mystery word, only showing the letters in it
  that have been guessed. }
var
  Count: integer;
begin
  Result := '';
  for Count := 1 to length(Self.MysteryWord) do
  begin
    if Self.MysteryWord[Count] in Self.UsedLetters then
      Result := Result +
        Self.MysteryWord[Count]
    else
      Result := Result +
        MysteryLetter;
  end;
end;

procedure TGameLogic.UpdateLetterSets;
{ Adds the guessed letter to the used letters set, and subtracts it from the
  avaliable letters set. }
begin
  Self.AvailableLetters := Self.AvailableLetters - [Self.GuessedLetter];
  Self.UsedLetters := Self.UsedLetters + [Self.GuessedLetter];
end;

procedure TGameLogic.DecrementGuessesLeftByOne;
begin
  Self.GuessesLeft := Self.GuessesLeft - 1;
end;

function TGameLogic.CheckIfGuessedLetterIsWrong(ALetter: char): boolean;
{ Returns true only if GuessedLetter is in AvailableLetters and is also in the
  mystery word. }
var
  Count: integer;
begin
  Result := True;
  Self.GuessedLetter := ALetter;
  if (Self.GuessedLetter in Self.AvailableLetters) then
  begin
    for Count := 1 to length(Self.MysteryWord) do
    begin
      if Self.GuessedLetter = Self.MysteryWord[Count] then
        Result := False;
    end;
    if Result = True then
    begin
      Self.DecrementGuessesLeftByOne;
      Result := True;
    end;
  end
  else
    Result := False;
  Self.UpdateLetterSets;
end;

function TGameLogic.GetGuessesLeft: integer;
begin
  Result := Self.GuessesLeft;
end;

function TGameLogic.CheckIfPlayerHasLost: boolean;
begin
  Result := False;
  if Self.GuessesLeft = 0 then
    Result := True;
end;

function TGameLogic.CheckIfPlayerHasWon: boolean;
begin
  Result := False;
  if Self.UpdateCurrentStateOfMysteryWord = Self.MysteryWord then
    Result := True;
end;

function TGameLogic.GetMysteryWord: string;
begin
  Result := Self.MysteryWord;
end;

procedure TGameLogic.SetCheatModeToTrue;
{ Turns cheat mode on. }
begin
  Self.CheatMode := True;
end;

end.
