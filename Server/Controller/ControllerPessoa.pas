unit ControllerPessoa;

interface

uses
  System.SysUtils, System.Classes, System.Json, System.Generics.Collections,
  DataSnap.DSProviderDataModuleAdapter, DataSnap.DSServer,
  DataSnap.DSAuth, DataSnap.DSHTTPWebBroker,
  Data.DBXPlatform, Data.DB,
  Web.HTTPApp,
  FireDAC.Stan.Option;

type
  TControllerPessoa = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function Pessoas: TJSONArray;
    function UpdatePessoas: TJSONArray;
    function AcceptPessoas: TJSONArray;
    function CancelPessoas: TJSONArray;
  end;

implementation

{$R *.dfm}

uses
  // https://github.com/viniciussanchez/dataset-serialize
  DataSet.Serialize,
  WebModule, ModelConexao, ModelPessoas;

{ TControllerPessoa }

function TControllerPessoa.Pessoas: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  Pessoas: TDMPessoas;

  filtro: TPair<string, string>;
  idPaginacao: Int64;
begin
  Result := nil;
  Pessoas := nil;

  filtro.Key := '';
  filtro.Value := '';

  idPaginacao := -1;

  try
    try
      metaData := GetInvocationMetadata;

      if metaData.QueryParams.IndexOfName('qCampo') > -1 then
        filtro.Key := metaData.QueryParams.Values['qCampo'];

      if metaData.QueryParams.IndexOfName('qValor') > -1 then
        filtro.Value := metaData.QueryParams.Values['qValor'];

      if metaData.QueryParams.IndexOfName('qIdPaginacao') > -1 then
        idPaginacao := StrToInt64(metaData.QueryParams.Values['qIdPaginacao']);

      Pessoas := TDMPessoas.Create(DMConexao.FDPostgre);

      Result := Pessoas.Get(filtro, idPaginacao);

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
    if Pessoas <> nil then
      FreeAndNil(Pessoas);
  end;
end;

function TControllerPessoa.UpdatePessoas: TJSONArray;
var
  lModulo: TWebModule;
  lJARequisicao: TJSONArray;

  Pessoas: TDMPessoas;
  ultimaId: Integer;
begin
  Result := nil;
  Pessoas := nil;

  try
    try
      lModulo := GetDataSnapWebModule;

      if lModulo.Request.content.IsEmpty then
      begin
        GetInvocationMetadata().ResponseCode := 204;
        GetInvocationMetadata().ResponseMessage := '204 No Content';
        Abort;
      end;

      lJARequisicao := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lModulo.Request.content), 0) as TJSONArray;

      if lJARequisicao.Count < 1 then
      begin
        GetInvocationMetadata().ResponseCode := 202;
        GetInvocationMetadata().ResponseMessage := '202 Accepted';
        Exit;
      end;

      Pessoas := TDMPessoas.Create(DMConexao.FDPostgre);

      ultimaId := Pessoas.Insert(lJARequisicao);

      Result := TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('ultimaId', ultimaId.ToString)));

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
    if Pessoas <> nil then
      FreeAndNil(Pessoas);
  end;
end;

function TControllerPessoa.AcceptPessoas: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  lModulo: TWebModule;
  lJARequisicao: TJSONArray;

  Pessoas: TDMPessoas;
  qId: Int64;
begin
  { PUT NO HTTP }
  Result := nil;
  Pessoas := nil;

  qId := -1;

  try
    try
      metaData := GetInvocationMetadata;

      if metaData.QueryParams.IndexOfName('qId') > -1 then
        qId := StrToInt64(metaData.QueryParams.Values['qId']);

      if qId < 1 then
      begin
        GetInvocationMetadata().ResponseCode := 202;
        GetInvocationMetadata().ResponseMessage := 'Id inválido ou não informado';
        Exit;
      end;

      lModulo := GetDataSnapWebModule;

      if lModulo.Request.content.IsEmpty then
      begin
        GetInvocationMetadata().ResponseCode := 204;
        GetInvocationMetadata().ResponseMessage := '204 No Content';
        Exit;
      end;

      lJARequisicao := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lModulo.Request.content), 0) as TJSONArray;

      if lJARequisicao.Count <> 1 then
      begin
        GetInvocationMetadata().ResponseCode := 202;
        GetInvocationMetadata().ResponseMessage := '202 Accepted';
        Exit;
      end;

      Pessoas := TDMPessoas.Create(DMConexao.FDPostgre);

      Pessoas.Update(qId, lJARequisicao);

      Result := TJSONArray.Create('message', 'Registro alterado.');

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
    if Pessoas <> nil then
      FreeAndNil(Pessoas);
  end;
end;

function TControllerPessoa.CancelPessoas: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  Pessoas: TDMPessoas;

  qId: Int64;
begin
  { DELETE NO HTTP }
  Result := nil;
  Pessoas := nil;

  qId := -1;

  try
    try
      metaData := GetInvocationMetadata;

      if metaData.QueryParams.IndexOfName('qId') > -1 then
        qId := StrToInt64(metaData.QueryParams.Values['qId']);

      if qId < 1 then
      begin
        GetInvocationMetadata().ResponseCode := 202;
        GetInvocationMetadata().ResponseMessage := 'Id inválido ou não informado';
        Exit;
      end;

      Pessoas := TDMPessoas.Create(DMConexao.FDPostgre);

      Pessoas.Delete(qId);

      Result := TJSONArray.Create('message', 'Registro apagado.');

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
    if Pessoas <> nil then
      FreeAndNil(Pessoas);
  end;
end;

end.
