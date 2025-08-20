-- GERAR UM RELATORIO QUE MOSTRE: 
-- NOME DA EMPRESA;
-- QUANTIDADE DE FATURAS AINDA NÃO PAGAS;
-- VALOR TOTAL AINDA NÃO PAGO;
-- QUANTIDADE DE FATURAS JA PAGAS;
-- VALOR DAS FATURAS JÁ PAGAS;

select EMP_Razaosocial as Empresa 
sum(case when Pag_DataPagto is not NULL Then 1 Else 0 END) 
sum(case when Pag_DataPagto is NULL Then Pag_valor else 0 END) as Aberto
sum(case when Pag_DataPagto is NULL Then 1 Else 0 END)
sum(case when Pag_Datapagto is not NULL then Pag_valor else 0 END) as Paga 
from Pagar, EMpresa where FkEmpresa = Idempresa