TYPE=VIEW
query=select `c`.`NOME` AS `NOME`,`c`.`SEXO` AS `SEXO`,`c`.`EMAIL` AS `EMAIL`,`t`.`TIPO` AS `TIPO`,`t`.`NUMERO` AS `NUMERO`,`e`.`BAIRRO` AS `BAIRRO`,`e`.`CIDADE` AS `CIDADE`,`e`.`ESTADO` AS `ESTADO` from ((`comercio`.`cliente` `c` join `comercio`.`telefone` `t` on((`c`.`IDCLIENTE` = `t`.`ID_CLIENTE`))) join `comercio`.`endereco` `e` on((`c`.`IDCLIENTE` = `t`.`ID_CLIENTE`)))
md5=4e53cafe5b4f33af6c0cf8ea550c0bf0
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2018-06-28 00:30:38
create-version=1
source=SELECT C.NOME,\n       C.SEXO,\n   C.EMAIL,\n   T.TIPO,\n   T.NUMERO,\n   E.BAIRRO,\n   E.CIDADE,\n   E.ESTADO\nFROM CLIENTE C \nINNER JOIN TELEFONE T\nON C.IDCLIENTE = T.ID_CLIENTE\nINNER JOIN ENDERECO E \nON C.IDCLIENTE = T.ID_CLIENTE
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `c`.`NOME` AS `NOME`,`c`.`SEXO` AS `SEXO`,`c`.`EMAIL` AS `EMAIL`,`t`.`TIPO` AS `TIPO`,`t`.`NUMERO` AS `NUMERO`,`e`.`BAIRRO` AS `BAIRRO`,`e`.`CIDADE` AS `CIDADE`,`e`.`ESTADO` AS `ESTADO` from ((`comercio`.`cliente` `c` join `comercio`.`telefone` `t` on((`c`.`IDCLIENTE` = `t`.`ID_CLIENTE`))) join `comercio`.`endereco` `e` on((`c`.`IDCLIENTE` = `t`.`ID_CLIENTE`)))
