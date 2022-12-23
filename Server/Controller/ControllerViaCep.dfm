object ControllerViaCep: TControllerViaCep
  OldCreateOrder = False
  Height = 109
  Width = 304
  object RESTClient: TRESTClient
    Params = <>
    Left = 34
    Top = 7
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 34
    Top = 51
  end
  object RESTResponse: TRESTResponse
    Left = 170
    Top = 7
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Left = 170
    Top = 51
  end
end
