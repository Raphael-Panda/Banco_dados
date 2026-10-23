create proc transferencia
(@idbancoorigem int, @idbancodestino int, @valor numeric(18,2))
as
begin try
begin tran
	update banco set ban_saldo = ban_saldo - @valor
	where idbanco = @idbancoorigem

	update banco set ban_saldo = ban_saldo + @valor
	where idbanco = @idbancodestino
	commit
end try
begin catch
	rollback
end catch

exec transferencia 1, 2, 300

select * from banco