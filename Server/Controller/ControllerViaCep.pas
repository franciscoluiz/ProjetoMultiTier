unit ControllerViaCep;

interface

uses
  System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter, DataSnap.DSServer, DataSnap.DSAuth,
  DataSnap.DSHTTPWebBroker,
  Data.DBXPlatform, Data.DB, Data.Bind.Components, Data.Bind.ObjectScope,
  Web.HTTPApp,
  FireDAC.Stan.Option,
  REST.Types, REST.Response.Adapter, REST.Client;

type
  TControllerViaCep = class(TDSServerModule)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
  private
    { Private declarations }
  public
    { Public declarations }
    function ConsultaCep(aCEP: string): TJSONArray; overload;
  end;

implementation

{$R *.dfm}

uses
  // https://github.com/viniciussanchez/dataset-serialize
  DataSet.Serialize,
  WebModule;

{ TControllerViaCep }

function TControllerViaCep.ConsultaCep(aCEP: string): TJSONArray;
var
  sTemp: string;
begin
  try
    RESTClient.BaseURL := 'https://viacep.com.br/ws/' + aCEP + '/json/';
    RESTRequest.Execute;

    if not RESTRequest.Response.Status.Success then
    begin
      GetInvocationMetadata().ResponseCode := 204;
      GetInvocationMetadata().ResponseMessage := '204 - No Content';
      Abort;
    end;

    if RESTRequest.Response.JSONValue = nil then
    begin
      GetInvocationMetadata().ResponseCode := 204;
      GetInvocationMetadata().ResponseMessage := '204 - No Content';
      Abort;
    end;

    sTemp := RESTRequest.Response.JSONValue.ToString;
    sTemp := '[' + sTemp + ']';
    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(sTemp), 0) as TJSONArray;

    GetInvocationMetadata().ResponseCode := 200;
    GetInvocationMetadata().ResponseContent := Result.ToString;
  except
    on E: Exception do
    begin
      GetInvocationMetadata().ResponseCode := 500;
      GetInvocationMetadata().ResponseMessage := '500 - Internal Server Error';
    end;
  end;
end;

end.
