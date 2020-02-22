-- Banco Sisdep
USE SisDep

-- Função IIF

SELECT SALARIO FROM FUNCIONARIO

SELECT 
	NomeFuncionario, 
	Admissao, 
	Salario,
	IIF(SALARIO <= 2000,'Reajuste','') AS [Analise Salarial]
FROM Funcionario

BEGIN TRAN
	UPDATE Funcionario
	SET Salario *= IIF(Salario <=2000, 1.1, 1.05)
	OUTPUT 
		deleted.NomeFuncionario,
		deleted.Salario AS [Salário Anterior],
		inserted.Salario AS [Novo Salário]
COMMIT

SELECT NomeFuncionario, Salario from Funcionario

SELECT IDMatricula,
	   NomeFuncionario,
	   Admissao,
	   CHOOSE(DATEPART(WEEKDAY,Admissao), 'Dom','Seg','Ter','Qua','Qui','Sex','Sab') AS [Dia da Semana]
FROM Funcionario

-- LAG - LEAD

SELECT
	idMatricula, NomeFuncionario, Admissao, Salario,
	LAG(Admissao,1) OVER(ORDER BY idMatricula) AS [Admissão Linha Acima],
	LEAD(Admissao,1) OVER(ORDER BY idMatricula) AS [Admissão Linha abaixo]
From Funcionario


SELECT
	idMatricula, NomeFuncionario, Admissao, Salario,
	LAG(Salario,1) OVER(ORDER BY idMatricula) AS [Salario Linha Acima],
	LEAD(Salario,1) OVER(ORDER BY idMatricula) AS [Salario Linha abaixo],
	DATEDIFF(DAY,Admissao, LAG(Admissao,1,0) OVER(ORDER BY idMatricula)),
	Salario - LAG(Salario,1) OVER(ORDER BY idMatricula) AS [Salario Linha Acima]
From Funcionario

-- FETCH-OFFSET
-- 20 PRIMEIRAS LINHAS A PARTIR DA 50 LINHA
SELECT * FROM Funcionario
Order by idMatricula
OFFSET 50 ROWS FETCH NEXT 20 ROWS ONLY;

-- 10 LINHAS  ALEATÓRIAS A PARTIR DA 30º

SELECT * FROM Funcionario
Order by NEWID()
OFFSET 30 ROWS FETCH NEXT 10 ROWS ONLY;

-- Funções do tipo identity

USE RecursosAdicionais
--Inserindo Dados

INSERT INTO Instrutores
(nomeInstrutor)
VALUES
('Hélio'),('Agnaldo'),('Magno'),('Luciana');

SELECT * FROM Instrutores

-- Excluir o instrutor id 20

DELETE FROM Instrutores WHERE id = 20;

-- Reutilizando o id 20

/* Manipulação de IDENTITY */
--Ativando o modo insert em colunas identity 
SET IDENTITY_INSERT Instrutores Off;

INSERT INTO Instrutores
(id, nomeInstrutor)
Values
(20,'Márcio')


-- Trás somente a coluna identity de uma tabela
Select IDENTITYCOL FROM Instrutores

-- Retorna o valor inicial
SELECT IDENT_SEED('Instrutores')
-- Retorna o valor de incremento
SELECT IDENT_INCR('Instrutores')

-- retorna o último identity gerado na conexão, não importa a tabela
SELECT @@IDENTITY

-- QUAL FOI O ULTIMO NUMERO GERADO
SELECT SCOPE_IDENTITY()

-- Retorna o valor original mais atual de uma coluna identity
SELECT IDENT_CURRENT('Instrutores')

-- Zera contador do identity
DELETE FROM Instrutores
INSERT INTO Instrutores
(nomeInstrutor)
Values('Cláudio')
TRUNCATE TABLE Instrutores
INSERT INTO Instrutores
(nomeInstrutor)
Values('Roberto')
SELECT * FROM Instrutores
-- Zerar o contador do Identity (DBCC CHECKIDENT)
DBCC CHECKIDENT('Instrutores',RESEED,5)
-- Visualizar Resultado
INSERT INTO Instrutores

/* PIVOT/UNPIVOT */

USE RecursosAdicionais
SET NOCOUNT ON;

DROP TABLE CotacoesPorDataMoeda

CREATE TABLE CotacoesPorDataMoeda
(
	DataCotacao			DATE NOT NULL,
	CodMoeda			VARCHAR(3) NOT NULL,
	ValorCotacao		NUMERIC(18,4) NOT NULL,
	PRIMARY KEY (DataCotacao, CodMoeda)
)

INSERT INTO CotacoesPorDataMoeda
(DataCotacao, CodMoeda, ValorCotacao)
VALUES 
('2014-04-17','USD',2.2357),
('2014-04-16','USD',2.2418),
('2014-04-15','USD',2.2385),
('2014-04-14','USD',2.2147),
('2014-04-17','EUR',3.0927),
('2014-04-16','EUR',3.1012),
('2014-04-15','EUR',3.0874),
('2014-04-14','EUR',3.0616),
('2014-04-17','LIB',3.7593),
('2014-04-16','LIB',3.7708),
('2014-04-15','LIB',3.7400),
('2014-04-14','LIB',3.7048)

CREATE TABLE Investidores
(
	BANCO			VARCHAR(100),
	ANO				SMALLINT,
	INVESTIMENTOS	MONEY,
	DESPESAS		MONEY
)

INSERT INTO Investidores
VALUES
('BANCO ALVORADA S/A',2010, 9613906084.01, 8102644.84),
('BANCO ALVORADA S/A',2011, 174343.35, 7935411.15),
('BANCO ARBI S/A',2010, 8202652.29, 1142155.13),
('BANCO ARBI S/A',2011, 8407843.72, 81746.25)

SELECT * FROM CotacoesPorDataMoeda

-- Transformando Linhas em Colunas (PIVOT)


-- Transformando Colunas em Linhas (UNPIVOT)





