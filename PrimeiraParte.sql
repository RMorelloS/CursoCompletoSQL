/*
	Curso SQL Completo 2019
	Este script utiliza da base de dados AdventureWorks2017. O arquivo est�
	dispon�vel em:
	https://drive.google.com/file/d/1LCofjYj-pV1asBLrxtgPDsbqMFRefHW5/view
	Para utiliz�-la, deve-se descarregar o arquivo e restaurar a base de dados
	no SSMS.
	Desenvolvido por: Ricardo Morello Santos
	Fonte: Curso SQL Completo 2019 [Iniciantes] + Desafios + Muita Pr�tica
	Dispon�vel em: https://www.youtube.com/watch?v=rX2I7OjLqWE
*/

/* SELECT 
 
 Sele��o de uma ou mais colunas da tabela. 
 SELECT coluna1, coluna2
 FROM tabela

 Sele��o de todas as colunas do banco de dados.
 SELECT * FROM tabela

*/

--Sele��o de colunas da tabela PERSON

--Seleciona a base de dados AdventureWorks2017
use AdventureWorks2017
/*
	Colunas: vari�veis
	Linhas: observa��es
*/
SELECT * from person.PERSON;

--Filtro de uma coluna no comando SELECT
SELECT Title FROM person.person;

--Sele��o de outra tabela 
SELECT * FROM person.EmailAddress;

/*Exerc�cio
	A equipe de marketing precisa fazer uma pesquisa sobre nomes mais comuns de seus clientes
	e precisa do nome e sobrenome de todos os clientes que est�o cadastrados no sistema.
*/

SELECT FirstName, LastName from person.PERSON;

/*
Select DISTINCT: Omitir dados duplicados de uma tabela. Retorna apenas dados �nicos.
	SELECT DISTINCT 
	coluna1, coluna2 
	FROM tabela
*/
SELECT DISTINCT FirstName FROM person.PERSON;

/*
	Exerc�cio: Quantos sobrenomes �nicos existem na tabela person.PERSON?
*/
SELECT DISTINCT LastName FROM person.PERSON;

/*
	Cl�sula WHERE: Filtrar dados da sele��o
	SELECT coluna1, coluna2, coluna_n
	FROM tabela
	WHERE condicao

	OPERADOR		DESCRI��O
		=			  IGUAL
		>			  MAIOR
		<			  MENOR
		>=			  MAIOR QUE
		<=			  MENOR QUE
		<>            DIFERENTE DE
		AND           Operador l�gico E
		OR			  Operador l�gico OU
*/


--Pessoas com sobrenome 'Miller'
SELECT * 
FROM person.PERSON
WHERE LastName = 'miller';

--Pessoas com nome Anna e sobrenome Miller
SELECT * 
FROM person.PERSON
where LastName = 'miller' AND FirstName = 'anna';

--Produtos de cores azul ou vermelha
SELECT * 
FROM production.PRODUCT
WHERE Color = 'red' or Color = 'blue';

--Produtos com pre�o no intervalo ]1500,5000[
SELECT * 
FROM production.PRODUCT
WHERE ListPrice > 1500 and ListPrice < 5000;

--Produtos que n�o sejam de cor vermelha
SELECT * 
FROM production.PRODUCT
WHERE Color <> 'red';

/*Exerc�cio: 
	A equipe de produ��o precisa do nome de todas as pe�as que pesam mais de 500 kg, mas n�o mais que 700 kg, para inspe��o.
*/

SELECT Name
FROM production.PRODUCT
WHERE Weight >= 500 and Weight <= 700;


/*
	Foi pedido pelo marketing uma rela��o de todos os empregados que s�o casados e asalariados
*/
SELECT * 
FROM HumanResources.Employee
WHERE MaritalStatus = 'M' and SalariedFlag = 1

/*
	Um usu�rio chamado Peter Krebs est� devendo um pagamento, consiga o email dele para que 
	possamos enviar uma cobran�a.
*/

SELECT EmailAddress
FROM person.EmailAddress
WHERE BusinessEntityID = (SELECT BusinessEntityID 
							FROM person.Person
							WHERE FirstName = 'Peter' and LastName = 'Krebs');


/*
	Comando COUNT: Retorna o n�mero de linhas que est�o de acordo com a defini��o do filtro

	SELECT COUNT(*)
	FROM tabela

	Contagem espec�fica de um campo:
	SELECT COUNT(coluna)
	FROM tabela

	Contagem distinta e espec�fica de um campo:
	SELECT COUNT(DISTINCT coluna)
	FROM tabela
*/

--Contagem dos registros da tabela Person:
SELECT COUNT(*) FROM person.PERSON

--Contagem de t�tulos
SELECT COUNT(DISTINCT title) FROM person.PERSON

/*Exerc�cio: 
	Quantos produtos est�o cadastrados na tabela produtos?
*/
SELECT COUNT(*) as qtd_produtos
FROM Production.Product;

/*Exerc�cio: 
	Quantos tamanhos �nicos de produtos est�o cadastrados na tabela?
*/
SELECT COUNT(Size)
From Production.Product;

/*Exerc�cio:
	Quantos tamanhos diferentes de produtos est�o cadastrados na tabela?
*/

SELECT COUNT(DISTINCT Size)
From Production.Product;

/*
	Comando TOP: Limita a quantidade de dados retornada de uma sele��o
	
	SELECT TOP 10 *
	FROM tabela 
*/

--Retorna os primeiros 10 produtos da tabela Products
SELECT TOP 10 *
FROM Production.Product;

/*	ORDER BY: Ordena os resultados da sele��o por alguma coluna em ordem
	crescente ou decrescente

	SELECT coluna1, coluna2
	FROM tabela
	ORDER BY coluna1 asc/desc

	Padr�o: asc

*/

--Selecionando todas as pessoas em ordem alfab�tica

SELECT * 
FROM person.PERSON
ORDER BY FirstName asc

--Selecionando todas as pessoas, ordenando em ordem crescente pelo nome 
--e decrescente pelo sobrenome
SELECT * 
FROM person.PERSON
ORDER BY FirstName asc, LastName desc

--� poss�vel ordenar por colunas que n�o foram selecionadas
--Neste caso, ordena-se de acordo com a parte nome que n�o foi selecionada
SELECT FirstName, LastName
FROM person.Person
ORDER BY MiddleName asc

/*Exerc�cio: 
	Obtenha o ProductID dos 10 produtos mais caros do sistema, do mais caro para
	o mais barato
*/

SELECT TOP 10 ProductID
FROM Production.Product
ORDER BY ListPrice desc


/*Exerc�cio:
	Obtenha o nome e n�mero dos produtos que t�m ProductID entre 1~4
*/

SELECT TOP 4 Name, ProductNumber
FROM Production.Product
ORDER BY ProductID asc

/*
	Comando BETWEEN: Encontra registros cujo determinado campo est�
	entre um valor m�nimo e m�ximo estabelecidos

	SELECT * 
	FROM tabela
	WHERE campo1 BETWEEN minimo AND maximo

	Intervalos fechados, equivalente a 

	minimo <= campo1 <= maximo
*/


--Seleciona produtos cujo valor est� entre 1000 e 1500 d�lares

SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 1500;

--Operador l�gico NOT: Pode ser utilizado para selecionar o complemento do intervalo 
--do between

SELECT * 
FROM Production.Product
WHERE ListPrice NOT BETWEEN 1000 AND 1500;

--� poss�vel manipular datas com o BETWEEN:
--Nota: formato padr�o SQL: AAAA/MM/DD

SELECT * 
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2009/01/01' AND '2010/12/31';


/*
	Comando IN: Verifica se o valor do campo corresponde com qualquer valor 
	passado na lista de valores;

	SELECT *
	FROM tabela
	WHERE campo IN (valor1, <valor2, ...>);
*/

--Seleciona todas as pessoas cujos IDs correspondem a 2, 7 ou 13
SELECT * 
FROM person.Person
WHERE BusinessEntityID IN (2,7,13)

--Nota: � poss�vel utilizar o NOT tamb�m para negar o intervalo do IN
SELECT *
FROM person.Person
WHERE BusinessEntityID NOT IN (2,7,13)

/*
	Comando LIKE: Busca padr�es espec�ficos em uma coluna
	Nota: Padr�es n�o s�o sens�veis a caps lock

	SELECT *
	FROM tabela
	WHERE campo LIKE padrao

	%: qualquer n�mero de caracteres no padr�o
	_: um caractere
*/

--Busca todas as pessoas cujo nome inicia em 'ovi'

SELECT * 
FROM person.Person
Where FirstName LIKE 'ovi%'

--Busca todas as pessoas cujo nome finaliza em 'to':

SELECT *
FROM person.Person
WHERE FirstName LIKE '%to'

--Busca todas as pessoas cujo nome cont�m 'essa':

SELECT * 
FROM person.Person
WHERE FirstName LIKE '%essa%'

--Busca pessoas que possuem apenas um caractere depois de 'ro', mas qualquer n�mero
--de caracteres antes

SELECT *
FROM person.Person
WHERE FirstName LIKE '%ro_'

/* S�rie de exerc�cios - Fundamentos SQL */

--Quantos produtos que custam mais de 1500 d�lares est�o cadastrados no sistema?
SELECT COUNT(*)
FROM Production.Product
WHERE Production.Product.ListPrice > 1500

--Quantas pessoas t�m o sobrenome que inicia com a letra P?
SELECT COUNT(LastName)
FROM Person.Person
WHERE PERSON.LastName LIKE 'P%'

--Em quantas cidades �nicas est�o cadastrados nossos clientes?

SELECT COUNT(DISTINCT City)
FROM Person.Address

--Quais s�o as cidades �nicas que temos cadastradas em nosso sistema?
SELECT DISTINCT City
FROM Person.Address

--Quantos produtos vermelhos t�m pre�o entre 500 e 1000 d�lares?

SELECT COUNT(ListPrice)
FROM Production.Product
WHERE Color = 'Red' AND ListPrice BETWEEN 500 AND 1000 

--Quantos produtos cadastrados t�m a palavra 'road' no nome deles?
SELECT COUNT(*) FROM Production.Product
WHERE Product.Name LIKE '%road%';


/*
	Fun��es de agrega��o: SUM, MIN, MAX, AVG
	
	Agregam ou combinam dados de uma tabela em um �nico resultado.
*/

--Soma dos 10 primeiros valores do campo de total de vendas
SELECT TOP 10 sum(linetotal) as Soma
FROM SALES.SalesOrderDetail

--Valor m�nimo dos 10 primeiros valores do campo de vendas
SELECT TOP 10 min(linetotal) as Minimo
FROM SALES.SalesOrderDetail

--Valor m�ximo dos 10 primeiros valores do campo de vendas
SELECT TOP 10 MAX(linetotal) as Maximo
FROM Sales.SalesOrderDetail

--M�dia dos 10 primeiros valores do campo de vendas
SELECT TOP 10 AVG(linetotal) as ValorMedio
FROM Sales.SalesOrderDetail

/*
	Comando GROUP BY: Divide o resultado da pesquisa em grupos
	Para cada grupo, pode-se calcular a soma de um item ou contar
	o n�mero de itens por grupo
	
	SELECT coluna1, <<funcaoAgregacao>coluna2,...>
	FROM tabela
	GROUP BY coluna1

*/

--Encontra os registros com ID de ofertas similares e soma seus respectivos
--valores, agrupando-os por ID

SELECT SpecialOfferID, SUM(UnitPrice) as SOMA
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID

--Encontra a quantidade de cada produto que foi vendida at� hoje

SELECT ProductID, SUM(OrderQTY)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID asc

--Encontra quantos nomes similares existem registrados 

SELECT FirstName, COUNT(FirstName) as Quantidade
FROM Person.Person
GROUP BY FirstName

--Encontrar a m�dia de pre�o para os produtos que s�o silver

SELECT AVG(ListPrice) as MediaPrecoSilver
FROM Production.Product
WHERE Color = 'Silver'

/*Exerc�cio: 
	Quantas pessoas t�m o mesmo MiddleName, agrupadas tamb�m por MiddleName?
*/

SELECT MiddleName, COUNT(MiddleName)
FROM Person.Person
GROUP BY MiddleName

/*Exerc�cio:
	Qual a m�dia de vendas por produto?
*/

SELECT ProductID, AVG(OrderQty)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID


/*Exerc�cio:
	Quais foram as 10 vendas que tiveram os maiores valores de venda 
	por produto, em ordem decrescente?
*/
SELECT TOP 10 ProductID, SUM(LineTotal) Total
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY Total desc

/*Exerc�cio:
	Quantos produtos e qual a quantidade media de produtos cadastrados
	nas ordens de servi�o, agrupados por ProductID?
*/
SELECT * from Production.WorkOrder
SELECT ProductID, COUNT(ProductID), AVG(OrderQty) Armazenado
FROM Production.WorkOrder
GROUP BY ProductID

/* Comando HAVING: Usado junto com o GROUP BY para filtrar resultados
   de um agrupamento
   
   SELECT coluna1, funcaoAgregacao(coluna2)
   FROM nomeTabela
   GROUP BY coluna1
   HAVING condicao;

   O HAVING � aplicado ap�s o agrupamento dos dados, enquanto o WHERE
   � aplicado antes do agrupamento.

 */

 --Quais nomes cadastrados t�m ocorr�ncia maior que 10?
 SELECT FirstName, COUNT(FirstName) Quantidade
 FROM Person.person
 GROUP BY FirstName
 HAVING COUNT(FirstName) > 10
 ORDER BY COUNT(FirstName)
 
 --Quais produtos que no total de vendas est�o entre 162 a 500 mil
 SELECT ProductID, SUM(LineTotal) SomaTotal
 FROM Sales.SalesOrderDetail
 GROUP BY ProductID
 HAVING SUM(LineTotal) BETWEEN 162000 AND 500000


 --Quais nomes do sistema ocorrem mais de 10 vezes, por�m somente
 --aqueles cujo t�tulo � Mr
 SELECT Title, FirstName, COUNT(FirstName)
 FROM Person.person
 WHERE Title LIKE 'Mr.'
 GROUP BY Title, FirstName
 HAVING COUNT(FirstName) > 10

 /*Exerc�cio: 
	Identificar as prov�ncias com maior n�mero de cadastros no sistema, aquelas
	com mais de 1000 registros.
*/
SELECT StateProvinceID, COUNT(StateProvinceID)
FROM Person.Address
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) > 1000

/*Exerc�cio:
	Sendo que trata-se de uma multinacional e os gerentes querem saber quais
	produtos n�o est�o trazendo em m�dia no m�nimo 1 milh�o no total de vendas
*/

SELECT ProductID, AVG(LineTotal)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LineTotal) < 1000000

/*
	Comando AS: Renomear ou dar apelidos para colunas ou agrega��es 
*/
--Selecionando os 100 primeiros pre�os de produtos com o apelido de 
--Preco
SELECT TOP 100 ListPrice AS Preco
FROM Production.Product 
ORDER BY ListPrice DESC

SELECT TOP 10 AVG(ListPrice) as 'Preco medio'
FROM Production.Product

/*Exerc�cio:
	Encontrar nome e sobrenome da tabela Person em portugues	
*/

SELECT FirstName as Nome, LastName as Sobrenome 
FROM Person.Person


/*Exerc�cio:
	Encontrar n�mero de produtos da tabela produto em portugues
*/
SELECT ProductNumber as 'Numero de produtos'
FROM Production.Product


/*
	Comando Inner JOIN: Jun��o horizontal de tabelas
	SELECT C.ClienteID, C.Nome, E.Rua, E.Cidade
	FROM Cliente C
	INNER JOIN Endereco E ON E.EnderecoID = C.EnderecoID
*/

--BusinessEntityID, FirstName, LastName, EmailAddress
SELECT TOP 10 * 
FROM Person.Person

SELECT TOP 10 *
FROM Person.EmailAddress

--Selecionar nome, sobrenome e e-mail das pessoas que possuem BusinessEntityID
--em ambas as tabelas
SELECT P.FirstName, P.LastName, E.EmailAddress
FROM Person.Person P
INNER JOIN Person.EmailAddress E ON E.BusinessEntityID = P.BusinessEntityID

--Selecionar apenas os nomes dos produtos e a informa��o de suas subcategorias

SELECT P.ListPrice, P.Name, S.Name
FROM Production.Product P
INNER JOIN Production.ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID

/*Exerc�cio:
	Criar um INNER Join sobre as colunas BusinessEntityID, PhoneNumberTypeID,
	PhoneNumber
*/

SELECT Pe.BusinessEntityID, Ph.PhoneNumberTypeID, Pe.PhoneNumber
FROM Person.PersonPhone Pe
INNER JOIN Person.PhoneNumberType Ph ON Pe.PhoneNumberTypeID = Ph.PhoneNumberTypeID

/*Exerc�cio:
	Criar um INNER Join sobre as colunas AddressID, City, StateProvinceID, Nome
	do estado
*/
SELECT PA.AddressID, PA.City, PS.StateProvinceID, PS.Name
FROM Person.Address Pa
INNER JOIN Person.StateProvince Ps ON Pa.StateProvinceID = Ps.StateProvinceID


/*	Comando FULL Join: Retorna um conjunto de todos os registros correspondentes
	da tabela A e tabela B quando s�o iguais. Al�m disso, se n�o houverem valores
	correspondentes da tabela A com a tabela B, ent�o os campos ser�o preenchidos
	com null. O mesmo vale para o caso das correspond�ncias da tabela B.

	SELECT * 
	FROM Tabela A
	FULL OUTER JOIN Tabela B
	ON TabelaA.nome = TabelaB.nome

	 TABELAA		TABELAB					FULL	Join
	-----------    -----------	   ---------------------------------
	id    nome	   id     nome	   id	   nome		id	   nome 
	1	  Robo	   1     Espada    1       Robo		2      Robo
	2	 Macaco    2     Robo      2       Macaco   null   null
	3    Samurai   3     Mario     3       Samurai  4      Samurai
	4	 Monitor   4     Samurai   4       Monitor  null   null
								   null    null     1      Espada
								   null    null     3      Mario
*/

/*	Comando LEFT Join: Retorna o conjunto da tabela principal sem os registros
	que est�o exclusivamente na tabela secund�ria, sem intersec��o com a 
	principal.
	Semelhante ao FULL Join, com a exce��o de que preenche com nulos apenas
	os registros da tabela principal que n�o est�o contidos na tabela secund�ria,
	desconsiderando aqueles que existem apenas na tabela secund�ria.

	 TABELAA		TABELAB					LEFT	Join
	-----------    -----------	   ---------------------------------
	id    nome	   id     nome	   id	   nome		id	   nome 
	1	  Robo	   1     Espada    1       Robo		2      Robo
	2	 Macaco    2     Robo      2       Macaco   null   null
	3    Samurai   3     Mario     3       Samurai  4      Samurai
	4	 Monitor   4     Samurai   4       Monitor  null   null
*/


--Encontrar quais pessoas t�m um cart�o de cr�dito registrado

SELECT * FROM
Person.Person
INNER JOIN Sales.PersonCreditCard
ON Sales.PersonCreditCard.BusinessEntityID = Person.BusinessEntityID

--Encontrar quais pessoas n�o t�m um cart�o de cr�dito registrado

SELECT * FROM
Person.Person
LEFT JOIN Sales.PersonCreditCard
ON Sales.PersonCreditCard.BusinessEntityID = Person.BusinessEntityID
WHERE Sales.PersonCreditCard.BusinessEntityID IS NULL

/* Comando UNION: Combina dois ou mais resultados de um select em um resultado

	SELECT coluna1, coluna2
	FROM tabela1
	UNION
	SELECT coluna1, coluna2
	FROM tabela2
	
	Nota: O comando UNION possui distinct associado.
	Para trazer dados com duplicatas, utiliza-se UNION ALL.
*/

--Encontrar as pessoas que possuem Mr. no t�tulo ou A como sobrenome
SELECT FirstName, Title
FROM Person.Person
WHERE Title = 'Mr.'
UNION ALL
SELECT FirstName, Title
FROM Person.Person
WHERE MiddleName = 'A'

/* Comando DATEPART: Permite retornar partes das datas em um registro.
   Sintaxe: DATEPART(datepart, date)
*/

--Encontrar o dia das vendas
SELECT SalesOrderID, DATEPART(month, OrderDate) Mes
FROM SALES.SalesOrderHeader

--Encontrar a m�dia de valores vendidos por m�s
SELECT AVG(TotalDue), DATEPART(month, OrderDate) Mes
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(month, OrderDate)

/* Exerc�cio:
   Encontrar o dia em que o funcion�rio foi contratado
*/

SELECT DATEPART(day, HireDate) 'Dia da contratacao'
FROM HumanResources.Employee

/* Comandos para opera��es em STRING */

/* CONCAT: Concatenar informa��es */

--Concatenar todos os nomes das pessoas cadastradas
SELECT CONCAT(FirstName,' ', LastName)
FROM PERSON.Person

/* UPPER: Converter o resultado para mai�sculas */

--Tornar o nome completo das pessoas mai�sculo
SELECT UPPER(CONCAT(FirstName, ' ', LastName))
FROM Person.Person

/* LOWER: Converter o resultado para min�sculas*/

--Tornar o nome completo das pessoas min�sculo
SELECT LOWER(CONCAT(FirstName, ' ', LastName))
FROM Person.Person

/*LEN: Contar n�mero de caracteres*/

--Contar o n�mero de caracteres no primeiro nome de cada pessoa
SELECT LEN(FirstName)
FROM Person.Person

/* SUBSTRING: Retorna uma por��o da String 
   SUBSTRING(str, x, n)
   Nota: Substring � indexado em 1 (x >= 1), e retorna at� o caractere
   de �ndice n-1 subsequente ao �ndice x.
   SUBSTRING('CursoSQL', 2, 3) = URS 
*/

--Retornando uma por��o do nome de cada pessoa
SELECT SUBSTRING(FirstName, 1, 3)
FROM Person.Person

/* REPLACE: Substitui determinado caractere em uma string */

--Substituindo o '-' no n�mero do produto por '#'
SELECT REPLACE(ProductNumber, '-', '#')
FROM Production.Product

/* Fun��es matem�ticas b�sicas
	Fun��es b�sicas: soma (+), divis�o (/), subtra��o (-) e 
	multiplica��o (*)
*/
--Aplica��o das opera��es b�sicas sobre UnitPrice

--Divis�o
SELECT UnitPrice / LineTotal
FROM SALES.SalesOrderDetail

--Subtra��o 
SELECT UnitPrice - LineTotal
FROM SALES.SalesOrderDetail

--Multiplica��o
SELECT UnitPrice * LineTotal
FROM SALES.SalesOrderDetail

--Soma
SELECT UnitPrice + LineTotal
FROM SALES.SalesOrderDetail

/*	Demais fun��es matem�ticas:

	AVG:	m�dia
	MAX:	valor m�ximo das observa��es
	ROUND:  arredondamento
	SQRT:   raiz quadrada
*/

--Arredondamento para duas casas decimais de LineTotal
SELECT ROUND(Linetotal, 2) 
FROM Sales.SalesOrderDetail


/* SUBQUERIES */

--Identificar o relat�rio de todos os produtos cadastrados que possuem
--pre�o de venda acima da m�dia

SELECT * FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice)
				   FROM Production.Product)

--Encontrar o nome dos funcion�rios que possuem o cargo de Design Engineer

SELECT FirstName 
FROM Person.Person
WHERE BusinessEntityID IN (SELECT BusinessEntityID
							FROM HumanResources.Employee
							WHERE JobTitle = 'Design Engineer')

--Reproduzir o mesmo select acima com um JOIN

SELECT FirstName
FROM Person.Person
INNER JOIN HumanResources.Employee 
ON HumanResources.Employee.BusinessEntityID = Person.BusinessEntityID
AND JobTitle = 'Design Engineer'

/*Exerc�cio:
  Encontrar todos os endere�os que est�o no estado de Alberta
*/

SELECT * FROM Person.Address
WHERE StateProvinceID = (SELECT StateProvinceID
						 FROM Person.StateProvince
						 WHERE Name = 'Alberta')
--Consulta com um INNER Join:
SELECT * FROM Person.Address
INNER JOIN Person.StateProvince
ON Person.Address.StateProvinceID = Person.StateProvince.StateProvinceID
AND Name = 'Alberta'



