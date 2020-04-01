Use TSQL2012
Select * From Disciplina

 -- disciplinas que o professor ministra | Basilio
SELECT C.Nome Coordenador, D.NOME Disciplina, D.StatusDisciplina Status, D.DataDisciplina [Data da Disciplina], DO.Ano,
DO.Semestre, DO.Turma, D.CargaHoraria
FROM Disciplina D
JOIN DisciplinaOfertada DO ON D.ID = DO.ID
JOIN Coordenador C ON C.ID = DO.IdCoordenador

---disciplina - informações uteis | Victor
SELECT Disciplina.Nome, Disciplina.StatusDisciplina, Coordenador.Nome [Nome do Coordenador], Disciplina.PlanoDeEnsino, Disciplina.CargaHoraria,
Disciplina.ConteudoProgramatico 
FROM Disciplina
JOIN Coordenador ON Disciplina.ID = Coordenador.ID

--qual disciplina foi ofertada para cada professor | Guilherme Santos
SELECT P.APELIDO [Nome do Professor],D.NOME [Disciplina], DO.DTINICIOMATRICULA [Inicio da Disciplina],
  DO.DTFIMMATRICULA [Fim da Disciplina], DO.ANO, DO.SEMESTRE, DO.TURMA
  FROM DisciplinaOfertada DO
  JOIN Professor P
  ON DO.IdProfessor = P.ID
  JOIN Disciplina D
  ON DO.IdDisciplina = D.ID

--conteudo de entrega da atividade pelo aluno | Guilherme Marques
SELECT Al.Nome AS 'Nome do Aluno', Al.RA AS 'RA do Aluno', D.Nome AS 'Nome da Disciplina', E.Titulo AS 'Nome da Atividade',
E.Resposta AS 'Resposta',
E.DtEntrega AS 'Data de Entrega', E.[Status] AS 'Status de entrega'
FROM Entrega AS E JOIN Aluno AS Al ON E.IdAluno = Al.ID,
Disciplina AS D JOIN DisciplinaOfertada ON D.ID = DisciplinaOfertada.IdDisciplina
JOIN AtividadeVinculada  ON AtividadeVinculada.IdDisciplinaOfertada = DisciplinaOfertada.ID
WHERE E.[Status] = 'Entregue'
ORDER BY Al.RA ASC

-- verificar as disciplinas em um curso | Brando
SELECT C.Nome AS [Nome do Curso], D.Nome AS [Nome da Disciplina], D.CargaHoraria AS [Carga Horária],
D.PlanoDeEnsino AS [Plano de Ensino]
FROM Disciplina AS D
JOIN DisciplinaOfertada AS DO ON D.ID = DO.IdDisciplina
JOIN Curso AS C ON DO.IdCurso = C.ID

------------------------------------------------------------------------------------------------------
-- qnt da atividades, disciplina com status 'aberta' | Basilio -> Guilherme Santos
SELECT D.Nome Disciplina,COUNT(0) [Qtd Atividades] FROM Atividade A
JOIN AtividadeVinculada AV ON AV.IdAtividade = A.ID
JOIN DisciplinaOfertada OD ON OD.ID = AV.IdDisciplinaOfertada
JOIN Disciplina D ON D.ID = OD.IdDisciplina
WHERE D.StatusDisciplina LIKE 'Aberta'
GROUP BY D.Nome

--qnt mensagens que o prof envia para aluno | Victor
select count (M.ID) AS 'Quantidade_de_mensagens', P.Apelido as 'apelido_Professor'
from Mensagem as M JOIN Professor as P ON M.ID = P.ID
group by P.Apelido

--qnt de atividade entregues pelo professor ao aluno | Guilherme Santos
SELECT P.apelido [Apelido do Professor], AV.rotulo [AC], E.Titulo, E.DtEntrega
[Data da Entrega], E.Nota, COUNT(E.Status) [Quantidade de Entregas], A.Nome [Nome Aluno]
FROM AtividadeVinculada AV
JOIN Entrega E ON E.IdAtividadeVinculada = AV.ID
JOIN Professor P ON AV.IdProfessor = P.ID
JOIN Aluno A ON E.IdAluno = A.ID
WHERE E.[Status] LIKE 'Entregue'
GROUP BY P.apelido, AV.rotulo, E.Titulo, E.DtEntrega, E.Nota, E.[Status], A.Nome

--qnt de alunos matriculados | Guilherme Marques
SELECT SM.[Status] AS 'Progresso da Solicitação', COUNT(Al.ID) AS 'Numero de Alunos Matriculados'
FROM Aluno AS Al JOIN SolicitacaoMatricula AS SM ON Al.ID = SM.IdAluno
WHERE [Status] = 'Solicitada'
GROUP BY SM.[Status]

-- qnt de alunos por disciplina//curso | Basilio
SELECT D.Nome Disciplina, COUNT(0) [Qtd Alunos] FROM Curso C
JOIN DisciplinaOfertada DO ON DO.IdCurso = C.ID
JOIN SolicitacaoMatricula SM ON SM.IdDisciplinaOfertada = DO.ID
JOIN Aluno A ON A.ID = SM.IdAluno
JOIN Disciplina D ON D.ID = DO.IdDisciplina
GROUP BY D.ID, D.Nome
