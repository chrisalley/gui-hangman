{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 22nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

program GUIHangman;

uses
  Forms,
  UMain in 'UMain.pas' {MainForm},
  ULogin in 'ULogin.pas' {LoginForm},
  UAbout in 'UAbout.pas' {AboutDialog},
  UReports in 'UReports.pas' {ReportsDialog},
  UNewPlayer in 'UNewPlayer.pas' {NewPlayerDialog},
  UGameLogic in 'UGameLogic.pas',
  UDataModule in 'UDataModule.pas',
  USplashScreen in 'USplashScreen.pas' {SplashScreen},
  UPlayerReport in 'UPlayerReport.pas' {PlayerReportForm: TQuickRep},
  UGameReport in 'UGameReport.pas' {GameReportForm: TQuickRep},
  UAllGamesReport in 'UAllGamesReport.pas' {AllGamesReportForm: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GUI Hangman';
  Application.CreateForm(THangmanDataModule, HangmanDataModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
