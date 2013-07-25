object MainForm: TMainForm
  Left = 448
  Top = 283
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'GUI Hangman'
  ClientHeight = 469
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    BBBBBBBBBBBBBBBBBBBBBBBBBB0000000000000000000000000000000B000000
    0000000000000000000000000B0000BB0000000BB0000000000000000B00000B
    B00000BB00000000000000000B000000BB000BB000000000000000000B000000
    0BB0BB0000000000000000000B00000000BBB00000000000000000000B000000
    000B000000000000000000000B000000000B000000000000000000000B000000
    000B000000000000000000000B000000000B000000000000000000000B000000
    BBBBBBB000000000000000000B000000000B000000000000000000000B000000
    000B000000000000000000000B000000000B000000000000000000000B000000
    00BBB00000000000000000000B000000BB000BB000000000000000000B000000
    B00000B000000000000000000B00000B0000000B00000000000000000B00000B
    0000000B00000000000000000B00000B0000000B00000000000000000B000000
    B00000B000000000000000000B000000BB000BB000000000000000000B000000
    00BBB00000000000000000000B000000000B000000000000000000000B000000
    000B000000000000000000000B000000000BBBBBBBBBBBBBBBBBBBBBBB000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFF0000003FFFFFFFBFFFFFFFBCFE7FFFBE7CFFFFBF39FFFFBF93F
    FFFBFC7FFFFBFEFFFFFBFEFFFFFBFEFFFFFBFEFFFFFBF01FFFFBFEFFFFFBFEFF
    FFFBFEFFFFFBFC7FFFFBF39FFFFBF7DFFFFBEFEFFFFBEFEFFFFBEFEFFFFBF7DF
    FFFBF39FFFFBFC7FFFFBFEFFFFFBFEFFFFFBFE000003FFFFFFFFFFFFFFFF}
  KeyPreview = True
  Menu = MainMainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object HangmanImage: TImage
    Left = 8
    Top = 72
    Width = 272
    Height = 220
    Visible = False
  end
  object WordPanel: TPanel
    Left = 8
    Top = 35
    Width = 272
    Height = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object ScorePanel: TPanel
    Left = 8
    Top = 8
    Width = 272
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object DifficultyLevelRadioGroup: TRadioGroup
    Left = 8
    Top = 354
    Width = 121
    Height = 105
    Caption = 'Difficulty &Level'
    Items.Strings = (
      'Easy'
      'Normal'
      'Hard')
    TabOrder = 2
  end
  object NewGameButton: TButton
    Left = 170
    Top = 378
    Width = 75
    Height = 25
    Caption = 'New Game'
    TabOrder = 0
    OnClick = NewGameButtonClick
  end
  object EndGameButton: TButton
    Left = 170
    Top = 408
    Width = 75
    Height = 25
    Caption = 'End Game'
    TabOrder = 1
    OnClick = EndGameButtonClick
  end
  object HangmanMediaPlayer: TMediaPlayer
    Left = 16
    Top = 304
    Width = 253
    Height = 30
    Visible = False
    TabOrder = 5
  end
  object MainMainMenu: TMainMenu
    Left = 240
    Top = 248
    object FileMenuItem: TMenuItem
      Caption = '&File'
      object FileLoginMenuItem: TMenuItem
        Caption = '&Login'
        OnClick = FileLoginMenuItemClick
      end
      object FileLogoutMenuItem: TMenuItem
        Caption = 'L&ogout'
        OnClick = FileLogoutMenuItemClick
      end
      object SeperatorMenuItem1: TMenuItem
        Caption = '-'
      end
      object FileExitMenuItem: TMenuItem
        Caption = 'E&xit'
        OnClick = FileExitMenuItemClick
      end
    end
    object GameMenuItem: TMenuItem
      Caption = '&Game'
      object GameNewGameMenuItem: TMenuItem
        Caption = '&New Game'
        OnClick = GameNewGameMenuItemClick
      end
      object GameEndGameMenuItem: TMenuItem
        Caption = '&End Game'
        OnClick = GameEndGameMenuItemClick
      end
      object SeperatorMenuItem2: TMenuItem
        Caption = '-'
      end
      object GameReportsMenuItem: TMenuItem
        Caption = '&Reports'
        OnClick = GameReportsMenuItemClick
      end
    end
    object HelpMenuItem: TMenuItem
      Caption = '&Help'
      object HelpAboutMenuItem: TMenuItem
        Caption = '&About'
        OnClick = HelpAboutMenuItemClick
      end
    end
  end
  object SplashScreenTimer: TTimer
    OnTimer = SplashScreenTimerTimer
    Left = 240
    Top = 208
  end
end
