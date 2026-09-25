declare @classificacao int
select idempresa, emp_razaosocial, rec_valor, sum(pag_fatura) as QTD_faturas
from empresa, receber, pagar
where fkempresa = idempresa
group by emp_razaosocial

set @classificacao = case
	when @classificacao < 100 then 'Cliente Eventual'
	when @classificacao >= 1000 then 'Cliente Bronze'
	when @classificacao >= 5000 then 'Cliente Prata'
	when @classificacao >= 10000 then 'Cliente Ouro'
end
--algo errado
----------------------------------------------------------------------------------------------------------------------------

select emp_razaosocial,
case when idempresa in (select fkempresa from pagar
		where datediff(mm, pag_Datavencimento, getdate()) < 12)
	then 'Empresa Ativa' else 'Empresa Inativa'
end as Status
from empresa

----------------------------------------------------------------------------------------------------------------------------

update empresa set 
emp_telefone = 'Sem telefone'
where emp_telefone is null
and idempresa in (select fkempresa from receber)
