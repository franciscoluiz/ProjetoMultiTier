unit ViewListagemPessoas;

interface

uses
  ControllerPessoa, ControllerEnderecos, TOPessoa,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, REST.Types,
  Vcl.StdCtrls;

type
  TfrmListagemPessoas = class(TForm)
    pLateral: TPanel;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    btnAdicionar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnDeletar: TSpeedButton;
    btnFechar: TSpeedButton;
    DBGrid: TDBGrid;
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fControllerPessoa: TControllerPessoa;
    fControllerEndereco: TControllerEndereco;
  public
    { Public declarations }
  end;

var
  frmListagemPessoas: TfrmListagemPessoas;

implementation

{$R *.dfm}

uses ViewPrincipal, ViewPessoa;

procedure TfrmListagemPessoas.FormCreate(Sender: TObject);
begin
  fControllerPessoa := TControllerPessoa.Create;
  fControllerEndereco := TControllerEndereco.Create;
end;

procedure TfrmListagemPessoas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then Close;
end;

procedure TfrmListagemPessoas.btnDeletarClick(Sender: TObject);
var
  nMsg: Integer;
begin
  nMsg := Application.MessageBox(PChar('Deseja apagar o registro?'), PChar(Caption), MB_ICONQUESTION + MB_YESNO);

  if nMsg <> 6 then
    Exit;

  fControllerPessoa.Delete;
end;

procedure TfrmListagemPessoas.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListagemPessoas.btnAdicionarClick(Sender: TObject);
begin
  frmPessoa := TfrmPessoa.Create(Self);
  frmPessoa.SetRegistro(TTOPessoa.Create);
  frmPessoa.DBGrid.DataSource := fControllerEndereco.GetDataSource;
  frmPessoa.ShowModal;
end;

procedure TfrmListagemPessoas.btnAnteriorClick(Sender: TObject);
begin
  fControllerPessoa.PaginaAnterior;
end;

procedure TfrmListagemPessoas.btnProximoClick(Sender: TObject);
begin
  fControllerPessoa.ProximaPagina;
end;

procedure TfrmListagemPessoas.DBGridDblClick(Sender: TObject);
begin
  btnEditarClick(Self);
end;

procedure TfrmListagemPessoas.btnEditarClick(Sender: TObject);
begin
  fControllerEndereco.Select(fControllerPessoa.GetRegistro.Idpessoa);

  frmPessoa := TfrmPessoa.Create(Self);
  frmPessoa.SetRegistro(fControllerPessoa.GetRegistro);
  frmPessoa.DBGrid.DataSource := fControllerEndereco.GetDataSource;
  frmPessoa.ShowModal;
end;

procedure TfrmListagemPessoas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fControllerPessoa.Close;

  Self.Release;
end;

end.
