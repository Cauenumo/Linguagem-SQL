USE PEDIDOS

GO
--PIVOT
SELECT CODVEN, MONTH(DATA_EMISSAO) AS MES, 
       YEAR(DATA_EMISSAO) AS ANO,
       SUM(VLR_TOTAL) AS TOT_VENDIDO
FROM TB_PEDIDO
WHERE YEAR(DATA_EMISSAO) = 2014
GROUP BY 
   CODVEN , MONTH(DATA_EMISSAO), YEAR(DATA_EMISSAO) 
ORDER BY 1,2,3

-- Consulta de vendas por vendedor

SELECT CODVEN, [1] AS MES1, [2] AS MES2, [3] AS MES3, 
               [4] AS MES4, [5] AS MES5, [6] AS MES6, 
               [7] AS MES7, [8] AS MES8, [9] AS MES9, 
               [10] AS MES10, [11] AS MES11, [12] AS MES12
FROM (SELECT CODVEN, VLR_TOTAL, MONTH(DATA_EMISSAO) AS MES
      FROM TB_PEDIDO
      WHERE YEAR(DATA_EMISSAO) = 2014) P
   PIVOT( SUM(VLR_TOTAL) FOR MES IN ([1], [2], [3], [4], [5], [6],  
                                     [7], [8], [9], [10], [11], 
                                     [12]) ) AS PVT
ORDER BY 1  

--Consulta vendas por vendedor (com nome)
SELECT CODVEN, NOME, [1] AS MES1, [2] AS MES2, [3] AS MES3, [4] AS MES4, [5] AS MES5, 
               [6] AS MES6, [7] AS MES7, [8] AS MES8, [9] AS MES9, [10] AS MES10,
               [11] AS MES11, [12] AS MES12
FROM (SELECT P.CODVEN, V.NOME, P.VLR_TOTAL, MONTH(P.DATA_EMISSAO) AS MES
      FROM TB_PEDIDO P JOIN TB_VENDEDOR V ON P.CODVEN = V.CODVEN
      WHERE YEAR(P.DATA_EMISSAO) = 2014) P
      PIVOT( SUM(VLR_TOTAL) FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS PVT
ORDER BY 1

--Consulta vendas por cliente
SELECT CODCLI, [1] AS MES1, [2] AS MES2, [3] AS MES3, [4] AS MES4, 
               [5] AS MES5, [6] AS MES6, [7] AS MES7, [8] AS MES8, 
               [9] AS MES9, [10] AS MES10,[11] AS MES11, 
               [12] AS MES12
FROM (SELECT CODCLI, VLR_TOTAL, MONTH(DATA_EMISSAO) AS MES
      FROM TB_PEDIDO
      WHERE YEAR(DATA_EMISSAO) = 2014) P
   PIVOT( SUM(VLR_TOTAL) FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS PVT
ORDER BY 1 

--Consulta vendas por cliente
SELECT CODCLI, NOME, [2008] AS '2008', [2009] AS '2009',
                     [2010] AS '2010', [2011] AS '2011',
                     [2012] AS '2012', [2013] AS '2013',
                     [2014] AS '2014', [2015] AS '2015'
FROM (SELECT P.CODCLI, C.NOME, P.VLR_TOTAL, 
             YEAR(P.DATA_EMISSAO) AS ANO
      FROM TB_PEDIDO P 
        JOIN TB_CLIENTE C ON P.CODCLI = C.CODCLI) AS X
PIVOT( SUM(VLR_TOTAL) FOR ANO IN ([2008],[2009],[2010],[2011],
                              [2012],[2013],[2014],[2015])) AS Y 

-- Vendas por produto
SELECT ID_PRODUTO, [1] AS MES1, [2] AS MES2, [3] AS MES3, 
                   [4] AS MES4, [5] AS MES5, [6] AS MES6, 
                   [7] AS MES7, [8] AS MES8, [9] AS MES9, 
                   [10] AS MES10, [11] AS MES11, [12] AS MES12
FROM (SELECT I.ID_PRODUTO, I.QUANTIDADE*I.PR_UNITARIO AS VALOR, MONTH(P.DATA_EMISSAO) AS MES
      FROM TB_PEDIDO P 
           JOIN TB_ITENSPEDIDO I ON P.NUM_PEDIDO = I.NUM_PEDIDO
      WHERE YEAR(P.DATA_EMISSAO) = 2014) I
   PIVOT( SUM(VALOR) FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS PVT
ORDER BY 1  

--Consulta vendas por ano

SELECT ANO, [1] AS MES1, [2] AS MES2, [3] AS MES3, [4] AS MES4, 
            [5] AS MES5, [6] AS MES6, [7] AS MES7, [8] AS MES8, 
            [9] AS MES9, [10] AS MES10,
            [11] AS MES11, [12] AS MES12
FROM (SELECT YEAR(DATA_EMISSAO) AS ANO, VLR_TOTAL, MONTH(DATA_EMISSAO) AS MES
      FROM TB_PEDIDO) P
   PIVOT( SUM(VLR_TOTAL) FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS PVT
ORDER BY 1 


--Consulta vendas por m�s
SELECT MES,  [2012] AS ANO_2012, [2013] AS ANO_2013, [2014] AS ANO_2014, [2015] AS ANO_2015
FROM ( SELECT MONTH(DATA_EMISSAO) AS MES,  VLR_TOTAL, YEAR(DATA_EMISSAO) AS ANO FROM TB_PEDIDO ) P
PIVOT( SUM(VLR_TOTAL) FOR ANO IN ([2012],[2013],[2014],[2015]) )   AS PVT
ORDER BY 1


-- N�O FUNCIONA
SELECT COD_DEPTO, ['A'], ['B'], ['C'], ['D'], ['E']
FROM (SELECT CODFUN,COD_DEPTO, LEFT(NOME,1) AS LETRA FROM TB_EMPREGADO) AS P
PIVOT (COUNT(CODFUN) FOR LETRA IN (['A'], ['B'], ['C'], ['D'], ['E'])) AS PVT



-- FUNCIONA
SELECT COD_DEPTO, [65], [66], [67], [68], [69]
FROM (SELECT CODFUN,COD_DEPTO, ASCII( UPPER(LEFT(NOME,1))) AS LETRA FROM TB_EMPREGADO) AS P
PIVOT (COUNT(CODFUN) FOR LETRA IN ([65], [66], [67], [68], [69])) AS PVT


--UNPIVOT
GO
CREATE TABLE FREQ_CINEMA
( DIA_SEMANA TINYINT, 
  SEC_14HS   INT, 
  SEC_16HS   INT, 
  SEC_18HS   INT, 
  SEC_20HS   INT, 
  SEC_22HS   INT )
  
INSERT FREQ_CINEMA VALUES ( 1, 80, 100, 130, 90, 70 )  
INSERT FREQ_CINEMA VALUES ( 2, 20, 34, 75, 50, 30 )
INSERT FREQ_CINEMA VALUES ( 3, 25, 40, 80, 70, 25 )
INSERT FREQ_CINEMA VALUES ( 4, 30, 45, 70, 50, 30 )
INSERT FREQ_CINEMA VALUES ( 5, 35, 40, 60, 60, 40 )

GO

INSERT FREQ_CINEMA VALUES ( 6, 25, 34, 70, 90, 110 )
INSERT FREQ_CINEMA VALUES ( 7, 30, 80, 130, 150, 180 )


SELECT * FROM FREQ_CINEMA

-- Consulta frequ�ncia cinema por dia
SELECT DIA_SEMANA, HORARIO, QTD_PESSOAS               
FROM
(               
SELECT DIA_SEMANA, SEC_14HS, SEC_16HS, SEC_18HS, SEC_20HS, SEC_22HS
FROM FREQ_CINEMA
) P
UNPIVOT ( QTD_PESSOAS FOR HORARIO IN (SEC_14HS, SEC_16HS, SEC_18HS, SEC_20HS, SEC_22HS)) AS UP






