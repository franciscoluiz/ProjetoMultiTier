unit ViewEndereco;

interface

uses
  ControllerEnderecos, ControllerViaCep, TOEndereco, TOViaCep,
  UtilRetorno,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, REST.Types, Data.DB;

type
  TfrmEndereco = class(TForm)
    Label3: TLabel;
    edtEstado: TEdit;
    Label4: TLabel;
    edtCidade: TEdit;
    Label1: TLabel;
    edtBairro: TEdit;
    Bairro: TLabel;
    edtLogradouro: TEdit;
    Label2: TLabel;
    edtComplemento: TEdit;
    Label5: TLabel;
    edtCep: TEdit;
    btnSalvar: TSpeedButton;
    btmFechar: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btmFecharClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fControllerEndereco: TControllerEndereco;
    fControllerViaCep: TControllerViaCep;

    fRegistro: TTOEndereco;
  public
    { Public declarations }
    procedure SetRegistro(aRegistro: TTOEndereco);
  end;

var
  frmEndereco: TfrmEndereco;

implementation

{$R *.dfm}

procedure TfrmEndereco.FormCreate(Sender: TObject);
begin
  fControllerEndereco := TControllerEndereco.Create;
  fControllerViaCep := TControllerViaCep.Create;
end;

procedure TfrmEndereco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then Close;
end;

procedure TfrmEndereco.btmFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEndereco.btnSalvarClick(Sender: TObject);
var
  bRet: TReturnBoolean;
begin
  fRegistro.Cep := edtCep.Text;
  fRegistro.Uf := edtEstado.Text;
  fRegistro.Cidade := edtCidade.Text;
  fRegistro.Bairro := edtBairro.Text;
  fRegistro.Logradouro := edtLogradouro.Text;
  fRegistro.Complemento := edtComplemento.Text;

  bRet := fControllerEndereco.Validar(fRegistro);

  if bRet.HasError then
  begin
    ShowMessage(bRet.Mensage);
    Exit;
  end;

  if fRegistro.IdPessoa > 0 then
  begin
    if fRegistro.IdEndereco > 0 then
      fControllerEndereco.Update(fRegistro)
    else
      fControllerEndereco.Insert(fRegistro);
  end
  else
    fControllerEndereco.InsertSomenteNoDataSet(fRegistro);

  Close;
end;

procedure TfrmEndereco.edtCepExit(Sender: TObject);
var
  viaCep: TTOViaCep;
begin
  if Length(edtEstado.Text) > 0 then
    Exit;

  if Length(edtCep.Text) <> 8 then
  begin
    ShowMessage('O CEP deve conter 8 caracteres.');
    Abort;
  end;

  viaCep := fControllerViaCep.GetDados(edtCep.Text);

  if (viaCep <> nil) and (viaCep.Cep.Length > 0) then
  begin
    edtEstado.Text := viaCep.Uf;
    edtCidade.Text := viaCep.Localidade;
    edtBairro.Text := viaCep.Bairro;
    edtLogradouro.Text := viaCep.Logradouro;
    edtComplemento.Text := viaCep.Complemento;
  end;
end;

procedure TfrmEndereco.edtCepKeyPress(Sender: TObject; var Key: Char);
const
  teclasDec = ['0' .. '9'];
begin
  if not((UpCase(Key) in teclasDec) or (Ord(Key) = VK_BACK)) then
    Key := #0;
end;

procedure TfrmEndereco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fControllerEndereco.GetDataSource.DataSet.Cancel;
  Self.Release;
end;

procedure TfrmEndereco.SetRegistro(aRegistro: TTOEndereco);
begin
  fRegistro := aRegistro;

  edtCep.Text := fRegistro.Cep;
  edtEstado.Text := fRegistro.Uf;
  edtCidade.Text := fRegistro.Cidade;
  edtBairro.Text := fRegistro.Bairro;
  edtLogradouro.Text := fRegistro.Logradouro;
  edtComplemento.Text := fRegistro.Complemento;
end;

end.
