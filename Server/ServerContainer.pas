unit ServerContainer;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSServer, Datasnap.DSCommonServer, Datasnap.DSAuth,
  IPPeerServer, IPPeerAPI;

type
  TServerContainer1 = class(TDataModule)
    DSServer: TDSServer;
    DSSCPessoa: TDSServerClass;
    DSSVEndereco: TDSServerClass;
    DSSCViaCep: TDSServerClass;
    DSSAtualizaCepEmLote: TDSServerClass;
    procedure DSSCPessoaGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSSVEnderecoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSSCViaCepGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSSAtualizaCepEmLoteGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function DSServer: TDSServer;

implementation

{$R *.dfm}

uses
  ControllerPessoa, ControllerEndereco, ControllerViaCep, ControllerCepEmLote;

var
  FModule: TComponent;
  FDSServer: TDSServer;

constructor TServerContainer1.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServer;
end;

destructor TServerContainer1.Destroy;
begin
  inherited;
  FDSServer := nil;
end;

function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

procedure TServerContainer1.DSSCPessoaGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TControllerPessoa;
end;

procedure TServerContainer1.DSSVEnderecoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TControllerEndereco;
end;

procedure TServerContainer1.DSSCViaCepGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TControllerViaCep;
end;

procedure TServerContainer1.DSSAtualizaCepEmLoteGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TControllerCepEmLote;
end;

initialization

FModule := TServerContainer1.Create(nil);

finalization

FModule.Free;

end.
