object SplashScreen: TSplashScreen
  Left = 258
  Top = 222
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'SplashScreen'
  ClientHeight = 273
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SplashScreenImage: TImage
    Left = 0
    Top = 0
    Width = 400
    Height = 300
  end
end
