-- MOSTRAR APENAS QUANDO A EMPRESA DEVE MAIS DE 1000 REAIS
-- HAVING SE USA DEPOIS QUE TOTALIZAR O VALOR (SE USA DEPOIS DO GROUP BY)

select EMP_Razaosocial, sum(Rec_valor) as total, sum(1) as QTD from Empresa, Receber where fkempresa = Idempresa group by EMP_Razaosocial 
having sum(Rec_Valor) > 1000