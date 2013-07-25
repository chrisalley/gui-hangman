object ReportsDialog: TReportsDialog
  Left = 440
  Top = 397
  BorderStyle = bsDialog
  Caption = 'Reports'
  ClientHeight = 131
  ClientWidth = 327
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
  object ReportTypeRadioGroup: TRadioGroup
    Left = 16
    Top = 16
    Width = 185
    Height = 97
    Caption = 'Report Type'
    Items.Strings = (
      'Player Report (Your Statistics)'
      'Game Report'
      'All Games Report')
    TabOrder = 0
  end
  object PrintPreviewButton: TButton
    Left = 216
    Top = 24
    Width = 89
    Height = 25
    Caption = 'Print / Preview'
    TabOrder = 1
    OnClick = PrintPreviewButtonClick
  end
  object CloseButton: TButton
    Left = 216
    Top = 56
    Width = 89
    Height = 25
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 2
  end
end
