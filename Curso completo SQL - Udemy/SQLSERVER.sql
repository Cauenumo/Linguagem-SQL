USE EMPRESA 
GO

CREATE TABLE ALUNO(
	IDALUNO INT PRIMARY KEY IDENTITY,
	NOME VARCHAR(30) NOT NULL,
	SEXO CHAR(1) NOT NULL,
	NASCIMENTO DATE NOT NULL,
	EMAIL VARCHAR(30) UNIQUE
)
GO

/* constraints */ 

ALTER TABLE ALUNO
ADD CONSTRAINT CK_SEXO CHECK (SEXO IN ('M','F'))


/* 1X1*/

CREATE TABLE ENDERECO(
	IDENNDERECO INT PRIMARY KEY IDENTITY(10,10),
	BAIRRO VARCHAR(30),
	UF CHAR(2) NOT NULL
	CHECK (UF IN ('RJ','SP','MG')),
	ID_ALUNO INT UNIQUE 
)

/* CRIANDO FK */ 

ALTER TABLE ENDERECO 
ADD CONSTRAINT FK_ENDERECO_ALUNO
FOREIGN KEY (ID_ALUNO)
REFERENCES ALUNO(IDALUNO)

/* COMANDOS DE DESCRICAO */

 