-- GERAR UM RELATORIO QUE MOSTRE O NOME DA EMPRESA, QUANTIDADE DE FATURA AINDA N�O PAGA E VALOR TOTAL AINDA N�O PAGO

select EMP_Razaosocial, sum(Rec_valor) as total, sum(1) as QTD from Empresa, Receber where fkempresa = Idempresa group by EMP_Razaosocial