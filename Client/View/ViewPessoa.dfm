object frmPessoa: TfrmPessoa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 338
  ClientWidth = 949
  Color = clBtnFace
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
  object pLateral: TPanel
    Left = 0
    Top = 302
    Width = 949
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      949
      36)
    object btnAnterior: TSpeedButton
      Left = 5
      Top = 5
      Width = 90
      Height = 26
      Caption = 'Anterior'
      OnClick = btnAnteriorClick
    end
    object btnProximo: TSpeedButton
      Left = 100
      Top = 5
      Width = 90
      Height = 26
      Caption = 'Proximo'
      OnClick = btnProximoClick
    end
    object btnAdicionar: TSpeedButton
      Left = 474
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      OnClick = btnAdicionarClick
      ExplicitLeft = 309
    end
    object btnEditar: TSpeedButton
      Left = 664
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Editar'
      OnClick = btnEditarClick
      ExplicitLeft = 499
    end
    object btnDeletar: TSpeedButton
      Left = 568
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Deletar'
      OnClick = btnDeletarClick
      ExplicitLeft = 329
    end
    object btnFechar: TSpeedButton
      Left = 854
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      OnClick = btnFecharClick
      ExplicitLeft = 711
    end
    object btnSalvar: TSpeedButton
      Left = 759
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Salvar'
      OnClick = btnSalvarClick
      ExplicitLeft = 594
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 92
    Width = 949
    Height = 210
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 949
    Height = 92
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = -6
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 17
      Height = 19
      Caption = 'ID'
    end
    object Label2: TLabel
      Left = 115
      Top = 5
      Width = 62
      Height = 19
      Caption = 'Natureza'
    end
    object Label3: TLabel
      Left = 269
      Top = 5
      Width = 81
      Height = 19
      Caption = 'Documento'
    end
    object Label4: TLabel
      Left = 466
      Top = 5
      Width = 42
      Height = 19
      Caption = 'Nome'
    end
    object Label5: TLabel
      Left = 710
      Top = 5
      Width = 81
      Height = 19
      Caption = 'Sobrenome'
    end
    object Label6: TLabel
      Left = 0
      Top = 67
      Width = 949
      Height = 25
      Align = alBottom
      Alignment = taCenter
      Caption = 'Endere'#231'os'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 96
    end
    object edtId: TEdit
      Left = 5
      Top = 25
      Width = 100
      Height = 27
      Alignment = taCenter
      ReadOnly = True
      TabOrder = 0
    end
    object edtDocumento: TEdit
      Left = 268
      Top = 25
      Width = 189
      Height = 27
      MaxLength = 20
      TabOrder = 2
    end
    object edtNome: TEdit
      Left = 466
      Top = 25
      Width = 236
      Height = 27
      MaxLength = 100
      TabOrder = 3
    end
    object edtSobrenome: TEdit
      Left = 708
      Top = 25
      Width = 236
      Height = 27
      MaxLength = 100
      TabOrder = 4
    end
    object cbNatureza: TComboBox
      Left = 115
      Top = 25
      Width = 145
      Height = 27
      Style = csDropDownList
      TabOrder = 1
    end
  end
end
