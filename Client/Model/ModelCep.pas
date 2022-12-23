unit ModelCep;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter;

type
  TDMCep = class(TDataModule)
    Client: TRESTClient;
    Request: TRESTRequest;
    Response: TRESTResponse;
    Adapter: TRESTResponseDataSetAdapter;
    DataSource: TDataSource;
    DataSet: TFDMemTable;
    DataSetquantidade: TIntegerField;
  strict private
    { Private declarations }
    class var FInstance: TDMCep;
    constructor PrivateCreate;
  public
    { Public declarations }
    class function GetInstance: TDMCep;

    constructor Create;
    destructor Destroy; override;
  end;

var
  DMCep: TDMCep;

implementation

{$R *.dfm}
{ TDAOAtualizaCepEmLote }

constructor TDMCep.Create;
begin
  raise Exception.Create('Para obter uma instância de DAO pessoas invoque o método GetIntance');
end;

destructor TDMCep.Destroy;
begin
  inherited;
end;

class function TDMCep.GetInstance: TDMCep;
begin
  if not Assigned(FInstance) then
    FInstance := TDMCep.PrivateCreate;

  Result := FInstance;
end;

constructor TDMCep.PrivateCreate;
begin
  inherited Create(nil);
end;

end.
