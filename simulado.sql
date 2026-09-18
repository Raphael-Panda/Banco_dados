-- 1 questão simulado

create proc total_UF
@datainicial date, @datafinal date, @uf varchar(2)
as
select ram_descricao, descricao, sum(pag_valor) as total
from pagar, ramo, uf, cidade, empresa
where fkempresa = idempresa and fkcidade = idcidade and fkramo = idramo and fkuf = iduf 
and pag_datapagto >= @datainicial
and pag_datapagto <= @datafinal
and descricao = isnull(@uf,descricao)
group by ram_descricao, descricao

exec total_UF @datainicial = '2026-01-01', @datafinal = '2026-12-01', @uf = 'ES'