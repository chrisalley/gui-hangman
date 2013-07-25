{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UGameReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls;

type
  TGameReportForm = class(TForm)
    GameQuickRep: TQuickRep;
    TitleBand1: TQRBand;
    GameReportQRLabel: TQRLabel;
    EasyQRLabel: TQRLabel;
    NormalQRLabel: TQRLabel;
    HardQRLabel: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    GamesPlayedQRLabel1: TQRLabel;
    AverageScoreQRLabel1: TQRLabel;
    ChampionScoreQRLabel1: TQRLabel;
    CurrentChampionQRLabel1: TQRLabel;
    ChampionDatePlayedQRLabel1: TQRLabel;
    GamesPlayedQRLabel2: TQRLabel;
    AverageScoreQRLabel2: TQRLabel;
    CurrentChampionQRLabel2: TQRLabel;
    ChampionScoreQRLabel2: TQRLabel;
    DatePlayedQRLabel2: TQRLabel;
    EasyDatePlayedQRLabel: TQRLabel;
    EasyChampionScoreQRLabel: TQRLabel;
    EasyCurrentChampionQRLabel: TQRLabel;
    EasyAverageScoreQRLabel: TQRLabel;
    EasyGamesPlayedQRLabel: TQRLabel;
    NormalAverageScoreQRLabel: TQRLabel;
    NormalCurrentChampionQRLabel: TQRLabel;
    NormalChampionScoreQRLabel: TQRLabel;
    NormalDatePlayedQRLabel: TQRLabel;
    NormalGamesPlayedQRLabel: TQRLabel;
    HardCurrentChampionQRLabel: TQRLabel;
    HardAverageScoreQRLabel: TQRLabel;
    HardGamesPlayedQRLabel: TQRLabel;
    HardDatePlayedQRLabel: TQRLabel;
    HardChampionScoreQRLabel: TQRLabel;
    DatePlayedQRLabel3: TQRLabel;
    ChampionScoreQRLabel3: TQRLabel;
    CurrentChampionQRLabel3: TQRLabel;
    AverageScoreQRLabel3: TQRLabel;
    GamesPlayedQRLabel3: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GameReportForm: TGameReportForm;

implementation

{$R *.dfm}

end.
