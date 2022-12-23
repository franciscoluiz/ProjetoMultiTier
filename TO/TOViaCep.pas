unit TOViaCep;

interface

type
  TTOViaCep = class
  strict private
    fCep: string;
    fUf: string;
    fLocalidade: string;
    fBairro: string;
    fLogradouro: string;
    fComplemento: string;
  public
    constructor Create;
  published
    property Cep: string read fCep write fCep;
    property Uf: string read fUf write fUf;
    property Localidade: string read fLocalidade write fLocalidade;
    property Bairro: string read fBairro write fBairro;
    property Logradouro: string read fLogradouro write fLogradouro;
    property Complemento: string read fComplemento write fComplemento;
  end;

implementation

{ TTOViaCep }

constructor TTOViaCep.Create;
begin
  fCep := Default (string);
  fUf := Default (string);
  fLocalidade := Default (string);
  fBairro := Default (string);
  fLogradouro := Default (string);
  fComplemento := Default (string);
end;

end.
