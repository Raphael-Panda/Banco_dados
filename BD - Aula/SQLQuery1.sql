-- SOMA TUDO QUE ESTA EM ABERTO E ARMAZENA NA VARIAVEL
declare @totalgeral numeric(18,2)
select @totalgeral = sum(pag_valor) from pagar where Pag_DataPagto is null

-- SOMANDO TUDO O QUE A EMPRESA DEVE E DIVIDINDO PELO VALOR GERAL E DIVIDINDO PARA PEGAR A PORCETANGEM
select emp_razaosocial, sum(pag_valor) as totalempresa, sum(pag_valor)/ (@totalgeral) * 100 as '% do valor em atraso'
from pagar, empresa where FkEmpresa = Idempresa
and pag_datapagto is null group by emp_razaosocial 

having count(pag_valor) > 5 -- PEGAR SOMENTE AS EMPRESAS QUE DEVEM MAIS DE 5%

order by totalempresa desc -- ORDER BY SEMPRE POR ÚLTIMO

Update pagar set pag_datapagto = null where IdPagar > 10
Update pagar set fkempresa = 4 where IdPagar in (3,7,9)