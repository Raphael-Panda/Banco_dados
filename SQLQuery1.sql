--lista 1 exer 1
--Crie um comando SQL que insira na tabela movbanco todos os pagamentos (pagar) realizados no mês atual, copiando o valor pago e o banco correspondente

insert movbanco (movban_valor, fkbanco)
select pag_valor, fkbanco
from pagar
where pag_datapagto is not null
and month(pag_datapagto) = month(getdate())
and year(pag_datapagto) = year(getdate())

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 2
--Crie um comando SQL que mostre a nome da empresa, a cidade e a uf, de todas as empresas localizadas no estado do ES e BA.

select emp_razaosocial, cid_nome, descricao
from empresa, cidade, uf
where descricao in ('ES', 'BA')

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 2.1
--Crie um SQL para mostrar todas as empresas que não possuam registros no contas a pagar (pagar)

select *
from empresa, pagar
where idempresa not in(select fkempresa from pagar)

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 3
--Crie um SQL para mostrar os bancos que ainda não foram utilizados para pagamentos no contas a pagar.

SELECT * 
FROM banco
WHERE idbanco NOT IN (SELECT FKbanco FROM pagar WHERE FKbanco IS NOT NULL)

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 4
--Gere um sql que mostre a quantidade de faturas pagar e o valor pago em cada banco. 

select  ban_descricao, count(*) as qtd_faturas, sum(pag_valor) as total_pago
from pagar,banco
where pag_datapagto is not null
and fkbanco = idbanco
group by Ban_Descricao

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 5
--Gere um sql que mostre o nome da empresa, a fatura, o vencimento e a quantidade de dias em atraso da fatura. 
--Listar somente  faturas que estejam com atraso

select emp_razaosocial, pag_fatura, pag_datavencimento, datediff(dd, pag_datavencimento, getdate()) as dias_atraso
from empresa, pagar
where pag_datapagto is null
and datediff(dd, pag_datavencimento, getdate()) > 0

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 6
--Monte uma consulta que retorne o total pago por cada empresa no ano de 2026.

select emp_razaosocial, sum(pag_valor) as total_pago
from empresa, pagar
where fkempresa = idempresa
and year(pag_datapagto) = year(getdate())
group by emp_razaosocial

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 7
--Monte uma consulta que mostre somente as empresas que possuam contas a pagar com valor acima de R$ 5.000,00

select emp_razaosocial, sum(pag_valor) as total_pago
from empresa, pagar
where fkempresa = idempresa
and pag_datapagto is null
group by emp_razaosocial
having sum(pag_valor) >= 5000

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 8
--Crie uma consulta que retorne:
--	O maior pagamento realizado
--	O menor pagamento realizado


select MAX(pag_valor) as Maior_valor, MIN(pag_valor) as Menor_valor
from empresa, pagar
where fkempresa = idempresa

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 9
--Escreva o comando SQL para adicionar à tabela pagar uma coluna chamada pag_usuário do tipo VARCHAR(80).

Alter table pagar
add pag_usuario varchar(80)

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 10
--Atualize o campo Pag_DataPagto da tabela pagar para a data atual, e o FKbanco para o valor 1,  somente para empresas localizadas no ES.

update pagar
set pag_datapagto = getdate(), fkbanco = 1
from uf, empresa, pagar, cidade
where fkempresa = idempresa and fkcidade = idcidade and fkuf = iduf
and descricao in ('ES')

----------------------------------------------------------------------------------------------------------------

--lista 1 exer 14
--Construa uma consulta que mostre, para cada banco, os pagamentos cujo valor seja maior que a média de pagamentos daquele próprio banco.

select ban_descricao, pag_fatura, pag_valor
from pagar, banco 
where fkbanco = idbanco and pag_valor > (select avg(pag_valor) from pagar where fkbanco = idbanco)

----------------------------------------------------------------------------------------------------------------

--lista 2 exer 1

--Crie um SQL que mostre:
--	id_idmpresa
--	Nome empresa
--	Total recebido
--	Qtd de fatura recebidas
--	Classificação do cliente (*)

select idempresa, emp_razaosocial, sum(rec_valor) as total_recebido, count(*) as qtd_fatura,
case 
	when sum(rec_valor) >= 10000 then 'Cliente Ouro'
	when sum(rec_valor) >= 5000 then 'Cliente Prata'
	when sum(rec_valor) >= 1000 then 'Cliente Bronze'
	else 'Cliente Eventual'
end as Classificação
from empresa, receber
where fkempresa = idempresa and rec_fatura is not null
group by idempresa, emp_razaosocial

----------------------------------------------------------------------------------------------------------------

--lista 2 exer 2
--Liste todas as empresas, mostrando também uma coluna com o status cliente usando:
--ATIVO → se tem alguma fatura lançada no contas a PAGAR nos últimos 12 meses
--INATIVO → se não tem faturas neste período

select idempresa, emp_razaosocial,
case
	when idempresa in (select fkempresa from pagar where datediff(mm, pag_datavencimento, getdate()) < 12)
	then  'Status ativo' else 'Status Inativo' end as StatusCliente
from empresa

--A subconsulta devolve a lista dos IDs das empresas que têm fatura com vencimento nos últimos 12 meses.
--O CASE pergunta para cada empresa: "o ID dela está nessa lista?". Se sim, é ATIVO. Senão, INATIVO.

----------------------------------------------------------------------------------------------------------------

--lista 2 exer 3
--Gere um relatório que mostre a saída abaixo, permitindo que o usuário defina o período desejado.

create proc relatorioPagar
@dataini date, @datafinal date
as
select emp_razaosocial, pag_fatura, pag_datavencimento, pag_datapagto, 
case datepart(dw, pag_datavencimento)
	when 1 then 'Domingo'
	when 2 then 'Segunda'
	when 3 then 'Terça'
	when 4 then 'Quarta'
	when 5 then 'Quinta'
	when 6 then 'Sexta'
	when 7 then 'Sabado'
end as dia,
case
	when pag_datapagto is not null then 'Já Paga'
	else 'Em Aberto' end as dataStatus
from empresa, pagar
where fkempresa = idempresa

exec relatorioPagar @dataini = '2025-07-01', @datafinal = '2026-09-30'

----------------------------------------------------------------------------------------------------------------

--lista 2 exer 3b
--Considerando o contas a pagar, liste todas as empresas mostrando:
--	razão social
--	valor total em aberto 
--	valor total já pago 
--	Saldo a pagar


select *, aberto - pago as diferenca
from
(
select
  emp_razaosocial,
  sum(case when Pag_DataPagto is null then pag_valor else 0 end) as aberto, --soma oa valores em aberto
  sum(case when Pag_DataPagto is not null then pag_valor else 0 end) as pago  --soma os valores pagos
from empresa,
  pagar
where FkEmpresa=Idempresa
group by emp_razaosocial) as tt

----------------------------------------------------------------------------------------------------------------

--lista 2 exer 4

update empresa
set emp_telefone = 'sem numero'
where idempresa in (select fkempresa from receber)

----------------------------------------------------------------------------------------------------------------

--lista 2 exer 12

alter table receber
add rec_nrcheque numeric(18,2)

----------------------------------------------------------------------------------------------------------------



select emp_razaosocial
from empresa
where idempresa in (select fkempresa from receber)
and idempresa not in (select fkempresa from pagar where fkempresa is not null)
