unit ControllerEndereco;

interface

uses
  System.SysUtils, System.Classes, System.Json, System.Generics.Collections,
  Data.DB, Web.HTTPApp, Data.DBXPlatform,
  DataSnap.DSProviderDataModuleAdapter, DataSnap.DSServer, DataSnap.DSAuth,
  DataSnap.DSHTTPWebBroker,
  FireDAC.Stan.Option;

type
  TControllerEndereco = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }

    function Enderecos: TJSONArray;
    function UpdateEnderecos: TJSONArray;
    function AcceptEnderecos: TJSONArray;
    function CancelEnderecos: TJSONArray;
  end;

implementation

{$R *.dfm}

uses
  // https://github.com/viniciussanchez/dataset-serialize
  DataSet.Serialize,
  WebModule, ModelConexao, ModelEnderecos;

{ TControllerEndereco }

function TControllerEndereco.Enderecos: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  Enderecos: TDMEnderecos;

  filtro: TPair<string, string>;
  idPaginacao: Int64;
begin
  Result := nil;
  Enderecos := nil;

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

      if filtro.Key.Length = 0 then
      begin
        GetInvocationMetadata().ResponseCode := 202;
        GetInvocationMetadata().ResponseMessage :=
          'Filtro não informado ou inválido';
        Exit;
      end;

      Enderecos := TDMEnderecos.Create(DMConexao.FDPostgre);
      Result := Enderecos.Get(filtro, idPaginacao);

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
    if Enderecos <> nil then
      FreeAndNil(Enderecos);
  end;
end;

function TControllerEndereco.UpdateEnderecos: TJSONArray;
var
  lModulo: TWebModule;
  lJARequisicao: TJSONArray;

  endereco: TDMEnderecos;
  ultimaId: Integer;
begin
  Result := nil;
  endereco := nil;

  try
    try
      lModulo := GetDataSnapWebModule;

      if lModulo.Request.content.IsEmpty then
      begin
        GetInvocationMetadata().ResponseCode := 204;
        GetInvocationMetadata().ResponseMessage := '204 No Content';
        Abort;
      end;

      lJARequisicao := TJSONObject.ParseJSONValue
        (TEncoding.ASCII.GetBytes(lModulo.Request.content), 0) as TJSONArray;

      if lJARequisicao.Count < 1 then
      begin
        GetInvocationMetadata().ResponseCode := 202;
        GetInvocationMetadata().ResponseMessage := '202 Accepted';
        Exit;
      end;

      endereco := TDMEnderecos.Create(DMConexao.FDPostgre);

      ultimaId := endereco.Insert(lJARequisicao);

      Result := TJSONArray.Create
        (TJSONObject.Create(TJSONPair.Create('ultimaId', ultimaId.ToString)));

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
    if endereco <> nil then
      FreeAndNil(endereco);
  end;
end;

function TControllerEndereco.AcceptEnderecos: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  lModulo: TWebModule;
  lJARequisicao: TJSONArray;

  endereco: TDMEnderecos;
  qId: Int64;
begin
  Result := nil;
  endereco := nil;

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

      lJARequisicao := TJSONObject.ParseJSONValue
        (TEncoding.ASCII.GetBytes(lModulo.Request.content), 0) as TJSONArray;

      if lJARequisicao.Count <> 1 then
      begin
        GetInvocationMetadata().ResponseCode := 202;
        GetInvocationMetadata().ResponseMessage := 'Endereço não informado';
        Exit;
      end;

      endereco := TDMEnderecos.Create(DMConexao.FDPostgre);

      endereco.Update(qId, lJARequisicao);

      Result := TJSONArray.Create('message', 'Alterado realizada com sucesso');

      GetInvocationMetadata().ResponseCode := 200;
      GetInvocationMetadata().ResponseContent := Result.ToString;
    except
      on E: Exception do
      begin
        GetInvocationMetadata().ResponseCode := 500;
        GetInvocationMetadata().ResponseMessage :=
          '500 - Internal Server Error';
      end;
    end;
  finally
    if endereco <> nil then
      FreeAndNil(endereco);
  end;
end;

function TControllerEndereco.CancelEnderecos: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  endereco: TDMEnderecos;

  qId: Int64;
begin
  Result := nil;
  endereco := nil;

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

      endereco := TDMEnderecos.Create(DMConexao.FDPostgre);

      endereco.Delete(qId);

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
    if endereco <> nil then
      FreeAndNil(endereco);
  end;
end;

end.
