SELECT C.NOME, C.EMAIL, T.NUMERO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE TIPO = 'CEL' AND ESTADO = 'RJ';

+--------+------------------+----------+
| NOME   | EMAIL            | NUMERO   |
+--------+------------------+----------+
| CARLOS | CARLOS@TERRA.COM | 71218326 |
| ANA    | ANA@GLOBO.COM    | 71218326 |
| CELIA  | JOAO@TERRA.COM   | 71218326 |
| JOAO   | JOAO@IG.COM      | 68420838 |
+--------+------------------+----------+


SELECT C.NOME, 
	   C.EMAIL, 
	   T.NUMERO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE SEXO = 'F' AND TIPO = 'CEL' AND ESTADO = 'SP';

Empty set (0.01 sec)

SELECT C.NOME, 
	   IFNULL(C.EMAIL,'SEM EMAIL') AS 'EMAIL', 
	   T.NUMERO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
;





