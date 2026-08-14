select emp_dtvalidade, *
from empresa 
where emp_dtvalidade between '2026/08/21' and '2026/08/30'

-- mostrar as empresas que vão vencer do dia 21 ao dia 30 de agosto
--------------------------------------------------------------------------------------------------

select emp_razaosocial, pag_fatura, Pag_DataVencimento, pag_valor 
from empresa, pagar
where fkempresa = idempresa

union all

select emp_razaosocial, rec_fatura, rec_vencimento, rec_valor
from empresa, receber
where fkempresa = idempresa

-- Union all vai juntar valores de dois selects de duas tabelas diferentes
-- Os campos que vão ser unidos precisam ter o mesmo tipo de valor
--------------------------------------------------------------------------------------------------

select 'pagar' as tipo, emp_razaosocial, pag_fatura, Pag_DataVencimento, pag_valor 
from empresa, pagar
where fkempresa = idempresa

union all

select 'receber' as tipo, emp_razaosocial, rec_fatura, rec_vencimento, rec_valor
from empresa, receber
where fkempresa = idempresa
order by Pag_DataVencimento

-- Agora está ordenando as duas tabelas por data de vencimento
-- Agora está ordenado por tipo pagar ou receber
--------------------------------------------------------------------------------------------------

select 'pagar' as tipo, emp_razaosocial, pag_fatura, Pag_DataVencimento, pag_valor into prov
from empresa, pagar
where fkempresa = idempresa

select * from prov
drop table prov

-- INTO copia os dado e com um novo nome de uma tabela para uma nova tabela
--------------------------------------------------------------------------------------------------

select * into teste
from pagar
where 1=2

select * from teste

-- Criação de tabela sem nenhuma linha/dado apenas as colunas
-- Passar um valor que sempre é falso no where pois ele nunca será atendido e a tabela ficará vazia
--------------------------------------------------------------------------------------------------

-- Lista de exercicio


-- 1) Crie um comando SQL que insira na tabela movbanco todos os pagamentos (pagar) realizados no mês atual, copiando o valor pago e o banco correspondente.

select pag_descricao, pag_valor, Pag_datapagto, fkbanco
from pagar
where month(pag_datapagto) = 1
	and year(pag_datapagto) = 2026

-- copiar o select e botar no insert

insert Movbanco
(movban_descricao, movban_valor, movban_data, fkbanco)

(select pag_descricao, pag_valor, Pag_datapagto, fkbanco
from pagar
where month(pag_datapagto) = 1
	and year(pag_datapagto) = 2026)