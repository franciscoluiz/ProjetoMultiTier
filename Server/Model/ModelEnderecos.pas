unit ModelEnderecos;

interface

uses
  System.SysUtils, System.Generics.Collections, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Data.DB,
  TOEndereco;

type
  TDMEnderecos = class
  private
    fConector: TFDConnection;
  public
    function AtualizaCeps(aLstEnderecos: TObjectList<TTOEndereco>): Integer;
    function GetCeps: TObjectList<TTOEndereco>;
    function Get(const aFiltro: TPair<string, string>; aIdPaginacao: Int64 = -1): TJSONArray;
    function Insert(aJsonArray: TJSONArray): Integer;
    function Update(const aId: Int64; aJsonArray: TJSONArray): Integer;
    function Delete(const aId: Int64): Integer;

    constructor Create(aConector: TFDConnection);
    destructor Destroy; override;
  published
  end;

implementation

{ TDMEnderecos }

// https://github.com/viniciussanchez/dataset-serialize
uses DataSet.Serialize;

function TDMEnderecos.AtualizaCeps(aLstEnderecos: TObjectList<TTOEndereco>): Integer;
var
  fdqEndereco: TFDQuery;
  dtoEndereco: TTOEndereco;

  I: Integer;
begin
  fdqEndereco := nil;

  try
    try
      fdqEndereco := TFDQuery.Create(nil);
      fdqEndereco.Connection := fConector;
      fdqEndereco.SQL.Add('UPDATE projetomultitier.endereco_integracao i');
      fdqEndereco.SQL.Add('   SET dsuf = :dsuf,');
      fdqEndereco.SQL.Add('       nmcidade = :nmcidade,');
      fdqEndereco.SQL.Add('       nmbairro = :nmbairro,');
      fdqEndereco.SQL.Add('       nmlogradouro = :nmlogradouro,');
      fdqEndereco.SQL.Add('       dscomplemento = :dscomplemento');
      fdqEndereco.SQL.Add('  FROM projetomultitier.endereco AS e');
      fdqEndereco.SQL.Add(' WHERE e.idendereco = i.idendereco');
      fdqEndereco.SQL.Add('   AND e.dsCep = :dsCep');

      fdqEndereco.Params.ArraySize := aLstEnderecos.Count;

      fConector.StartTransaction;

      for I := 0 to aLstEnderecos.Count - 1 do
      begin
        dtoEndereco := aLstEnderecos[I];

        fdqEndereco.ParamByName('dsuf').AsStrings[I] := dtoEndereco.Uf;
        fdqEndereco.ParamByName('nmcidade').AsStrings[I] := dtoEndereco.Cidade;
        fdqEndereco.ParamByName('nmbairro').AsStrings[I] := dtoEndereco.Bairro;
        fdqEndereco.ParamByName('nmlogradouro').AsStrings[I] := dtoEndereco.Logradouro;
        fdqEndereco.ParamByName('dscomplemento').AsStrings[I] := dtoEndereco.Complemento;
        fdqEndereco.ParamByName('dsCep').AsStrings[I] := dtoEndereco.Cep;
      end;

      if aLstEnderecos.Count > 0 then
        fdqEndereco.Execute(aLstEnderecos.Count);

      fConector.Commit;

      Result := aLstEnderecos.Count;
    except
      on E: Exception do
      begin
        fConector.Rollback;

        raise;
      end;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco);
  end;
end;

constructor TDMEnderecos.Create(aConector: TFDConnection);
begin
  fConector := aConector;
end;

destructor TDMEnderecos.Destroy;
begin

  inherited;
end;

function TDMEnderecos.Get(const aFiltro: TPair<string, string>; aIdPaginacao: Int64 = -1): TJSONArray;
var
  fdqEndereco: TFDQuery;
  sql: string;
begin
  Result := nil;

  fdqEndereco := nil;

  try
    try
      fdqEndereco := TFDQuery.Create(nil);
      fdqEndereco.Connection := fConector;
      fdqEndereco.SQL.Add('SELECT e.idendereco,');
      fdqEndereco.SQL.Add('       e.idpessoa,');
      fdqEndereco.SQL.Add('       e.dscep,');
      fdqEndereco.SQL.Add('       i.dsuf,');
      fdqEndereco.SQL.Add('       i.nmcidade,');
      fdqEndereco.SQL.Add('       i.nmbairro,');
      fdqEndereco.SQL.Add('       i.nmlogradouro,');
      fdqEndereco.SQL.Add('       i.dscomplemento');
      fdqEndereco.SQL.Add('  FROM projetomultitier.endereco AS e ');
      fdqEndereco.SQL.Add('       JOIN projetomultitier.endereco_integracao AS i ON (i.idendereco = e.idendereco)');
      fdqEndereco.SQL.Add(' WHERE e.' + aFiltro.Key + ' = ' + aFiltro.Value);

      if aIdPaginacao > -1 then
        fdqEndereco.SQL.Add('AND e.idendereco >= ' + aIdPaginacao.ToString);

      fdqEndereco.SQL.Add('ORDER BY e.idendereco');

      if (aIdPaginacao > -1) then
        fdqEndereco.SQL.Add('LIMIT 100');

      fdqEndereco.Open;

      Result := fdqEndereco.ToJsonArray;
    except
      on E: Exception do
        raise;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco)
  end;
end;

function TDMEnderecos.GetCeps: TObjectList<TTOEndereco>;
var
  fdqEndereco: TFDQuery;
begin
  Result := TObjectList<TTOEndereco>.Create;

  fdqEndereco := nil;

  try
    try
      fdqEndereco := TFDQuery.Create(nil);
      fdqEndereco.Connection := fConector;
      fdqEndereco.SQL.Add('SELECT dscep');
      fdqEndereco.SQL.Add('  FROM projetomultitier.endereco');
      fdqEndereco.SQL.Add(' GROUP BY dscep');
      fdqEndereco.Open;

      while not fdqEndereco.Eof do
      begin
        if fdqEndereco.FieldByName('dscep').AsString.Length <> 8 then
        begin
          fdqEndereco.Next;
          Continue;
        end;

        Result.Add(TTOEndereco.Create(fdqEndereco.FieldByName('dscep').AsString));
        fdqEndereco.Next;
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco)
  end;
end;

function TDMEnderecos.Insert(aJsonArray: TJSONArray): Integer;
var
  fdqEndereco: TFDQuery;
  jValores: TJSONValue;
  idx: Integer;
begin
  idx := 0;

  fdqEndereco := nil;

  try
    try
      fdqEndereco := TFDQuery.Create(nil);
      fdqEndereco.Connection := fConector;
      fdqEndereco.SQL.Add('CALL projetomultitier.endereco_enderecoIntegracao(');
      fdqEndereco.SQL.Add('  :idpessoa, ');
      fdqEndereco.SQL.Add('  :dscep, ');
      fdqEndereco.SQL.Add('  :dsuf, ');
      fdqEndereco.SQL.Add('  :nmcidade, ');
      fdqEndereco.SQL.Add('  :nmbairro, ');
      fdqEndereco.SQL.Add('  :nmlogradouro, ');
      fdqEndereco.SQL.Add('  :dscomplemento)');

      fdqEndereco.Params.ArraySize := aJsonArray.Count;

      fConector.StartTransaction;

      for jValores in aJsonArray do
      begin
        fdqEndereco.ParamByName('idpessoa').AsLargeInts[idx] := jValores.GetValue<Largeint>('idpessoa');
        fdqEndereco.ParamByName('dscep').AsStrings[idx] := jValores.GetValue<string>('dscep');
        fdqEndereco.ParamByName('dsuf').AsStrings[idx] := jValores.GetValue<string>('dsuf');
        fdqEndereco.ParamByName('nmcidade').AsStrings[idx] := jValores.GetValue<string>('nmcidade');
        fdqEndereco.ParamByName('nmbairro').AsStrings[idx] := jValores.GetValue<string>('nmbairro');
        fdqEndereco.ParamByName('nmlogradouro').AsStrings[idx] := jValores.GetValue<string>('nmlogradouro');
        fdqEndereco.ParamByName('dscomplemento').AsStrings[idx] := jValores.GetValue<string>('dscomplemento');

        Inc(idx);
      end;

      if idx > 0 then
        fdqEndereco.Execute(idx);

      fdqEndereco.SQL.Clear;
      fdqEndereco.SQL.Add('SELECT currval(pg_get_serial_sequence(' + QuotedStr('projetomultitier.endereco') + ',' + QuotedStr('idendereco') + ')) AS idendereco');
      fdqEndereco.Open;

      Result := fdqEndereco.FieldByName('idendereco').AsLargeInt;

      fConector.Commit;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco);
  end;
end;

function TDMEnderecos.Update(const aId: Int64; aJsonArray: TJSONArray): Integer;
var
  fdqEndereco: TFDQuery;
  lValores: TJSONValue;
begin
  Result := 0;

  fdqEndereco := nil;

  try
    try
      lValores := aJsonArray.Items[0];

      fdqEndereco := TFDQuery.Create(nil);
      fdqEndereco.Connection := fConector;

      fConector.StartTransaction;

      fdqEndereco.SQL.Add('UPDATE projetomultitier.endereco');
      fdqEndereco.SQL.Add('   SET idpessoa = :idpessoa,');
      fdqEndereco.SQL.Add('       dscep= :dscep ');
      fdqEndereco.SQL.Add(' WHERE idendereco = :idendereco');

      fdqEndereco.ParamByName('idendereco').AsLargeInt := aId;
      fdqEndereco.ParamByName('idpessoa').AsLargeInt := lValores.GetValue<Largeint>('idpessoa');
      fdqEndereco.ParamByName('dscep').AsString := lValores.GetValue<string>('dscep');
      fdqEndereco.ExecSQL;

      fdqEndereco.SQL.Clear;
      fdqEndereco.SQL.Add('UPDATE projetomultitier.endereco_integracao ');
      fdqEndereco.SQL.Add('   SET dsuf          = :dsuf, ');
      fdqEndereco.SQL.Add('       nmcidade      = :nmcidade, ');
      fdqEndereco.SQL.Add('       nmbairro      = :nmbairro, ');
      fdqEndereco.SQL.Add('       nmlogradouro  = :nmlogradouro, ');
      fdqEndereco.SQL.Add('       dscomplemento = :dscomplemento ');
      fdqEndereco.SQL.Add(' WHERE idendereco = :idendereco');

      fdqEndereco.ParamByName('idendereco').AsLargeInt := aId;
      fdqEndereco.ParamByName('dsuf').AsString := lValores.GetValue<string>('dsuf');
      fdqEndereco.ParamByName('nmcidade').AsString := lValores.GetValue<string>('nmcidade');
      fdqEndereco.ParamByName('nmbairro').AsString := lValores.GetValue<string>('nmbairro');
      fdqEndereco.ParamByName('nmlogradouro').AsString := lValores.GetValue<string>('nmlogradouro');
      fdqEndereco.ParamByName('dscomplemento').AsString := lValores.GetValue<string>('dscomplemento');
      fdqEndereco.ExecSQL;

      fConector.Commit;

      Result := aJsonArray.Count;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco);
  end;
end;

function TDMEnderecos.Delete(const aId: Int64): Integer;
var
  fdqEndereco: TFDQuery;
begin
  Result := 0;

  fdqEndereco := nil;

  try
    try
      fdqEndereco := TFDQuery.Create(nil);
      fdqEndereco.Connection := fConector;
      fdqEndereco.SQL.Add('DELETE FROM projetomultitier.endereco	WHERE idendereco = :idendereco');

      fConector.StartTransaction;

      fdqEndereco.ParamByName('idendereco').AsLargeInt := aId;

      fdqEndereco.ExecSQL;

      fConector.Commit;

      Result := 1;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco);
  end;
end;

end.
