{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit USplashScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Jpeg;

type
  TSplashScreen = class(TForm)
    SplashScreenImage: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TSplashScreen.FormCreate(Sender: TObject);
{ Loads the splash screen's image from file. }
begin
  Self.SplashScreenImage.Picture.LoadFromFile('Images/SplashScreen.jpg');
end;

end.
