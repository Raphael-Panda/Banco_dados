select emp_razaosocial,
pag_fatura,
pag_valor,
pag_datapagto into testeII
from pagar, empresa
where fkempresa = idempresa

--INTO esta criando a tabela testeII com as colunas citadas sem nenhum relacionamento com outras tabelas
----------------------------------------------------------------------------------------------------------------------

select emp_razaosocial,
pag_fatura,
pag_valor,
pag_datapagto into #testeII
from pagar, empresa
where fkempresa = idempresa

-- Criação de tabela temporário usa-se '#' e depois que fecha o sql ela some
-- Escopo local '#' / Escopo global '##'
----------------------------------------------------------------------------------------------------------------------
-- PRIMEIRA QUESTÃO DA PROVA SURPRESA

insert Movbanco
(movban_valor, fkbanco, movban_data)

(select 
	pag_valor, 
	fkbanco, 
	Pag_DataPagto
from Pagar
where datepart(yyyy, getdate()) = 2026
and Pag_DataPagto is not null)
----------------------------------------------------------------------------------------------------------------------
-- SEGUNDA QUESTÃO DA PROVA SURPRESA

select 
	ban_descricao,
	sum(pag_valor),
	count(pag_fatura)
from pagar, banco
where fkbanco = idbanco
and pag_Datapagto is not null
group by ban_descricao

----------------------------------------------------------------------------------------------------------------------

-- TERCEIRA QUESTÃO DA PROVA SURPRESA

select 
	emp_razaosocial,
	sum(pag_valor) as Valor_Pago,
	count(pag_fatura) as Qtd_faturas
from pagar, empresa
where fkempresa = idempresa
	and pag_Datapagto is not null
	and datepart(yyyy, pag_Datapagto) = 2026
group by emp_razaosocial
order by Valor_Pago desc

----------------------------------------------------------------------------------------------------------------------

-- QUARTA QUESTÃO DA PROVA SURPRESA

select 
	max(pag_valor) as maior,
	min(pag_valor) as menor
from pagar

----------------------------------------------------------------------------------------------------------------------

-- QUINTA QUESTÃO DA PROVA SURPRESA

update pagar set
	pag_datapagto = getdate(),
	fkbanco = 1
from empresa, cidade, uf
where fkempresa = idempresa 
	and fkcidade = idcidade 
	and fkuf = iduf
	and descricao = 'ES'