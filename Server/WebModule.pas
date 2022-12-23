unit WebModule;

interface

uses
  System.SysUtils, System.Classes,
  Web.HTTPApp, Web.WebFileDispatcher, Web.HTTPProd,
  DataSnap.DSAuth, DataSnap.DSProxyJavaScript, IPPeerServer, DataSnap.DSMetadata,
  DataSnap.DSServerMetadata, DataSnap.DSClientMetadata, DataSnap.DSCommonServer,
  DataSnap.DSHTTP, DataSnap.DSServer, DataSnap.DSHTTPWebBroker, DataSnap.DSHTTPCommon,
  System.JSON, Data.DBXCommon;

type
  TWebModule1 = class(TWebModule)
    DSRESTWebDispatcher: TDSRESTWebDispatcher;
    WebFileDispatcher: TWebFileDispatcher;
    DSProxyGenerator: TDSProxyGenerator;
    DSServerMetaDataProvider: TDSServerMetaDataProvider;
    procedure WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebFileDispatcherBeforeDispatch(Sender: TObject; const AFileName: string; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

uses ServerContainer, Web.WebReq;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  DSServerMetaDataProvider.Server := DSServer;
  DSRESTWebDispatcher.Server := DSServer;
  if DSServer.Started then
  begin
    DSRESTWebDispatcher.DbxContext := DSServer.DbxContext;
    DSRESTWebDispatcher.Start;
  end;
end;

procedure TWebModule1.WebFileDispatcherBeforeDispatch(Sender: TObject; const AFileName: string; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  D1, D2: TDateTime;
begin
  Handled := False;
  if SameFileName(ExtractFileName(AFileName), 'serverfunctions.js') then
    if not FileExists(AFileName) or (FileAge(AFileName, D1) and FileAge(WebApplicationFileName, D2) and (D1 < D2)) then
    begin
      DSProxyGenerator.TargetDirectory := ExtractFilePath(AFileName);
      DSProxyGenerator.TargetUnitName := ExtractFileName(AFileName);
      DSProxyGenerator.Write;
    end;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html>' + '<head><title>Projeto MultiTier</title></head>' + '<body><h2>Projeto MultiTier - Wk&Desbravadores</h2><br /><h3>Servidor ativo.</h3></body>' + '</html>';
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.
