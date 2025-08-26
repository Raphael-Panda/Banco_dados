-- QUESTÃO 5 DA LISTA 2
-- Defina os seguintes limites para as empresas:
--	a) Empresas localizadas no ES limite de 1.000,00
--	b) Empresas localizadas na BA limite de 2.000,00
--	b) Empresas localizadas no RS limite de 5.000,00


update empresa set Emp_Limite = 1000 from cidade, UF where Fkcidade = Idcidade and FkUF = IdUF and UF_descricao = 'ES'

update empresa set Emp_Limite = 2000 from cidade, UF where Fkcidade = Idcidade and FkUF = IdUF and UF_descricao = 'BA'

update empresa set Emp_Limite = 5000 from cidade, UF where Fkcidade = Idcidade and FkUF = IdUF and UF_descricao = 'RS'