-- CONVERSÃO DE DADOS COM 'CONVERT'
-- MUITO USADO COM DATAS

select cast(pag_datavencimento as varchar(12)) as data_cast, convert(varchar(12), pag_datavencimento, 103) as data_convert, * from Pagar