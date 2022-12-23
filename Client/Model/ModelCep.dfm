object DMCep: TDMCep
  OldCreateOrder = False
  Height = 254
  Width = 278
  object Client: TRESTClient
    BaseURL = 'http://localhost:8080/wk/rest/TControllerCepEmLote'
    Params = <>
    Left = 80
    Top = 16
  end
  object Request: TRESTRequest
    Client = Client
    Params = <>
    Resource = 'Atualizar/'
    Response = Response
    SynchronizedEvents = False
    Left = 80
    Top = 64
  end
  object Response: TRESTResponse
    Left = 80
    Top = 120
  end
  object Adapter: TRESTResponseDataSetAdapter
    Dataset = DataSet
    FieldDefs = <>
    Response = Response
    Left = 80
    Top = 176
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 152
    Top = 104
  end
  object DataSet: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 152
    Top = 56
    object DataSetquantidade: TIntegerField
      FieldName = 'quantidade'
    end
  end
end
