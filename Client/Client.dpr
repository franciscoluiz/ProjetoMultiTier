program Client;

uses
  Vcl.Forms,
  ViewPrincipal in 'View\ViewPrincipal.pas' {frmPrincipal},
  ModelPessoas in 'Model\ModelPessoas.pas' {DMPessoas: TDataModule},
  ViewPessoa in 'View\ViewPessoa.pas' {frmPessoa},
  ViewListagemPessoas in 'View\ViewListagemPessoas.pas' {frmListagemPessoas},
  ViewEndereco in 'View\ViewEndereco.pas' {frmEndereco},
  ModelEnderecos in 'Model\ModelEnderecos.pas' {DMEnderecos: TDataModule},
  ModelViaCep in 'Model\ModelViaCep.pas' {DMViaCep: TDataModule},
  ControllerPessoa in 'Controller\ControllerPessoa.pas',
  ControllerEnderecos in 'Controller\ControllerEnderecos.pas',
  ControllerViaCep in 'Controller\ControllerViaCep.pas',
  TOViaCep in '..\TO\TOViaCep.pas',
  TOEndereco in '..\TO\TOEndereco.pas',
  TOPessoa in '..\TO\TOPessoa.pas',
  ModelCep in 'Model\ModelCep.pas' {DMCep: TDataModule},
  ControllerCepEmLote in 'Controller\ControllerCepEmLote.pas',
  UtilRetorno in 'UtilRetorno.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDMCep, DMCep);
  Application.Run;
end.
