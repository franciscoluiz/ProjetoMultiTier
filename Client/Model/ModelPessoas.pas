unit ModelPessoas;

interface

uses
  System.SysUtils, System.Classes, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TDMPessoas = class(TDataModule)
    Adapter: TRESTResponseDataSetAdapter;
    DataSet: TFDMemTable;
    DataSource: TDataSource;
    Client: TRESTClient;
    Request: TRESTRequest;
    Response: TRESTResponse;
    DataSetidpessoa: TLargeintField;
    DataSetflnatureza: TSmallintField;
    DataSetdsdocumento: TStringField;
    DataSetnmprimeiro: TStringField;
    DataSetnmsegundo: TStringField;
    DataSetdtregistro: TDateField;
  strict private
    { Private declarations }
    class var FInstance: TDMPessoas;
    constructor PrivateCreate;
  public
    { Public declarations }
    class function GetInstance: TDMPessoas;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}
{ TDAOPessoas }

constructor TDMPessoas.Create;
begin
  raise Exception.Create('Para obter uma instância de DAO pessoas invoque o método GetIntance');
end;

destructor TDMPessoas.Destroy;
begin
  inherited;
end;

class function TDMPessoas.GetInstance: TDMPessoas;
begin
  if not Assigned(FInstance) then
    FInstance := TDMPessoas.PrivateCreate;

  Result := FInstance;
end;

constructor TDMPessoas.PrivateCreate;
begin
  inherited Create(nil);
end;

end.
