object AboutDialog: TAboutDialog
  Left = 382
  Top = 286
  BorderStyle = bsDialog
  Caption = 'About GUI Hangman'
  ClientHeight = 328
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AboutGroupBox: TGroupBox
    Left = 9
    Top = 8
    Width = 320
    Height = 273
    TabOrder = 0
    object TitleLabel: TLabel
      Left = 16
      Top = 16
      Width = 119
      Height = 24
      Caption = 'GUI Hangman'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object VersionLabel: TLabel
      Left = 16
      Top = 48
      Width = 53
      Height = 13
      Caption = 'Version 1.0'
    end
    object CopyrightLabel: TLabel
      Left = 16
      Top = 64
      Width = 144
      Height = 13
      Caption = 'Copyright (C) Chris Alley, 2004.'
    end
    object FreewareLabel: TLabel
      Left = 16
      Top = 204
      Width = 276
      Height = 52
      Caption = 
        'This application is freeware and open source. That means that th' +
        'e game is 100% free for anyone to run, distribute, or modify, pr' +
        'ovided that you don'#39't go around claiming that you made it or own' +
        ' it yourself.'
      WordWrap = True
    end
    object ProgrammedByLabel: TLabel
      Left = 16
      Top = 120
      Width = 127
      Height = 13
      Caption = 'Programmed by Chris Alley.'
    end
    object GraphicsAndSoundEffectsLabel: TLabel
      Left = 16
      Top = 136
      Width = 283
      Height = 26
      Caption = 
        'Graphics and Sound Effects provided by Electec College of Techno' +
        'logy.'
      WordWrap = True
    end
    object CreatedWithLabel: TLabel
      Left = 16
      Top = 165
      Width = 234
      Height = 13
      Caption = 'Created using Borland Delphi 7 Enterprise Edition.'
      WordWrap = True
    end
    object BasedOnLabel: TLabel
      Left = 16
      Top = 88
      Width = 143
      Height = 26
      Caption = 'Based on the classic pen and paper game "Hangman".'
      WordWrap = True
    end
    object DividerPanel: TPanel
      Left = 16
      Top = 192
      Width = 289
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 0
    end
    object ImagePanel: TPanel
      Left = 168
      Top = 16
      Width = 140
      Height = 107
      BevelOuter = bvLowered
      TabOrder = 1
      object AboutImage: TImage
        Left = 1
        Top = 1
        Width = 137
        Height = 105
      end
    end
    object CheatPanel1: TPanel
      Left = 2
      Top = 7
      Width = 10
      Height = 10
      BevelOuter = bvNone
      TabOrder = 2
      OnClick = CheatPanel1Click
    end
    object CheatPanel2: TPanel
      Left = 307
      Top = 7
      Width = 10
      Height = 10
      BevelOuter = bvNone
      TabOrder = 3
      OnClick = CheatPanel2Click
    end
    object CheatPanel3: TPanel
      Left = 307
      Top = 259
      Width = 10
      Height = 10
      BevelOuter = bvNone
      TabOrder = 4
      OnClick = CheatPanel3Click
    end
    object CheatPanel4: TPanel
      Left = 2
      Top = 259
      Width = 10
      Height = 10
      BevelOuter = bvNone
      TabOrder = 5
      OnClick = CheatPanel4Click
    end
  end
  object OKButton: TButton
    Left = 134
    Top = 292
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
end
