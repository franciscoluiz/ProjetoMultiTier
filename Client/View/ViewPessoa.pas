unit ViewPessoa;

interface

uses
  ControllerPessoa, ControllerEnderecos, TOPessoa, TOEndereco,
  UtilRetorno,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, REST.Types,
  Vcl.StdCtrls;

type
  TfrmPessoa = class(TForm)
    pLateral: TPanel;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    btnAdicionar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnDeletar: TSpeedButton;
    btnFechar: TSpeedButton;
    btnSalvar: TSpeedButton;
    DBGrid: TDBGrid;
    pTop: TPanel;
    edtId: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtDocumento: TEdit;
    Label3: TLabel;
    edtNome: TEdit;
    Label4: TLabel;
    edtSobrenome: TEdit;
    Label5: TLabel;
    cbNatureza: TComboBox;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fControllerPessoa: TControllerPessoa;
    fControllerEndereco: TControllerEndereco;
    fRegistro: TTOPessoa;
    function Salvar: Boolean;
  public
    { Public declarations }
    procedure SetRegistro(aRegistro: TTOPessoa);
  end;

var
  frmPessoa: TfrmPessoa;

implementation

{$R *.dfm}

uses ViewListagemPessoas, ViewEndereco;

procedure TfrmPessoa.FormCreate(Sender: TObject);
begin
  cbNatureza.Items.Create;
  cbNatureza.Items.Add('Escolha');
  cbNatureza.Items.Add('Física');
  cbNatureza.Items.Add('Jurídica');

  fControllerPessoa := TControllerPessoa.Create;
  fControllerEndereco := TControllerEndereco.Create;
end;

procedure TfrmPessoa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then Close;
end;

procedure TfrmPessoa.btnAnteriorClick(Sender: TObject);
begin
  if fRegistro.IdPessoa > 0 then
    fControllerEndereco.PaginaAnterior(fRegistro.IdPessoa);
end;

procedure TfrmPessoa.btnProximoClick(Sender: TObject);
begin
  if fRegistro.IdPessoa > 0 then
    fControllerEndereco.ProximaPagina(fRegistro.IdPessoa);
end;

procedure TfrmPessoa.btnAdicionarClick(Sender: TObject);
var
  e: TTOEndereco;

  sMsg: string;
  nMsg: Integer;
begin
  if (fRegistro.IdPessoa < 1) and (fControllerEndereco.GetDataSource.DataSet.RecordCount = 1) then
  begin
    sMsg := 'Para adicionar outro endereço e necessário salvar o registro.' + #13 + 'Deseja continuar?';

    nMsg := Application.MessageBox(PChar(sMsg), PChar(Caption), MB_ICONQUESTION + MB_YESNO);

    if nMsg <> 6 then
      Exit;

    if not Salvar then
      Exit;
  end;

  frmEndereco := TfrmEndereco.Create(Self);

  e := TTOEndereco.Create;
  e.IdPessoa := fRegistro.IdPessoa;

  frmEndereco.SetRegistro(e);

  frmEndereco.ShowModal;
end;

procedure TfrmPessoa.btnDeletarClick(Sender: TObject);
var
  nMsg: Integer;
begin
  if fControllerEndereco.GetDataSource.DataSet.RecordCount < 2 then
  begin
    ShowMessage('Não é possível apagar o último endereço');
    Exit;
  end;

  nMsg := Application.MessageBox(PChar('Deseja apagar o registro?'), PChar(Caption), MB_ICONQUESTION + MB_YESNO);

  if nMsg <> 6 then
    Exit;

  fControllerEndereco.Delete;
  fControllerEndereco.Select(fRegistro.IdPessoa);
end;

procedure TfrmPessoa.btnEditarClick(Sender: TObject);
begin
  frmEndereco := TfrmEndereco.Create(Self);
  frmEndereco.SetRegistro(fControllerEndereco.GetRegistro);
  frmEndereco.ShowModal;
end;

procedure TfrmPessoa.btnSalvarClick(Sender: TObject);
begin
  if not Salvar then
    Exit;

  Close;
end;

procedure TfrmPessoa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPessoa.DBGridDblClick(Sender: TObject);
begin
  btnEditarClick(Self);
end;

procedure TfrmPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fControllerEndereco.Close;
  Self.Release;
end;

function TfrmPessoa.Salvar: Boolean;
var
  bRet: TReturnBoolean;
begin
  Result := False;

  if fControllerEndereco.GetDataSource.DataSet.RecordCount = 0 then
  begin
    ShowMessage('Não é possível inserir uma pessoa sem endereço');
    Exit;
  end;

  fRegistro.Natureza := cbNatureza.ItemIndex;
  fRegistro.Documento := edtDocumento.Text;
  fRegistro.Primeiro := edtNome.Text;
  fRegistro.Segundo := edtSobrenome.Text;
  fRegistro.Registro := Date;

  bRet := fControllerPessoa.Validar(fRegistro);

  if bRet.HasError then
  begin
    ShowMessage(bRet.Mensage);
    Exit;
  end;

  if fRegistro.IdPessoa < 1 then
  begin
    fRegistro.Registro := Date;
    fControllerPessoa.Insert(fRegistro, fControllerEndereco.GetRegistro);
  end
  else
    fControllerPessoa.Update(fRegistro);

  Result := True;
end;

procedure TfrmPessoa.SetRegistro(aRegistro: TTOPessoa);
begin
  fRegistro := aRegistro;

  edtId.Text := fRegistro.IdPessoa.ToString;
  cbNatureza.ItemIndex := fRegistro.Natureza;
  edtDocumento.Text := fRegistro.Documento;
  edtNome.Text := fRegistro.Primeiro;
  edtSobrenome.Text := fRegistro.Segundo;
end;

end.
