object DMConexao: TDMConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 139
  Width = 126
  object FDPostgre: TFDConnection
    Params.Strings = (
      'Database=postgres'
      'User_Name=postgres'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files\PostgreSQL\15\bin\libpq.dll'
    Left = 48
    Top = 64
  end
end
