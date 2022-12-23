unit ControllerCepEmLote;

interface

uses
  ModelCep,
  System.Classes, System.SysUtils, System.JSON.Writers, System.JSON.Types,
  System.JSON, Data.DB, REST.Types, FireDAC.Comp.Client;

type
  TControllerCepEmLote = class
  private
    fDAO: TDMCep;
  public
    constructor Create;
    function Atualizar: Integer;
  published
  end;

implementation

{ TControllerAtualizaCepEmLote }

function TControllerCepEmLote.Atualizar: Integer;
begin
  fDAO.Adapter.Active := True;
  fDAO.Request.Method := TRESTRequestMethod.rmGET;
  fDAO.Request.Execute;

  if not fDAO.Request.Response.Status.Success then
    raise Exception.Create(fDAO.Request.Response.StatusText);

  Result := fDAO.DataSetquantidade.Value;
end;

constructor TControllerCepEmLote.Create;
begin
  fDAO := TDMCep.GetInstance;
end;

end.
