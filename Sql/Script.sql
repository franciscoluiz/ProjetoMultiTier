CREATE SCHEMA projetomultitier;

ALTER SCHEMA projetomultitier OWNER TO postgres;

CREATE TABLE projetomultitier.pessoa (
    idpessoa bigserial NOT NULL,
    flnatureza int2 NOT NULL,
    dsdocumento character varying(20) NOT NULL,
    nmprimeiro character varying(100) NOT NULL,
    nmsegundo character varying(100) NOT NULL,
    dtregistro date NULL,
    CONSTRAINT pessoa_pk PRIMARY KEY (idpessoa)
);

CREATE TABLE projetomultitier.endereco (
    idendereco bigserial NOT NULL,
    idpessoa int8 NOT NULL,
    dscep character varying(15),
    CONSTRAINT endereco_pk PRIMARY KEY (idendereco),
    CONSTRAINT endereco_fk_pessoa FOREIGN KEY (idpessoa) REFERENCES projetomultitier.pessoa(idpessoa) ON DELETE CASCADE 
);

CREATE INDEX endereco_idpessoa ON projetomultitier.endereco USING btree (idpessoa ASC NULLS LAST);

CREATE TABLE projetomultitier.endereco_integracao (
    idendereco bigserial NOT NULL,
    dsuf character varying(50),
    nmcidade character varying(100),
    nmbairro character varying(50),
    nmlogradouro character varying(100),
    dscomplemento character varying(100),
    CONSTRAINT enderecointegracao_pk PRIMARY KEY (idendereco),
    CONSTRAINT enderecointegracao_fk_endereco FOREIGN KEY (idendereco) REFERENCES projetomultitier.endereco(idendereco) ON DELETE CASCADE 
);

CREATE OR REPLACE PROCEDURE projetomultitier.pessoa_endereco(
    IN x_flnatureza integer, 
    IN x_dsdocumento character varying, 
    IN x_nmprimeiro character varying, 
    IN x_nmsegundo character varying, 
    IN x_dtregistro date,
    IN x_dscep character varying, 
    IN x_dsuf character varying, 
    IN x_nmcidade character varying, 
    IN x_nmbairro character varying, 
    IN x_nmlogradouro character varying, 
    IN x_dscomplemento character varying)
   LANGUAGE plpgsql AS $procedure$
DECLARE 
  _idpessoa   BIGINT;
  _idendereco BIGINT;
BEGIN
    
    INSERT INTO projetomultitier.pessoa (
      flnatureza, 
      dsdocumento, 
      nmprimeiro, 
      nmsegundo, 
      dtregistro
    ) VALUES (
      x_flnatureza,
      x_dsdocumento,
      x_nmprimeiro,
      x_nmsegundo,
      x_dtregistro
    ) RETURNING idpessoa INTO _idpessoa;
    
    INSERT INTO projetomultitier.endereco (
      idpessoa, 
      dscep
    ) VALUES (
      _idpessoa,
      x_dscep
    ) RETURNING idendereco INTO _idendereco;
    
    INSERT INTO projetomultitier.endereco_integracao (
      idendereco,
      dsuf, 
      nmcidade, 
      nmbairro, 
      nmlogradouro, 
      dscomplemento
    ) VALUES (
      _idendereco,
      x_dsuf, 
      x_nmcidade, 
      x_nmbairro, 
      x_nmlogradouro, 
      x_dscomplemento
    );

END;
$procedure$
;

CREATE OR REPLACE PROCEDURE projetomultitier.endereco_enderecointegracao(
    IN x_idpessoa bigint, 
    IN x_dscep character varying, 
    IN x_dsuf character varying, 
    IN x_nmcidade character varying, 
    IN x_nmbairro character varying, 
    IN x_nmlogradouro character varying, 
    IN x_dscomplemento character varying)
 LANGUAGE plpgsql AS $procedure$
DECLARE
  _idendereco BIGINT;
BEGIN

    INSERT INTO projetomultitier.endereco (
      idpessoa, 
      dscep
    ) VALUES (
      x_idpessoa,
      x_dscep
    ) RETURNING idendereco INTO _idendereco;
    
    INSERT INTO projetomultitier.endereco_integracao (
      idendereco,
      dsuf, 
      nmcidade, 
      nmbairro, 
      nmlogradouro, 
      dscomplemento
    ) VALUES (
      _idendereco,
      x_dsuf, 
      x_nmcidade, 
      x_nmbairro, 
      x_nmlogradouro, 
      x_dscomplemento
    );

END;
$procedure$
;