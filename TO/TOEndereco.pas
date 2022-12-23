unit TOEndereco;

interface

type
  TTOEndereco = class
  strict private
    fIdEndereco: integer;
    fIdPessoa: integer;
    fCep: string;
    fUf: string;
    fCidade: string;
    fBairro: string;
    fLogradouro: string;
    fComplemento: string;
  public
    constructor Create; overload;
    constructor Create(aCep: string); overload;
  published
    property IdEndereco: integer read fIdEndereco write fIdEndereco;
    property IdPessoa: integer read fIdPessoa write fIdPessoa;
    property Cep: string read fCep write fCep;
    property Uf: string read fUf write fUf;
    property Cidade: string read fCidade write fCidade;
    property Bairro: string read fBairro write fBairro;
    property Logradouro: string read fLogradouro write fLogradouro;
    property Complemento: string read fComplemento write fComplemento;
  end;

implementation

{ TTOEndereco }

constructor TTOEndereco.Create;
begin
  fIdEndereco := -1;
  fIdPessoa := Default (integer);
  fCep := Default (string);
  fUf := Default (string);
  fCidade := Default (string);
  fBairro := Default (string);
  fLogradouro := Default (string);
  fComplemento := Default (string);
end;

constructor TTOEndereco.Create(aCep: string);
begin
  Create;
  fCep := aCep;
end;

end.
