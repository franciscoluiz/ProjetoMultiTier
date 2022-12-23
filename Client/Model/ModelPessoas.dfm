object DMPessoas: TDMPessoas
  OldCreateOrder = False
  Height = 217
  Width = 262
  object Adapter: TRESTResponseDataSetAdapter
    Active = True
    Dataset = DataSet
    FieldDefs = <>
    Response = Response
    Left = 96
    Top = 152
  end
  object DataSet: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'idpessoa'
        DataType = ftLargeint
      end
      item
        Name = 'flnatureza'
        DataType = ftSmallint
      end
      item
        Name = 'dsdocumento'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nmprimeiro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'nmsegundo'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'dtregistro'
        DataType = ftDate
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 168
    Top = 48
    object DataSetidpessoa: TLargeintField
      DisplayLabel = 'ID'
      FieldName = 'idpessoa'
    end
    object DataSetflnatureza: TSmallintField
      DisplayLabel = 'Natureza'
      FieldName = 'flnatureza'
    end
    object DataSetdsdocumento: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'dsdocumento'
    end
    object DataSetnmprimeiro: TStringField
      DisplayLabel = 'Primeiro nome'
      DisplayWidth = 30
      FieldName = 'nmprimeiro'
      Size = 100
    end
    object DataSetnmsegundo: TStringField
      DisplayLabel = 'Segundo Nome'
      DisplayWidth = 30
      FieldName = 'nmsegundo'
      Size = 100
    end
    object DataSetdtregistro: TDateField
      DisplayLabel = 'Dt. Registro'
      FieldName = 'dtregistro'
      EditMask = '!99/99/0000;1;_'
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 168
    Top = 96
  end
  object Client: TRESTClient
    BaseURL = 'http://localhost:8080/wk/rest/TControllerPessoa'
    Params = <>
    Left = 96
    Top = 8
  end
  object Request: TRESTRequest
    Client = Client
    Params = <>
    Resource = 'pessoas'
    Response = Response
    SynchronizedEvents = False
    Left = 96
    Top = 56
  end
  object Response: TRESTResponse
    Left = 96
    Top = 104
  end
end
