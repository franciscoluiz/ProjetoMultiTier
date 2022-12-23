unit ModelViaCep;

interface

uses
  System.SysUtils, System.Classes, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TDMViaCep = class(TDataModule)
    Adapter: TRESTResponseDataSetAdapter;
    DataSet: TFDMemTable;
    DataSource: TDataSource;
    Client: TRESTClient;
    Request: TRESTRequest;
    Response: TRESTResponse;
    DataSetcep: TStringField;
    DataSetlogradouro: TStringField;
    DataSetcomplemento: TStringField;
    DataSetbairro: TStringField;
    DataSetlocalidade: TStringField;
    DataSetuf: TStringField;
    DataSetibge: TStringField;
    DataSetgia: TStringField;
    DataSetddd: TStringField;
    DataSetsiafi: TStringField;
  strict private
    { Private declarations }
    class var FInstance: TDMViaCep;
    constructor PrivateCreate;
  public
    { Public declarations }
    class function GetInstance: TDMViaCep;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}
{ TDAOViaCep }

constructor TDMViaCep.Create;
begin
  raise Exception.Create('Para obter uma instância de DAO pessoas invoque o método GetIntance');
end;

destructor TDMViaCep.Destroy;
begin
  inherited;
end;

class function TDMViaCep.GetInstance: TDMViaCep;
begin
  if not Assigned(FInstance) then
    FInstance := TDMViaCep.PrivateCreate;

  Result := FInstance;
end;

constructor TDMViaCep.PrivateCreate;
begin
  inherited Create(nil);
end;

end.
