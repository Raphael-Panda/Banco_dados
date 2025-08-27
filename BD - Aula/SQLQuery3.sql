-- MOSTRAR O NOME DA EMPRESA, DATA DE VENCIMENTO, DIA DA SEMANA, DATA DE PAGAMENTO E DIAS DE ATRASO
-- MOSTRA 0 QUANDO A DATA DE PAGAMENTO N�O FOR NULA, OU SEJA, QUANDO JA ESTIVER PAGO
-- QUEST�O DE PROVA: CASE DENTRO DE CASE

select 
Emp_razaosocial,  
Pag_DataVencimento,
case Datepart(dw,Pag_DataVencimento)
	when 1 then ' Domingo'
	when 2 then 'Segunda'
	when 3 then 'Ter�a'
	when 4 then 'Quarta'
	when 5 then 'Quinta'
	when 6 then 'Sexta'
	when 7 then 'S�bado'
end as dia,
pag_datapagto,
case when pag_datapagto is not null then 0 else
case
	when datediff(dd, pag_datavencimento, getdate()) > 0 then
		datediff(dd, pag_datavencimento, getdate()) else 
		0 end end as atraso
from empresa, pagar where fkEmpresa = Idempresa