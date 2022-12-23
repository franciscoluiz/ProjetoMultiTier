unit ModelEnderecos;

interface

uses
  System.SysUtils, System.Classes, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TDMEnderecos = class(TDataModule)
    Adapter: TRESTResponseDataSetAdapter;
    DataSet: TFDMemTable;
    DataSource: TDataSource;
    Client: TRESTClient;
    Request: TRESTRequest;
    Response: TRESTResponse;
    DataSetidendereco: TLargeintField;
    DataSetidpessoa: TLargeintField;
    DataSetdscep: TStringField;
    DataSetdsuf: TStringField;
    DataSetnmcidade: TStringField;
    DataSetnmbairro: TStringField;
    DataSetnmlogradouro: TStringField;
    DataSetdscomplemento: TStringField;
  strict private
    { Private declarations }
    class var FInstance: TDMEnderecos;
    constructor PrivateCreate;
  public
    { Public declarations }
    class function GetInstance: TDMEnderecos;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDAOEnderecos }

constructor TDMEnderecos.Create;
begin
  raise Exception.Create('Para obter uma instância de DAO pessoas invoque o método GetIntance');
end;

destructor TDMEnderecos.Destroy;
begin
  inherited;
end;

class function TDMEnderecos.GetInstance: TDMEnderecos;
begin
  if not Assigned(FInstance) then
    FInstance := TDMEnderecos.PrivateCreate;

  Result := FInstance;
end;

constructor TDMEnderecos.PrivateCreate;
begin
  inherited Create(nil);
end;

end.
