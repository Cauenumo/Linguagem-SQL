USE PEDIDOS
go

SELECT MONTH( DATA_EMISSAO ) AS MES,
       YEAR( DATA_EMISSAO ) AS ANO,
       MAX( VLR_TOTAL ) AS MAIOR_TB_PEDIDO
FROM TB_PEDIDO
WHERE YEAR(DATA_EMISSAO) = 2013
GROUP BY MONTH(DATA_EMISSAO), YEAR(DATA_EMISSAO)	
ORDER BY MES;


WITH CTE( MES, ANO, MAIOR_TB_PEDIDO )
AS
(
-- Membro �ncora
SELECT MONTH( DATA_EMISSAO ) AS MES,
       YEAR( DATA_EMISSAO ) AS ANO,
       MAX( VLR_TOTAL ) AS MAIOR_TB_PEDIDO
FROM TB_PEDIDO
WHERE YEAR(DATA_EMISSAO) = 2013
GROUP BY MONTH(DATA_EMISSAO), YEAR(DATA_EMISSAO)	
)
-- Utiliza��o da CTE fazendo JOIN com a tabela TB_PEDIDO
SELECT CTE.MES, CTE.ANO, CTE.MAIOR_TB_PEDIDO, P.NUM_PEDIDO
FROM CTE JOIN TB_PEDIDO P ON CTE.MES = MONTH(P.DATA_EMISSAO) AND
                           CTE.ANO = YEAR(P.DATA_EMISSAO) AND
                           CTE.MAIOR_TB_PEDIDO = P.VLR_TOTAL;


-- Contador
WITH CONTADOR ( N )
AS
(
	-- Membro �ncora
    SELECT 1
    UNION ALL
    -- Membro recursivo
    SELECT N+1 FROM CONTADOR WHERE N < 100
)
-- Execu��o da CTE
SELECT * FROM CONTADOR;

-- Pot�ncias de 5
-- 
WITH POTENCIAS_DE_5 ( EXPOENTE, POTENCIA )
AS
(
    SELECT 1,5
    UNION ALL
    SELECT EXPOENTE+1, POTENCIA * 5 
    FROM POTENCIAS_DE_5 
    WHERE EXPOENTE < 10
)
SELECT * FROM POTENCIAS_DE_5;


WITH JUROS( MES, VALOR )
AS
(
	SELECT 0, CAST(1000 AS NUMERIC(10,2))
	UNION ALL
	SELECT MES + 1, 
             CAST(VALOR * 1.05 AS NUMERIC(10,2))
	FROM JUROS WHERE  MES < 12
)
SELECT * FROM JUROS;


WITH FIBO( N1, N2, PROX)
AS
(
   SELECT 0,1,1
   UNION ALL
   SELECT N2, PROX, N2+PROX FROM FIBO WHERE PROX < 10000
)
SELECT * FROM FIBO;


WITH CTE( CODFUN, NOME, COD_DEPTO, CODSUP, NOME_SUP )
AS
(
	-- Membro �ncora
	SELECT CODFUN, NOME, COD_DEPTO, COD_SUPERVISOR, NOME
	FROM TB_EMPREGADO WHERE COD_SUPERVISOR = 0
	UNION ALL
	-- Membro recursivo
	SELECT E.CODFUN, E.NOME, E.COD_DEPTO, E.COD_SUPERVISOR, CTE.NOME
	FROM TB_EMPREGADO E JOIN CTE ON E.COD_SUPERVISOR = CTE.CODFUN
)
-- Execu��o da CTE
SELECT CTE.CODFUN AS [C�digo], CTE.NOME AS [Funcion�rio], 
       D.DEPTO AS [Departamento], CTE.NOME_SUP AS [Nome Supervisor]
FROM CTE JOIN TB_EMPREGADO E ON CTE.CODFUN = E.CODFUN
         JOIN TB_DEPARTAMENTO D ON E.COD_DEPTO = D.COD_DEPTO
ORDER BY CTE.COD_DEPTO;

SELECT E.CODFUN, E.NOME, E.COD_DEPTO, E.COD_SUPERVISOR, CTE.NOME
FROM TB_EMPREGADO E JOIN TB_EMPREGADO CTE ON E.COD_SUPERVISOR = CTE.CODFUN
ORDER BY COD_DEPTO;


WITH CTE( CODFUN, NOME, NIVEL, COD_DEPTO, CODSUP, NOME_SUP )
AS
(
	-- Membro �ncora
	SELECT CODFUN, NOME, 1, COD_DEPTO, COD_SUPERVISOR, NOME
	FROM TB_EMPREGADO WHERE COD_SUPERVISOR = 0
	UNION ALL
	-- Membro recursivo
	SELECT E.CODFUN, E.NOME, 
	CTE.NIVEL+1, E.COD_DEPTO, E.COD_SUPERVISOR, CTE.NOME
	FROM TB_EMPREGADO E JOIN CTE ON E.COD_SUPERVISOR = CTE.CODFUN
)
-- Execu��o da CTE
SELECT CTE.CODFUN AS [C�digo], CTE.NOME AS [Funcion�rio], CTE.NIVEL AS [N�vel],
       CTE.NOME_SUP AS [Nome Supervisor]
FROM CTE;


WITH CTE( CODFUN, NOME, NIVEL, COD_DEPTO, CODSUP, NOME_SUP, ARVORE )
AS
(
	-- Membro �ncora
	SELECT CODFUN, NOME, 1, COD_DEPTO, COD_SUPERVISOR, NOME, 
             CAST(NOME AS VARCHAR(MAX))
	FROM TB_EMPREGADO WHERE COD_SUPERVISOR = 0
	UNION ALL
	-- Membro recursivo
	SELECT E.CODFUN, E.NOME, 
	CTE.NIVEL+1, E.COD_DEPTO, E.COD_SUPERVISOR, CTE.NOME, 
     CTE.ARVORE + ' <- ' + E.NOME
	FROM TB_EMPREGADO E JOIN CTE ON E.COD_SUPERVISOR = CTE.CODFUN
)
-- Execu��o da CTE
SELECT CTE.CODFUN AS [C�digo], CTE.NOME AS [Funcion�rio], CTE.NIVEL AS [N�vel],
       CTE.NOME_SUP AS [Nome Supervisor],  CTE.ARVORE AS [�rvore]
FROM CTE;

