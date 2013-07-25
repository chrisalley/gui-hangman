{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UPlayerReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls;

type
  TPlayerReportForm = class(TForm)
    PlayerQuickRep: TQuickRep;
    V: TQRBand;
    PlayerReportQRLabel: TQRLabel;
    PlayerLoginQRLabel: TQRLabel;
    EasyGamesPlayedQRLabel: TQRLabel;
    EasyAverageScoreQRLabel: TQRLabel;
    EasyBestScoreQRLabel: TQRLabel;
    GamesPlayedQRLabel1: TQRLabel;
    AverageScoreQRLabel1: TQRLabel;
    BestScoreQRLabel1: TQRLabel;
    EasyQRLabel: TQRLabel;
    NormalQRLabel: TQRLabel;
    HardQRLabel: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    BestScoreQRLabel3: TQRLabel;
    AverageScoreQRLabel3: TQRLabel;
    GamesPlayedQRLabel3: TQRLabel;
    HardGamesPlayedQRLabel: TQRLabel;
    HardAverageScoreQRLabel: TQRLabel;
    HardBestScoreQRLabel: TQRLabel;
    NormalBestScoreQRLabel: TQRLabel;
    GamesPlayedQRLabel2: TQRLabel;
    AverageScoreQRLabel2: TQRLabel;
    BestScoreQRLabel2: TQRLabel;
    NormalAverageScoreQRLabel: TQRLabel;
    NormalGamesPlayedQRLabel: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlayerReportForm: TPlayerReportForm;

implementation

{$R *.dfm}

end.
