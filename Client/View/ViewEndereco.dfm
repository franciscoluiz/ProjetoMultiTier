object frmEndereco: TfrmEndereco
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Endere'#231'o'
  ClientHeight = 309
  ClientWidth = 457
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 19
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 28
    Height = 19
    Caption = 'CEP'
  end
  object Label4: TLabel
    Left = 104
    Top = 8
    Width = 47
    Height = 19
    Caption = 'Estado'
  end
  object Label1: TLabel
    Left = 8
    Top = 58
    Width = 48
    Height = 19
    Caption = 'Cidade'
  end
  object Bairro: TLabel
    Left = 8
    Top = 108
    Width = 42
    Height = 19
    Caption = 'Bairro'
  end
  object Label2: TLabel
    Left = 8
    Top = 158
    Width = 82
    Height = 19
    Caption = 'Logradouro'
  end
  object Label5: TLabel
    Left = 8
    Top = 208
    Width = 99
    Height = 19
    Caption = 'Complemento'
  end
  object btnSalvar: TSpeedButton
    Left = 258
    Top = 275
    Width = 90
    Height = 26
    Caption = 'Salvar'
    OnClick = btnSalvarClick
  end
  object btmFechar: TSpeedButton
    Left = 354
    Top = 275
    Width = 90
    Height = 26
    Caption = 'Fechar'
    OnClick = btmFecharClick
  end
  object edtEstado: TEdit
    Left = 104
    Top = 28
    Width = 340
    Height = 27
    MaxLength = 50
    TabOrder = 1
  end
  object edtCidade: TEdit
    Left = 8
    Top = 78
    Width = 436
    Height = 27
    MaxLength = 100
    TabOrder = 2
  end
  object edtBairro: TEdit
    Left = 8
    Top = 125
    Width = 436
    Height = 27
    MaxLength = 50
    TabOrder = 3
  end
  object edtLogradouro: TEdit
    Left = 5
    Top = 178
    Width = 439
    Height = 27
    MaxLength = 100
    TabOrder = 4
  end
  object edtComplemento: TEdit
    Left = 5
    Top = 228
    Width = 439
    Height = 27
    MaxLength = 100
    TabOrder = 5
  end
  object edtCep: TEdit
    Left = 8
    Top = 28
    Width = 90
    Height = 27
    MaxLength = 8
    TabOrder = 0
    OnExit = edtCepExit
    OnKeyPress = edtCepKeyPress
  end
end
