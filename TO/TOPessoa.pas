unit TOPessoa;

interface

type
  TTOPessoa = class
  strict private
    fIdpessoa: integer;
    fNatureza: integer;
    fDocumento: string;
    fPrimeiro: string;
    fSegundo: string;
    fRegistro: TDate;
  public
    constructor Create;
  published
    property Idpessoa: integer read fIdpessoa write fIdpessoa;
    property Natureza: integer read fNatureza write fNatureza;
    property Documento: string read fDocumento write fDocumento;
    property Primeiro: string read fPrimeiro write fPrimeiro;
    property Segundo: string read fSegundo write fSegundo;
    property Registro: TDate read fRegistro write fRegistro;
  end;

implementation

{ TTOPessoa }

constructor TTOPessoa.Create;
begin
  fIdpessoa := -1;
  fNatureza := Default (SmallInt);
  fDocumento := Default (string);
  fPrimeiro := Default (string);
  fSegundo := Default (string);
  fRegistro := Default (TDate);
end;

end.
