-- MOSTRAR O NOME DA EMPRESA, DATA DE VENCIMENTO, DIA DA SEMANA, DATA DE PAGAMENTO E DIAS DE ATRASO
-- MOSTRA 0 QUANDO A DATA DE PAGAMENTO NÃO FOR NULA, OU SEJA, QUANDO JA ESTIVER PAGO
-- QUESTÃO DE PROVA: CASE DENTRO DE CASE

select 
Emp_razaosocial,  
Pag_DataVencimento,
case Datepart(dw,Pag_DataVencimento)
	when 1 then ' Domingo'
	when 2 then 'Segunda'
	when 3 then 'Terça'
	when 4 then 'Quarta'
	when 5 then 'Quinta'
	when 6 then 'Sexta'
	when 7 then 'Sábado'
end as dia,
pag_datapagto,
case when pag_datapagto is not null then 0 else
case
	when datediff(dd, pag_datavencimento, getdate()) > 0 then
		datediff(dd, pag_datavencimento, getdate()) else 
		0 end end as atraso
from empresa, pagar where fkEmpresa = Idempresa