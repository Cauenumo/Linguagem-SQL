/* Comunicação entre Bancos*/

CREATE DATABASE LOJ;

USE LOJ;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

CREATE DATABASE BACKUP;

USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBKP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT ,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

USE LOJA;

STATUS 

INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL, 1000, 'TESTE',0.0);

SELECT * FROM BACKUP.BKP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUT
AFTER INSERT ON PRODUTO 
FOR EACH ROW 
BEGIN 
	INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL, NEW.IDPRODUTO, NEW.NOME,NEW.VALOR);
END
$

INSERT INTO PRODUTO VALUES (NULL, 'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES (NULL, 'LIVRO BI',80.00);
INSERT INTO PRODUTO VALUES (NULL, 'LIVRO ORACLE',70.00);
INSERT INTO PRODUTO VALUES (NULL, 'LIVRO SQL SERVER',100.00);


CREATE TRIGGER BACKUP_PRODUT_DEL
BEFORE DELETE ON PRODUTO 
FOR EACH ROW 
BEGIN 
	INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL, OLD.IDPRODUTO, OLD.NOME,OLD.VALOR);
END
$

DELETE FROM PRODUTO WHERE IDPRODUTO = 4;

DROP TRIGGER BACKUP_PRODUT;




INSERT INTO PRODUTO VALUES (NULL, 'LIVRO C#',100.00);

SELECT * FROM PRODUTO;
SELECT * FROM BACKUP.BKP_PRODUTO


ALTER TABLE BACKUP.BKP_PRODUTO 
ADD EVENTO CHAR(1);

DROP TRIGGER BACKUP_PRODUT_DEL

DELIMITER $

CREATE TRIGGER BACKUP_PRODUT_DEL
BEFORE DELETE ON PRODUTO 
FOR EACH ROW 
BEGIN 
	INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL, OLD.IDPRODUTO, OLD.NOME,OLD.VALOR, 'D');
END
$

SELECT * FROM PRODUTO;
SELECT * FROM BACKUP.BKP_PRODUTO;


DROP TRIGGER BACKUP_PRODUT;

DELIMITER $ 

CREATE TRIGGER BACKUP_PRODUT
AFTER INSERT ON PRODUTO 
FOR EACH ROW 
BEGIN 
	INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL, NEW.IDPRODUTO, NEW.NOME,NEW.VALOR,'I');
END
$

INSERT INTO PRODUTO VALUES (NULL, 'LIVRO JAVA',100.00);

SELECT * FROM PRODUTO;
SELECT * FROM BACKUP.BKP_PRODUTO;


CREATE DATABASE LOJAA;

USE LOJAA; 

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

INSERT INTO PRODUTO VALUES (NULL, 'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES (NULL, 'LIVRO BI',80.00);
INSERT INTO PRODUTO VALUES (NULL, 'LIVRO ORACLE',70.00);
INSERT INTO PRODUTO VALUES (NULL, 'LIVRO SQL SERVER',100.00);

CREATE DATABASE BACKUP;

USE BACKUP; 

CREATE TABLE BKP_PRODUTO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR_ORIGINAL FLOAT(10,2),
	VALOR_ALTERADO FLOAT(10,2),
	DATA DATETIME,
	USUARIO VARCHAR(30),
	EVENTO CHAR(1)
);

/* QUANDO */ 
SELECT NOW();
/* QUEM */
SELECT CURRENT_USER;



DELIMITER $

CREATE TRIGGER AUDIT_PROD 
AFTER UPDATE ON PRODUTO 
FOR EACH ROW 
BEGIN 
	INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL,OLD.IDPRODUTO,OLD.NOME,
	OLD.VALOR,NEW.VALOR, NOW(), CURRENT_USER(),'U');
END 
$


DELIMITER ;
UPDATE PRODUTO SET VALOR = 110 
WHERE IDPRODUTO = 1;
































