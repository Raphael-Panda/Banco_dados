--criação de variavel precisa ter @ antes do nome
--precisa declarar a variavel antes de usar com declare
--após o declare vem o nome e o valor da variavel @valor numeric(18,2)
--para atribruir um valor a uma variavel usa-se set e/ou select

----------------------------------------------------------------------------------------------------------------------------

declare @totalgeral numeric(18,2)

select @totalgeral = sum(pag_valor)
from pagar
where pag_datapagto is null

select emp_razaosocial,
sum(pag_valor) as totalempresa,
(sum(pag_valor)/@totalgeral) * 100 as '% do valor em atraso'
from pagar, empresa 

where fkempresa = idempresa
and pag_datapagto is null
group by emp_razaosocial
having (sum(pag_valor)/@totalgeral) * 100 >= 5
order by totalempresa desc

----------------------------------------------------------------------------------------------------------------------------

create proc faturas_pagar
as
declare @totalgeral numeric(18,2)
select @totalgeral = sum(pag_valor)
from pagar
where pag_datapagto is null

select emp_razaosocial,
sum(pag_valor) as totalempresa,
(sum(pag_valor)/@totalgeral) * 100 as '% do valor em atraso'
from pagar, empresa 

where fkempresa = idempresa
and pag_datapagto is null
group by emp_razaosocial
having (sum(pag_valor)/@totalgeral) * 100 >= 5
order by totalempresa desc

exec faturas_pagar

--criando Store Procedure

----------------------------------------------------------------------------------------------------------------------------

alter proc faturas_pagar
(@datainicial date, @datafinal date)
as
declare @totalgeral numeric(18,2)
select @totalgeral = sum(pag_valor)
from pagar
where pag_datapagto is null
and pag_datavencimento >= @datainicial
and pag_datavencimento <= @datafinal

select emp_razaosocial,
sum(pag_valor) as totalempresa,
(sum(pag_valor)/@totalgeral) * 100 as '% do valor em atraso'
from pagar, empresa 

where fkempresa = idempresa
and pag_datapagto is null
and pag_datavencimento >= @datainicial
and pag_datavencimento <= @datafinal
group by emp_razaosocial
having (sum(pag_valor)/@totalgeral) * 100 >= 5
order by totalempresa desc

EXEC faturas_pagar @datainicial = '2026-01-01', @datafinal = '2026-12-12';

-- buscando agora as faturas com um filtro de data incial e final dentro do store procedure

----------------------------------------------------------------------------------------------------------------------------

alter proc faturas_pagar
(@datainicial date, @datafinal date, @empresa varchar(50))
as
declare @totalgeral numeric(18,2)
select @totalgeral = sum(pag_valor)
from pagar, empresa
where pag_datapagto is null
and pag_datavencimento >= @datainicial
and pag_datavencimento <= @datafinal
and emp_razaosocial like '%' + @empresa + '%'

select emp_razaosocial,
sum(pag_valor) as totalempresa,
(sum(pag_valor)/@totalgeral) * 100 as '% do valor em atraso'
from pagar, empresa 

where fkempresa = idempresa
and pag_datapagto is null
and pag_datavencimento >= @datainicial
and pag_datavencimento <= @datafinal
and emp_razaosocial like '%' + @empresa + '%'

group by emp_razaosocial
having (sum(pag_valor)/@totalgeral) * 100 >= 5
order by totalempresa desc

EXEC faturas_pagar @datainicial = '2026-01-01', @datafinal = '2026-12-12',
				   @empresa = 'Atlântica';

--agora que possa ser buscada uma empresa em especifico