-- CONVERSÃO DE DADOS COM 'CAST'

select Emp_razaosocial, 'total a receber --> '+ cast(isnull(sum(rec_valor),0) as Varchar(12)) as total from empresa left join receber on fkempresa = idempresa group by Emp_RazaoSocial