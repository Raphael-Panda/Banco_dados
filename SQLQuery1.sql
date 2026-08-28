-- PROGRAMAÇÃO EM SQL
if
	begin 

	end
-- begin é a primeira condição do if e o end é casa o begin seja falso, else
-- e o case que funciona parecido com o switch
-----------------------------------------------------------------------------------------------------------------------

select
	case datepart(dw,getdate())
	when 1 then 'Domingo'
	when 2 then 'Segunda'
	when 3 then 'Terça'
	when 4 then 'Quarta'
	when 5 then 'Quinta'
	when 6 then 'Sexta'
	when 7 then 'Sabado'
	end as dia
-- retornar um numero que é equivalente ao dia da semana
-----------------------------------------------------------------------------------------------------------------------

select
	emp_razaosocial,
	sum(case when pag_datapagto is null then pag_valor else 0 end) as 'valor a pagar',
	sum(case when pag_datapagto is not null then pag_valor else 0 end) as 'valor ja pago'
from empresa, pagar
where FkEmpresa = idempresa
group by emp_razaosocial

-- cria duas colunas uma com os valores a pagar e outra com valores ja pagos