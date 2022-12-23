unit ViewPrincipal;

interface

uses
  Winapi.Messages,
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  IdHTTPWebBrokerBridge, IdGlobal,
  Web.HTTPApp;

type
  TPrincipal = class(TForm)
    btnServidor: TButton;
    ApplicationEvents1: TApplicationEvents;
    Image1: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnServidorClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure StopServer;
    procedure TerminateThreads;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

uses
  Winapi.Windows, Winapi.ShellApi, Datasnap.DSSession, ModelConexao;

const
  sTitulo = 'Projeto MultiTier ';

procedure TPrincipal.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TPrincipal.btnServidorClick(Sender: TObject);
begin
  if btnServidor.Tag = 0 then
  begin
    StartServer;
    Caption := sTitulo + '- Servidor em execução';
    btnServidor.Caption := 'Parar Servidor';
    btnServidor.Tag := 1;
  end
  else if btnServidor.Tag = 1 then
  begin
    StopServer;
    Caption := sTitulo + '- Servidor desligado';
    btnServidor.Caption := 'Iniciar Servidor';
    btnServidor.Tag := 0;
  end
end;

procedure TPrincipal.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := 8080;
    FServer.Active := True;
  end;

  if not DMConexao.FDPostgre.Connected then
    DMConexao.FDPostgre.Open;
end;

procedure TPrincipal.StopServer;
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TPrincipal.TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

end.
