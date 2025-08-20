-- GERAR UM RELATORIO QUE MOSTRE O NOME DA EMPRESA, QUANTIDADE DE FATURA AINDA NÃO PAGA E VALOR TOTAL AINDA NÃO PAGO

select EMP_Razaosocial, sum(Rec_valor) as total, sum(1) as QTD from Empresa, Receber where fkempresa = Idempresa group by EMP_Razaosocial