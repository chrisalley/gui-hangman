object NewPlayerDialog: TNewPlayerDialog
  Left = 645
  Top = 294
  BorderStyle = bsDialog
  Caption = 'New Player'
  ClientHeight = 177
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object WelcomeLabel: TLabel
    Left = 6
    Top = 8
    Width = 3
    Height = 13
  end
  object FirstNameLabeledEdit: TLabeledEdit
    Left = 8
    Top = 72
    Width = 265
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = '&First Name'
    TabOrder = 0
    OnChange = FirstNameLabeledEditChange
  end
  object LastNameLabeledEdit: TLabeledEdit
    Left = 8
    Top = 112
    Width = 265
    Height = 21
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = '&Last Name'
    TabOrder = 1
    OnChange = LastNameLabeledEditChange
    OnEnter = LastNameLabeledEditEnter
  end
  object OKButton: TButton
    Left = 112
    Top = 144
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Cancel: TButton
    Left = 192
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
