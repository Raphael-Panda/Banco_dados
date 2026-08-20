select idempresa, fkempresa, emp_razaosocial, pagar.*
from empresa left join pagar
on fkempresa = idempresa

-- left join vai mostrar todos os registros da tabela a esquerda e os correpondentens da outra tabela
-- quando não houver correspondecia na tabela da direita aparece como valor NULL

------------------------------------------------------------------------------------------------------------------------------------------

select idempresa, fkempresa, emp_razaosocial, pagar.*
from empresa right join pagar
on fkempresa = idempresa
-- right join vai mostrar todos os registros da tabela a direita e os correpondentens da outra tabela
-- quando não houver correspondecia na tabela da esquerda aparece como valor NULL

------------------------------------------------------------------------------------------------------------------------------------------

select idempresa, fkempresa, emp_razaosocial, pagar.*
from empresa full join pagar
on fkempresa = idempresa
-- full join une as duas tabelas quando tendo uo não relação
-- quando não há dados correspondentes aparece NULL

------------------------------------------------------------------------------------------------------------------------------------------

select 'hoje é dia ' + cast(getdate() as varchar(12))
-- conversão de valores, convertendo data para varchar
-- usar 'cast' e 'as' para definir o tipo

-- outra forma de fazer conversão

select 'hoje é dia ' + convert(varchar(12), getdate(), 103)
-- no convert tem a diferença de ordem e sem usar o  'as'
-- o convert da a opção de converter a data para o tipo brasileiro
-- o cast não permite fazer essa conversão de data para o tipo brasileiro

------------------------------------------------------------------------------------------------------------------------------------------

select datediff(hh, '2005-08-06', getdate())

-- datediff retorna intervalo de data pode ser do formando de segundo até em anos
-- botando primeiro o formato depois a data inicial e a data final

------------------------------------------------------------------------------------------------------------------------------------------

select emp_razaosocial as empresa, pag_fatura as fatura, pag_valor as valor, pag_datavencimento as vencimento,
datediff(dd, pag_datavencimento, getdate()) as dias
from empresa, pagar
where fkempresa = idempresa 
and Pag_datapagto is null
and datediff(dd, pag_datavencimento, getdate()) > 0

-- mostrar as empresas com as faturas atrasadas no formato de dias

------------------------------------------------------------------------------------------------------------------------------------------

select emp_razaosocial as empresa, pag_fatura as fatura, pag_valor as valor, pag_datavencimento as vencimento,
datediff(dd, pag_datavencimento, getdate()) as dias
from empresa, pagar
where fkempresa = idempresa 
and Pag_datapagto is null
and datediff(dd, pag_datavencimento, getdate()) > 0
order by dias desc

-- mostrar em forma descrescente

------------------------------------------------------------------------------------------------------------------------------------------

select emp_razaosocial as empresa, pag_fatura as fatura, pag_valor as valor, pag_datavencimento as vencimento,
datediff(dd, pag_datavencimento, getdate()) as dias,
datename(dw, pag_datavencimento) as dia_semana
from empresa, pagar
where fkempresa = idempresa 
and Pag_datapagto is null
and datediff(dd, pag_datavencimento, getdate()) > 0
order by dias desc

-- mostrar o dia da semana que cai o vencimento

------------------------------------------------------------------------------------------------------------------------------------------

select emp_razaosocial as empresa, pag_fatura as fatura, pag_valor as valor, pag_datavencimento as vencimento,
datediff(dd, pag_datavencimento, getdate()) as dias,
datename(dw, pag_datavencimento) as dia_semana,
datepart(dw, pag_datavencimento) as num_semana
from empresa, pagar
where fkempresa = idempresa 
and Pag_datapagto is null
and datediff(dd, pag_datavencimento, getdate()) > 0
and datepart(dw, pag_datavencimento) in (7, 1)
order by dias desc

-- mostrar os vencimentos que caem no sabado e domingo

------------------------------------------------------------------------------------------------------------------------------------------

update pagar set
pag_datavencimento = pag_datavencimento + 1
where datepart(dw, pag_datavencimento) = 1

-- passar os vencimentos de sabado e domingo para o proximo dia util no caso é segunda
-- para atualizar dados de uma tabela se usa Update