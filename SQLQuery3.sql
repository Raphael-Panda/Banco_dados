-- criação da trigger
create trigger teste
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


---------------------------------------------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------------------------------------------------------------


--alteração da trigger com insteade of
-- e automatização de alguns processos, EX: limitação para delete e confirmação de exsitencia de idempresa na tabela empresa

alter trigger [dbo].[teste]
on [dbo].[Pagar] INSTEAD of delete
as

	if exists (select * from deleted where pag_datapagto is not null)
		begin
			select 'não é possivel excluir registros pagos'
		end
		else
			delete pagar where idpagar in (select idpagar from deleted)

	if not exists ( select idempresa from empresa where idempresa = fkempresa)
		begin

-- o comando dentro do instead of executa primeiro e valida se o comando pode ser executado, exemplo se determinado delete pode ser executado

if exists (select * from deleted)
and not exists (select * from inserted)
begin
	insert auditoria(tabela, operacao, descricao, valor, usuario, data, estacao)
	 (select 'pagar', 'Exclusão', pag_descricao, pag_valor, SUSER_NAME(), getdate(), HOST_NAME() from deleted)

	end
if not exists (select * from deleted)
	and  exists (select * from inserted)
	 select 'quem disparou foi o INSERT'

if not exists (select * from deleted)
	and not exists (select * from inserted)
	 select 'quem disparou foi o UPDATE'




---------------------------------------------------------------------------------------------------------------------------------------------------------------------




delete pagar where idpagar in (3551)

insert pagar (pag_valor) values (5000)

select * from auditoria