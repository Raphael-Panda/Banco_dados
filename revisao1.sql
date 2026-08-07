insert ramo 
(ram_Descricao,
Digitacao,
DataDigitacao)
Values
('aulas', 'windowns', getdate()),
('provas', 'linux', getdate()),
('materias', 'mac', getdate())

---------------------------------------------------------------------------------------------

insert ramo 
(ram_Descricao,
Digitacao,
DataDigitacao)

(select cur_nome, cur_vagas, getdate() from curso)

---------------------------------------------------------------------------------------------

update ramo set
ram_descricao = 'Atacadista de Frutas'
where idramo = 65

----------------------------------------------------------------------------------------------

update ramo set
ram_descricao = 'atacadista',
alteracao = 'raphael',
DataAlteracao = getdate()
where idramo in (65, 48, 28)  


----------------------------------------------------------------------------------------------

delete ramo
where idramo in (28, 46, 47)

----------------------------------------------------------------------------------------------

select Emp_RazaoSocial, Pag_Fatura, Pag_Valor, Pag_DataPagto
from empresa, pagar                   -- from empresa join pagar on fkempresa=idempresa
where fkempresa = idempresa

----------------------------------------------------------------------------------------------

select Emp_RazaoSocial, Pag_Fatura, Pag_Valor, Pag_DataPagto, Ram_Descricao
from empresa, pagar, ramo
where fkempresa = idempresa and fkramo = idramo
and Pag_Valor < 1000

-----------------------------------------------------------------------------------------------







select * from pagar