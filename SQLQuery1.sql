create proc meubackup
as

declare @dia varchar(50)

-- traduz para portugues
set @dia = case datepart(dw,getdate())
	when 1 then 'bkp_Domingo'
	when 2 then 'bkp_Segunda'
	when 3 then 'bkp_Terça'
	when 4 then 'bkp_Quarta'
	when 5 then 'bkp_Quinta'
	when 6 then 'bkp_sexta'
	when 7 then 'bkp_Sábado'
end

set @dia = 'c:\devc\'+@dia

backup database uvv to disk = @dia

exec meubackup

-- Criar uma SP para efetuar uma rotina de backup semanal criar um backup com um nome diferente para cada dia da semana.

------------------------------------------------------------------------------------------------------------------------------------

create proc insere_fatura
(@fatura varchar(50),
@descricao varchar(80),
@vencimento date,
@valor numeric(18,2))
as

insert pagar 
	(pag_fatura, pag_descricao, Pag_DataVencimento, pag_valor)
values
	(@fatura, @descricao, @vencimento, @valor)

exec insere_fatura @fatura='teste',
@descricao='novafatura',
@vencimento='2026/09/04',
@valor=67000

select * from pagar

--inserir uma fatura no contas a pagar atravez de uma SP

------------------------------------------------------------------------------------------------------------------------------------

create proc insere_fatura
(@fatura varchar(50),
@descricao varchar(80),
@vencimento date,
@valor numeric(18,2),
@idpagar int)
as

if(@idpagar= 0)
	begin
		insert pagar 
			(pag_fatura, pag_descricao, Pag_DataVencimento, pag_valor)
		values
			(@fatura, @descricao, @vencimento, @valor)

		exec insere_fatura @fatura='teste',
		@descricao='novafatura',
		@vencimento='2026/09/04',
		@valor=67000

	end
		update pagar set
			pag_fatura = @fatura,
			pag_descricao = @descricao,
			pag_valor = @valor,
			pag_datavencimento = @vencimento,
			where IdPagar = @idpagar

--deixar o usuário escolher se deseja fazer um insert ou update baseado no id que for passado
