object DMViaCep: TDMViaCep
  OldCreateOrder = False
  Height = 217
  Width = 306
  object Adapter: TRESTResponseDataSetAdapter
    Active = True
    Dataset = DataSet
    FieldDefs = <>
    Response = Response
    Left = 80
    Top = 152
  end
  object DataSet: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'cep'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'logradouro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'complemento'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'localidade'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'uf'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ibge'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'gia'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ddd'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'siafi'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 200
    Top = 8
    object DataSetcep: TStringField
      FieldName = 'cep'
      Size = 15
    end
    object DataSetlogradouro: TStringField
      FieldName = 'logradouro'
      Size = 100
    end
    object DataSetcomplemento: TStringField
      FieldName = 'complemento'
      Size = 100
    end
    object DataSetbairro: TStringField
      FieldName = 'bairro'
      Size = 100
    end
    object DataSetlocalidade: TStringField
      FieldName = 'localidade'
      Size = 100
    end
    object DataSetuf: TStringField
      FieldName = 'uf'
      Size = 50
    end
    object DataSetibge: TStringField
      FieldName = 'ibge'
      Size = 10
    end
    object DataSetgia: TStringField
      FieldName = 'gia'
      Size = 10
    end
    object DataSetddd: TStringField
      FieldName = 'ddd'
      Size = 2
    end
    object DataSetsiafi: TStringField
      FieldName = 'siafi'
      Size = 10
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 200
    Top = 56
  end
  object Client: TRESTClient
    BaseURL = 'http://localhost:8080/wk/rest/TControllerViaCep'
    Params = <>
    Left = 80
    Top = 8
  end
  object Request: TRESTRequest
    Client = Client
    Params = <>
    Resource = 'consultacep'
    Response = Response
    SynchronizedEvents = False
    Left = 80
    Top = 56
  end
  object Response: TRESTResponse
    Left = 80
    Top = 104
  end
end
