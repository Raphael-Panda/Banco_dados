-- TOTAL QUE CADA EMPRESA ESTA DEVENDO, MESMO AS QUE NÃO DEVEM NADA
-- isnull transforma o NULL em 0

select Emp_razaosocial, isnull(sum(rec_valor),0) as total from empresa left join receber on fkempresa = idempresa group by Emp_RazaoSocial