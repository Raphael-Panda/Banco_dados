alter trigger teste
on pagar for delete, update, insert
as
select * from deleted
select * from inserted

if exists (select * from deleted)
	and not exists (select * from inserted)
	Begin
	 insert auditoria(tabela, operacao, descricao, valor, usuario, data, estacao)
	 (select 'pagar', 'Exclusão', pag_descricao, pag_valor, SUSER_NAME(), getdate(), HOST_NAME() from deleted)

	end

if not exists (select * from deleted)
	and not exists (select * from inserted)
	 select 'quem disparou foi o UPDATE'

if not exists (select * from deleted)
	and  exists (select * from inserted)
	 select 'quem disparou foi o INSERT'












select * from pagar
select * from auditoria






delete from pagar where idpagar in (3548)
















select * from pagar