object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 106
  Width = 320
  object DSServer: TDSServer
    Left = 32
    Top = 37
  end
  object DSSCPessoa: TDSServerClass
    OnGetClass = DSSCPessoaGetClass
    Server = DSServer
    Left = 120
    Top = 6
  end
  object DSSVEndereco: TDSServerClass
    OnGetClass = DSSVEnderecoGetClass
    Server = DSServer
    Left = 120
    Top = 54
  end
  object DSSCViaCep: TDSServerClass
    OnGetClass = DSSCViaCepGetClass
    Server = DSServer
    Left = 232
    Top = 6
  end
  object DSSAtualizaCepEmLote: TDSServerClass
    OnGetClass = DSSAtualizaCepEmLoteGetClass
    Server = DSServer
    Left = 232
    Top = 54
  end
end
