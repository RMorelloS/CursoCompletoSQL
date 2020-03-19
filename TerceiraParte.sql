/*
	Curso SQL Completo 2019 - Terceira parte
	Este script utiliza da base de dados Youtube, criada na pr�pria videoaula.
	Desenvolvido por: Ricardo Morello Santos
	Fonte: Curso SQL Completo 2019 [Iniciantes] + Desafios + Muita Pr�tica
	Dispon�vel em: https://www.youtube.com/watch?v=rX2I7OjLqWE
*/


/* Chave prim�ria e estrangeira
	Chave Prim�ria
		Uma coluna ou grupo de colunas utilizada para identificar unicamente um registro
		em uma tabela
		Chaves prim�rias podem ser criadas por meio de restri��es (constraints). Uma
		constraint � uma regra definida na cria��o de uma coluna.
		Uma chave prim�ria � um �ndice �nico para uma coluna ou conjunto de colunas
		Uma tabela possui apenas uma chave prim�ria.

	Chave estrangeira
		Uma coluna ou grupo de colunas em uma tabela que define unicamente uma linha
		em outra tabela.
		Uma chave estrangeira � definida em uma tabela onde ela � apenas uma refer�ncia
		e n�o cont�m todos os dados ali.
		Trata-se de uma coluna ou grupo de colunas que � uma chave prim�ria em outra tabela. 
	    Uma tabela pode ter mais de uma chave estrangeira.
		No SQL Server, define-se uma chave estrangeira atrav�s de um Foreign Key Constraint,
		ou restri��o de chave estrangeira. Esta restri��o indica que o conjunto de dados
		da chave estrangeira deve ser necessariamente um subconjunto dos dados da coluna
		com chave prim�ria, garantindo a integridade referencial.
*/


/*	Cria��o de tabelas
	Sintaxe:
		CREATE TABLE nome_tabela (
			nomeColuna	tipoDados restricao,
			nomeColuna	tipoDados ...
		);
	Restri��o pode ser:
	NOT NULL:		N�o permite valores nulos na coluna
	UNIQUE:			For�a todos os valores �nicos na coluna
	PRIMARY KEY:	Jun��o de NOT NULL e UNIQUE
	FOREIGN KEY:	Identifica unicamente uma linha em outra tabela
	CHECK:			For�a uma condi��o espec�fica em uma coluna
	DEFAULT:		For�a um valor padr�o quando nenhum valor � informado

*/

--Cria��o da base de dados youtube
CREATE DATABASE youtube
USE youtube

--Cria��o da tabela CANAL

CREATE TABLE CANAL (
CanalID				INT				PRIMARY KEY,
Nome				VARCHAR(150),
ContagemInscritos	INT				DEFAULT 0,
DataCriacao			DATETIME		NOT NULL
);

SELECT * FROM CANAL

--Cria��o da tabela VIDEO

CREATE TABLE VIDEO(
	VideoID				INT				PRIMARY KEY,
	Nome				VARCHAR(150),
	Visualizacoes		INT				DEFAULT 0,
	Likes				INT				DEFAULT 0,
	Dislikes			INT				DEFAULT 0,
	Duracao				INT				NOT NULL,
	CanalID				INT,
	FOREIGN KEY (CanalID) REFERENCES CANAL(CanalID)
);

/* Inser��o de dados

   1) Na mesma ordem definida na cria��o da tabela
	    INSERT INTO nomeTabela
		VALUES	(valor1, valor2)
   2) Em qualquer ordem dos campos
		INSERT INTO nomeTabela(coluna1, coluna2, ...)
		VALUES	(valor1, valor2)
   3) Selecionando dados de outra tabela
		INSERT INTO TabelaA (coluna1)
		SELECT coluna2
		FROM TabelaB
*/

--Inserir um canal na base de dados youtube
INSERT INTO CANAL
VALUES (1, 'Ricardo', 10, GETDATE())

SELECT * FROM CANAL

/*Exerc�cio:
	Inserir tr�s registros na tabela canal e copiar para outra tabela
*/

INSERT INTO CANAL
VALUES (2, 'Jo�o', 100, GETDATE()), 
	   (3, 'Paula', 200, GETDATE()),
	   (4, 'Gabriel', 350, GETDATE());

CREATE TABLE CANALBKP (
CanalID				INT				PRIMARY KEY,
Nome				VARCHAR(150),
ContagemInscritos	INT				DEFAULT 0,
DataCriacao			DATETIME		NOT NULL
);

INSERT INTO CANALBKP
SELECT * FROM CANAL;

SELECT * FROM CANALBKP

/*	Atualizar observa��es na tabela 
	UPDATE tabela
	SET coluna1 = valor1
		coluna2 = valor2
	WHERE condicao
*/

--Atualizar o canal Ricardo na tabela Canal
UPDATE Canal
SET ContagemInscritos = 150,
	DataCriacao = GETDATE(),
	Nome = 'Canal do Ricardo'
WHERE CanalID = 1

SELECT * FROM CANAL


/* Deletar observa��es da tabela 
	DELETE FROM tabela
	WHERE condicao
*/
DELETE FROM Canal
WHERE CanalId = 1

SELECT * FROM CANAL

/* 
	Alterar a estrutura de uma tabela
	ALTER TABLE tabela
	acao

	A��es poss�veis:
	Adicionar, remover ou alterar uma coluna
	Definir valores padr�o para uma coluna
	Adicionar, remover ou alterar constraints
	Renomear uma tabela
*/

--Adicionando um atributo booleano para verificar se o canal est� ativo ou n�o

ALTER TABLE CANAL
ADD ATIVO BIT

--Adicionar uma restri��o not null no nome do video

ALTER TABLE VIDEO
ALTER COLUMN NOME VARCHAR(150) NOT NULL


--Renomear coluna

EXEC sp_rename 'VIDEO.NOME', 'NomeVideo', 'COLUMN'	

--Renomear tabela

EXEC sp_rename 'VIDEO', 'VIDEO_YT';


/* Apagar uma tabela
	Sintaxe: DROP TABLE tabela
	Nota: � necess�rio verificar poss�veis refer�ncias a outras tabelas antes de apagar.
	Para apagar a tabela e as refer�ncias:
	DROP TABLE tabela CASCADE CONSTRAINTS
	
	Para apagar apenas o conte�do da tabela:
	TRUNCATE TABLE tabela
*/

--Apagar a tabela VIDEO_YT
DROP TABLE VIDEO_YT



/* CONSTRAINT CHECK 
	Permite estabelecer restri��es de valores de entrada em colunass
	Sintaxe:
	CREATE TABLE tabela(
		campo1		tipo		CHECK(condicao),
		...
	);
*/

--Criar uma constraint check por meio de um comando alter table em canal

ALTER TABLE CANAL
ADD CONSTRAINT ck_contagem_inscritos CHECK(ContagemInscritos < 1000)

--Tentativa de viola��o da restri��o check:

INSERT INTO CANAL
VALUES(5, 'Joana', 1001, GETDATE(), 1)

/* CONSTRAINT NOT NULL
	Imp�e que um valor deve ser fornecido em determinada coluna para acrescentar a observa��o
	Sintaxe:
	CREATE TABLE tabela(
	coluna1		TIPO		NOT NULL,
	...
	);
*/


--Criar uma constraint not null por meio de um comando alter table em canal

ALTER TABLE CANAL
ALTER COLUMN
  DataCriacao DATETIME NOT NULL;

/* CONSTRAINT UNIQUE
	Define que todos os valores devem ser diferentes em uma coluna. Pode existir mais de uma vez em uma tabela.
	Sintaxe:
	CREATE TABLE tabela(
	campo1	TIPO	UNIQUE,
	...
	);
*/


--Criar uma constraint unique por meio de um comando alter table em canal
ALTER TABLE CANAL
ADD UNIQUE(Nome)

/* Views
	Uma view � um conjunto resultado de uma sele��o que pode ser manipulado de maneira similar � uma tabela.
	Sintaxe:
	CREATE VIEW nomedaview AS
	SELECT campo1, ...
	FROM tabela
	WHERE condicao

*/

--Criando uma view da tabela Canal
CREATE VIEW maiorNumeroInscritos AS
SELECT * 
FROM Canal
WHERE ContagemInscritos > (SELECT AVG(ContagemInscritos)
						  FROM Canal)

SELECT * FROM maiorNumeroInscritos

UPDATE maiorNumeroInscritos 
SET nome = 'Canal do Gabriel'
WHERE CanalID = 4

SELECT * FROM maiorNumeroInscritos
SELECT * FROM canal
