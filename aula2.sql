select emp_razaosocial, cid_nome, descricao
from empresa, cidade, uf
where fkcidade = idcidade and fkuf = iduf

-- pegar nome da empresa, cidade e estado
----------------------------------------------------------------------------------------

select emp_razaosocial, cid_nome, descricao
from empresa, cidade,  uf
where fkcidade = idcidade and fkuf = iduf and descricao in ('ES')

-- pegar somente as empresas do ES
----------------------------------------------------------------------------------------

select emp_razaosocial, cid_nome, descricao
from empresa, cidade,  uf
where fkcidade = idcidade and fkuf = iduf and descricao in ('ES', 'BA', 'RJ')

-- pegar as empresas do ES, BA e RJ
----------------------------------------------------------------------------------------

select emp_razaosocial
from empresa
where idempresa not in (select fkempresa from pagar)

-- listas as empresas que não estão no contas a pagar(para quem eu não devo)
----------------------------------------------------------------------------------------

select * from pagar
where Pag_DataPagto is NULL

-- selecionar todas as empresas que estão com a data de pagamento NULL(empresas que ainda não pagaram)
-- se fizer 'is not NULL' volta as empresas que ja pagaram
----------------------------------------------------------------------------------------

select emp_razaosocial, sum(pag_valor) as Valor_Total
from empresa, pagar
where fkempresa = idempresa
group by emp_razaosocial
order by emp_razaosocial

-- mostrar o valor total das faturas que cada empresa deve pagar
-- sempre que usar 'sum()' precisa usar group by
-- nesse caso o 'order by' esta sendo colocado como ordem alfabetica
----------------------------------------------------------------------------------------

select Pag_DataVencimento, sum(pag_valor) as Valor_Total
from empresa, pagar
where fkempresa = idempresa
group by Pag_DataVencimento
order by Pag_DataVencimento

-- mostrar o total q tem pagar por dia independente da empresa
-- está mostrando o valor total mesmo q tenha empresas diferentes no dia
----------------------------------------------------------------------------------------

select Pag_DataVencimento, sum(pag_valor) as Valor_Total
from empresa, pagar
where fkempresa = idempresa
group by Pag_DataVencimento
having sum(pag_valor) < 5000
order by Pag_DataVencimento

-- agora mostra somentes os dias que tem que pegar menos de 5 mil reais
-- having aplica sobre o group by, primeiro faz o group by e depois aplica o having
----------------------------------------------------------------------------------------