unit ModelConexao;

interface

uses
  Vcl.Forms, Vcl.Dialogs,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDMConexao = class(TDataModule)
    FDPostgre: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private const
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConexao: TDMConexao;

implementation

{$R *.dfm}

procedure TDMConexao.DataModuleCreate(Sender: TObject);
var
  sFile: string;
begin
  sFile := FDPhysPgDriverLink.VendorLib;

  if not FileExists(sFile) then
    sFile := GetCurrentDir + '\' + 'libpq.dll';

  if not FileExists(sFile) then
  begin
    ShowMessage('Erro: biblioteca de conexão com o servidor PostgreSQL não encontrado!');
    Application.Terminate;
  end;

  FDPhysPgDriverLink.VendorLib := sFile
end;

end.
