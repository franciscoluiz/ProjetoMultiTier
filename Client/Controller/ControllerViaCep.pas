unit ControllerViaCep;

interface

uses
  ModelViaCep, TOViaCep,
  REST.Types, System.SysUtils;

type
  TControllerViaCep = class
  private
    fDAO: TDMViaCep;
  public
    function GetDados(aCep: string): TTOViaCep;
    constructor Create;
  end;

implementation

{ TControllerViaCep }

constructor TControllerViaCep.Create;
begin
  fDAO := TDMViaCep.GetInstance;
end;

function TControllerViaCep.GetDados(aCep: string): TTOViaCep;
begin
  fDAO.Adapter.Active := True;
  fDAO.Request.Method := TRESTRequestMethod.rmGET;
  fDAO.Request.Resource := 'consultacep/' + aCep;
  fDAO.Request.Execute;

  if not fDAO.Request.Response.Status.Success then
    raise Exception.Create(fDAO.Request.Response.StatusText);

  Result := TTOViaCep.Create;
  Result.Cep := fDAO.DataSetcep.Value;
  Result.Uf := fDAO.DataSetuf.Value;
  Result.Localidade := fDAO.DataSetlocalidade.Value;
  Result.Bairro := fDAO.DataSetbairro.Value;
  Result.Logradouro := fDAO.DataSetlogradouro.Value;
  Result.Complemento := fDAO.DataSetcomplemento.Value;
end;

end.
