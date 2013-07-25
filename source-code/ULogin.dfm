object LoginForm: TLoginForm
  Left = 507
  Top = 341
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 217
  ClientWidth = 240
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
  object LoginLabel: TLabel
    Left = 8
    Top = 96
    Width = 224
    Height = 26
    Caption = 
      'Enter your login here, or if you are a new player enter a login ' +
      'name to register on the database.'
    WordWrap = True
  end
  object LoginRadioGroup: TRadioGroup
    Left = 8
    Top = 8
    Width = 225
    Height = 73
    Items.Strings = (
      'I am registered on the database'
      'I am a new player')
    TabOrder = 3
  end
  object LoginNameLabeledEdit: TLabeledEdit
    Left = 8
    Top = 152
    Width = 225
    Height = 21
    EditLabel.Width = 57
    EditLabel.Height = 13
    EditLabel.Caption = '&Login Name'
    TabOrder = 0
    OnChange = LoginNameLabeledEditChange
    OnEnter = LoginNameLabeledEditEnter
  end
  object OKButton: TButton
    Left = 72
    Top = 184
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 152
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
