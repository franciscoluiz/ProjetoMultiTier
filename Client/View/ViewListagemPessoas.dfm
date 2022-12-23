object frmListagemPessoas: TfrmListagemPessoas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 484
  ClientWidth = 958
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
    Top = 448
    Width = 958
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      958
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
      Left = 578
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      OnClick = btnAdicionarClick
      ExplicitLeft = 366
    end
    object btnEditar: TSpeedButton
      Left = 768
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Editar'
      OnClick = btnEditarClick
      ExplicitLeft = 556
    end
    object btnDeletar: TSpeedButton
      Left = 673
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Deletar'
      OnClick = btnDeletarClick
      ExplicitLeft = 461
    end
    object btnFechar: TSpeedButton
      Left = 863
      Top = 5
      Width = 90
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Sair'
      OnClick = btnFecharClick
      ExplicitLeft = 651
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 0
    Width = 958
    Height = 448
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
end
