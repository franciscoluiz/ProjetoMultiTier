unit ModelPessoas;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Data.DB;

type
  TDMPessoas = class
  private
    fConector: TFDConnection;
  public
    function Get(const aFiltro: TPair<string, string>; aIdPaginacao: Int64 = -1): TJSONArray;
    function Insert(aJsonArray: TJSONArray): integer;
    function Update(const aId: Int64; aJsonArray: TJSONArray): integer;
    function Delete(const aId: Int64): integer;

    constructor Create(aConector: TFDConnection);
    destructor Destroy; override;
  published
  end;

implementation

{ TDMPessoas }

// https://github.com/viniciussanchez/dataset-serialize
uses DataSet.Serialize;

constructor TDMPessoas.Create(aConector: TFDConnection);
begin
  fConector := aConector;
end;

destructor TDMPessoas.Destroy;
begin

  inherited;
end;

function TDMPessoas.Get(const aFiltro: TPair<string, string>; aIdPaginacao: Int64 = -1): TJSONArray;
var
  fdqPessoa: TFDQuery;
begin
  Result := nil;
  fdqPessoa := nil;

  try
    try
      fdqPessoa := TFDQuery.Create(nil);
      fdqPessoa.Connection := fConector;
      fdqPessoa.SQL.Add('SELECT * FROM ProjetoMultiTier.pessoa');

      if (aFiltro.Key.Length > 0) or (aIdPaginacao > -1) then
        fdqPessoa.SQL.Add('WHERE');

      if aFiltro.Key.Length > 0 then
        fdqPessoa.SQL.Add('  ' + aFiltro.Key + ' = ' + aFiltro.Value)
      else if aIdPaginacao > -1 then
        fdqPessoa.SQL.Add('  idpessoa >= ' + aIdPaginacao.ToString);

      fdqPessoa.SQL.Add('ORDER BY idpessoa');

      if (aFiltro.Key.Length = 0) and (aIdPaginacao > -1) then
        fdqPessoa.SQL.Add('LIMIT 200');

      fdqPessoa.Open;

      Result := fdqPessoa.ToJsonArray;
    except
      on E: Exception do
        raise;
    end;
  finally
    if fdqPessoa <> nil then
      FreeAndNil(fdqPessoa);
  end;
end;

function TDMPessoas.Insert(aJsonArray: TJSONArray): integer;
var
  fdqPessoa: TFDQuery;
  jValores: TJSONValue;
  idx: integer;
begin
  idx := 0;

  fdqPessoa := nil;

  try
    try
      fdqPessoa := TFDQuery.Create(nil);
      fdqPessoa.Connection := fConector;
      fdqPessoa.SQL.Clear;
      fdqPessoa.SQL.Add('CALL projetomultitier.pessoa_endereco(');
      fdqPessoa.SQL.Add('    :flnatureza, ');
      fdqPessoa.SQL.Add('    :dsdocumento, ');
      fdqPessoa.SQL.Add('    :nmprimeiro, ');
      fdqPessoa.SQL.Add('    :nmsegundo, ');
      fdqPessoa.SQL.Add('    :dtregistro, ');
      fdqPessoa.SQL.Add('    :dscep, ');
      fdqPessoa.SQL.Add('    :dsuf, ');
      fdqPessoa.SQL.Add('    :nmcidade, ');
      fdqPessoa.SQL.Add('    :nmbairro, ');
      fdqPessoa.SQL.Add('    :nmlogradouro, ');
      fdqPessoa.SQL.Add('    :dscomplemento)');
      fdqPessoa.Params.ArraySize := aJsonArray.Count;

      fConector.StartTransaction;

      for jValores in aJsonArray do
      begin
        fdqPessoa.ParamByName('flnatureza').AsSmallInts[idx] := jValores.GetValue<SmallInt>('flnatureza');
        fdqPessoa.ParamByName('dsdocumento').AsStrings[idx] := jValores.GetValue<string>('dsdocumento');
        fdqPessoa.ParamByName('nmprimeiro').AsStrings[idx] := jValores.GetValue<string>('nmprimeiro');
        fdqPessoa.ParamByName('nmsegundo').AsStrings[idx] := jValores.GetValue<string>('nmsegundo');
        fdqPessoa.ParamByName('dtregistro').AsDates[idx] := StrToDate(jValores.GetValue<string>('dtregistro'));
        fdqPessoa.ParamByName('dscep').AsStrings[idx] := jValores.GetValue<string>('dscep');
        fdqPessoa.ParamByName('dsuf').AsStrings[idx] := jValores.GetValue<string>('dsuf');
        fdqPessoa.ParamByName('nmcidade').AsStrings[idx] := jValores.GetValue<string>('nmcidade');
        fdqPessoa.ParamByName('nmbairro').AsStrings[idx] := jValores.GetValue<string>('nmbairro');
        fdqPessoa.ParamByName('nmlogradouro').AsStrings[idx] := jValores.GetValue<string>('nmlogradouro');
        fdqPessoa.ParamByName('dscomplemento').AsStrings[idx] := jValores.GetValue<string>('dscomplemento');

        Inc(idx);
      end;

      if idx > 0 then
        fdqPessoa.Execute(idx);

      fdqPessoa.SQL.Clear;
      fdqPessoa.SQL.Add('SELECT currval(pg_get_serial_sequence(' + QuotedStr('projetomultitier.pessoa') + ',' + QuotedStr('idpessoa') + ')) AS idpessoa');
      fdqPessoa.Open;

      Result := fdqPessoa.FieldByName('idpessoa').AsLargeInt;

      fConector.Commit;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqPessoa <> nil then
      FreeAndNil(fdqPessoa);
  end;
end;

function TDMPessoas.Update(const aId: Int64; aJsonArray: TJSONArray): integer;
var
  fdqPessoa: TFDQuery;
  lValores: TJSONValue;
begin
  Result := 0;

  fdqPessoa := nil;

  try
    try
      lValores := aJsonArray.Items[0];

      fdqPessoa := TFDQuery.Create(nil);
      fdqPessoa.Connection := fConector;
      fdqPessoa.SQL.Add('UPDATE projetomultitier.pessoa');
      fdqPessoa.SQL.Add('   SET flnatureza = :flnatureza,');
      fdqPessoa.SQL.Add('       dsdocumento = :dsdocumento,');
      fdqPessoa.SQL.Add('       nmprimeiro = :nmprimeiro,');
      fdqPessoa.SQL.Add('       nmsegundo = :nmsegundo,');
      fdqPessoa.SQL.Add('       dtregistro = :dtregistro');
      fdqPessoa.SQL.Add(' WHERE idpessoa = :idPessoa');

      fConector.StartTransaction;

      fdqPessoa.ParamByName('idpessoa').AsLargeInt := aId;
      fdqPessoa.ParamByName('flnatureza').AsSmallInt := lValores.GetValue<SmallInt>('flnatureza');
      fdqPessoa.ParamByName('dsdocumento').AsString := lValores.GetValue<string>('dsdocumento');
      fdqPessoa.ParamByName('nmprimeiro').AsString := lValores.GetValue<string>('nmprimeiro');
      fdqPessoa.ParamByName('nmsegundo').AsString := lValores.GetValue<string>('nmsegundo');
      fdqPessoa.ParamByName('dtregistro').AsDate := StrToDate(lValores.GetValue<string>('dtregistro'));

      fdqPessoa.ExecSQL;

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
    if fdqPessoa <> nil then
      FreeAndNil(fdqPessoa);
  end;
end;

function TDMPessoas.Delete(const aId: Int64): integer;
var
  fdqPessoa: TFDQuery;
begin
  Result := 0;

  fdqPessoa := nil;

  try

    fdqPessoa := TFDQuery.Create(nil);
    fdqPessoa.Connection := fConector;
    fdqPessoa.SQL.Add('DELETE FROM projetomultitier.pessoa	WHERE idpessoa = :idpessoa');
    fConector.StartTransaction;

    fdqPessoa.ParamByName('idpessoa').AsLargeInt := aId;

    fdqPessoa.ExecSQL;

    fConector.Commit;

    Result := 1;
  except
    on E: Exception do
    begin
      fConector.Rollback;
      raise;
    end;
  end;
end;

end.
