create proc spEfetuarRecebimento
(@IdReceber int, @DataRecebimento date, @ValorRecebido numeric(18,2), @fkconta int)
as
begin try
	if not exists (select idreceber from receber where idreceber=@IdReceber)
		throw 50081, 'id não existe', 1

	if exists (select rec_valor from receber where rec_valor>@valorRecebido
													and Idreceber=@IdReceber)
		throw 50001, 'valor informado é menor que a fatura', 1

	begin tran
		update receber set 
			rec_pagto = @datarecebimento,
			rec_valor = @valorRecebido,
			fkbanco = @fkconta
		   where idreceber = @IdReceber

		   update banco set ban_saldo = Ban_saldo + @valorRecebido
			 where IdBanco = @fkconta
	commit
end try
begin catch
	rollback
	select 'deu erro:' +ERROR_MESSAGE()
end catch

