{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UAllGamesReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, UDataModule, QRCtrls;

type
  TAllGamesReportForm = class(TForm)
    AllGamesQuickRep: TQuickRep;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    AllGamesReportQRLabel: TQRLabel;
    PlayerQRLabel: TQRLabel;
    QRShape1: TQRShape;
    FirstNameQRDBText: TQRDBText;
    LastNameQRDBText: TQRDBText;
    DateTimeQRLabel: TQRLabel;
    DifficultyLevelQRLabel: TQRLabel;
    ScoreQRLabel: TQRLabel;
    QRShape2: TQRShape;
    QRSubDetail: TQRSubDetail;
    DifficultyLevelQRDBText: TQRDBText;
    DateTimeQRDBText: TQRDBText;
    ScoreQRDBText: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
