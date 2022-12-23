unit ControllerCepEmLote;

interface

uses
  System.SysUtils, System.Classes, System.Json, System.Generics.Collections,
  DataSnap.DSProviderDataModuleAdapter, DataSnap.DSServer, DataSnap.DSAuth,
  Data.DBXPlatform, DataSnap.DSHTTPWebBroker, Data.DB,
  Data.Bind.Components, Data.Bind.ObjectScope,
  Web.HTTPApp,
  FireDAC.Stan.Option,
  REST.Types, REST.Response.Adapter, REST.Client,
  ModelConexao, ModelEnderecos, TOEndereco;

type
  TControllerCepEmLote = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function Atualizar: TJSONArray;
  end;

implementation

{$R *.dfm}

uses
  // https://github.com/viniciussanchez/dataset-serialize
  DataSet.Serialize,
  WebModule, ControllerViaCep;

{ TControllerCepEmLote }

function TControllerCepEmLote.Atualizar: TJSONArray;
var
  daoEnderecos: TDMEnderecos;
  lstEnderecos: TObjectList<TTOEndereco>;
  dtoEndereco: TTOEndereco;
  SMViaCep: TControllerViaCep;
  jsonArray: TJSONArray;
  jsonObj: TJSONObject;

  qtde: Integer;
begin
  daoEnderecos := nil;
  lstEnderecos := nil;
  dtoEndereco := nil;
  SMViaCep := nil;
  jsonArray := nil;
  jsonObj := nil;

  try
    try
      daoEnderecos := TDMEnderecos.Create(DMConexao.FDPostgre);

      lstEnderecos := daoEnderecos.GetCeps;

      SMViaCep := TControllerViaCep.Create(Self);

      for dtoEndereco in lstEnderecos do
      begin
        jsonArray := SMViaCep.ConsultaCep(dtoEndereco.Cep);
        jsonObj := (jsonArray.Items[0] as TJSONObject);

        if jsonObj.Count < 2 then
          Continue;

        dtoEndereco.Uf := jsonObj.GetValue<string>('uf');
        dtoEndereco.Cidade := jsonObj.GetValue<string>('localidade');
        dtoEndereco.Bairro := jsonObj.GetValue<string>('bairro');
        dtoEndereco.Logradouro := jsonObj.GetValue<string>('logradouro');
        dtoEndereco.Complemento := jsonObj.GetValue<string>('complemento');
        Inc(qtde);
      end;

      qtde := daoEnderecos.AtualizaCeps(lstEnderecos);

      Result := TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('quantidade', qtde.ToString)));

      GetInvocationMetadata().ResponseCode := 200;
      GetInvocationMetadata().ResponseContent := Result.ToString;
    except
      on E: Exception do
      begin
        GetInvocationMetadata().ResponseCode := 500;
        GetInvocationMetadata().ResponseMessage := '500 - Internal Server Error';
      end;
    end;
  finally
    if daoEnderecos <> nil then
      FreeAndNil(daoEnderecos);

    if lstEnderecos <> nil then
      FreeAndNil(lstEnderecos);

    if SMViaCep <> nil then
      FreeAndNil(SMViaCep);
  end;
end;

end.
