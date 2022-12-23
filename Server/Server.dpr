program Server;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ViewPrincipal in 'View\ViewPrincipal.pas' {Principal},
  ServerContainer in 'ServerContainer.pas' {ServerContainer1: TDataModule},
  WebModule in 'WebModule.pas' {WebModule1: TWebModule},
  ModelConexao in 'Model\ModelConexao.pas' {DMConexao: TDataModule},
  ModelPessoas in 'Model\ModelPessoas.pas',
  ModelEnderecos in 'Model\ModelEnderecos.pas',
  TOEndereco in '..\TO\TOEndereco.pas',
  TOPessoa in '..\TO\TOPessoa.pas',
  TOViaCep in '..\TO\TOViaCep.pas',
  DataSet.Serialize.Config in 'Util\dataset-serialize\DataSet.Serialize.Config.pas',
  DataSet.Serialize.Consts in 'Util\dataset-serialize\DataSet.Serialize.Consts.pas',
  DataSet.Serialize.Export in 'Util\dataset-serialize\DataSet.Serialize.Export.pas',
  DataSet.Serialize.Import in 'Util\dataset-serialize\DataSet.Serialize.Import.pas',
  DataSet.Serialize.Language in 'Util\dataset-serialize\DataSet.Serialize.Language.pas',
  DataSet.Serialize in 'Util\dataset-serialize\DataSet.Serialize.pas',
  DataSet.Serialize.UpdatedStatus in 'Util\dataset-serialize\DataSet.Serialize.UpdatedStatus.pas',
  DataSet.Serialize.Utils in 'Util\dataset-serialize\DataSet.Serialize.Utils.pas',
  ControllerCepEmLote in 'Controller\ControllerCepEmLote.pas' {ControllerCepEmLote: TDSServerModule},
  ControllerEndereco in 'Controller\ControllerEndereco.pas' {ControllerEndereco: TDSServerModule},
  ControllerPessoa in 'Controller\ControllerPessoa.pas' {ControllerPessoa: TDSServerModule},
  ControllerViaCep in 'Controller\ControllerViaCep.pas' {ControllerViaCep: TDSServerModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.Run;
end.
