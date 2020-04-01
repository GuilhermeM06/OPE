use TSQL2012

SELECT D.Nome AS 'Disciplina', C.Nome AS 'Nome do Coordenador', C.Email AS 'Email para Contato', C.Celular AS 'Celular para Contato'
FROM Disciplina AS D JOIN Coordenador AS C ON D.IdCoordenador = C.ID