/*
	Curso SQL Completo 2019
	Este script utiliza da base de dados AdventureWorks2017. O arquivo está
	disponível em:
	https://drive.google.com/file/d/1LCofjYj-pV1asBLrxtgPDsbqMFRefHW5/view
	Para utilizá-la, deve-se descarregar o arquivo e restaurar a base de dados
	no SSMS.
	Desenvolvido por: Ricardo Morello Santos
	Fonte: Curso SQL Completo 2019 [Iniciantes] + Desafios + Muita Prática
	Disponível em: https://www.youtube.com/watch?v=rX2I7OjLqWE
*/

/* SELECT 
 
 Seleção de uma ou mais colunas da tabela. 
 SELECT coluna1, coluna2
 FROM tabela

 Seleção de todas as colunas do banco de dados.
 SELECT * FROM tabela

*/

--Seleção de colunas da tabela PERSON

--Seleciona a base de dados AdventureWorks2017
use AdventureWorks2017
/*
	Colunas: variáveis
	Linhas: observações
*/
SELECT * from person.PERSON;

--Filtro de uma coluna no comando SELECT
SELECT Title FROM person.person;

--Seleção de outra tabela 
SELECT * FROM person.EmailAddress;

/*Exercício
	A equipe de marketing precisa fazer uma pesquisa sobre nomes mais comuns de seus clientes
	e precisa do nome e sobrenome de todos os clientes que estão cadastrados no sistema.
*/

SELECT FirstName, LastName from person.PERSON;

/*
Select DISTINCT: Omitir dados duplicados de uma tabela. Retorna apenas dados únicos.
	SELECT DISTINCT 
	coluna1, coluna2 
	FROM tabela
*/
SELECT DISTINCT FirstName FROM person.PERSON;

/*
	Exercício: Quantos sobrenomes únicos existem na tabela person.PERSON?
*/
SELECT DISTINCT LastName FROM person.PERSON;

/*
	Clásula WHERE: Filtrar dados da seleção
	SELECT coluna1, coluna2, coluna_n
	FROM tabela
	WHERE condicao

	OPERADOR		DESCRIÇÃO
		=			  IGUAL
		>			  MAIOR
		<			  MENOR
		>=			  MAIOR QUE
		<=			  MENOR QUE
		<>            DIFERENTE DE
		AND           Operador lógico E
		OR			  Operador lógico OU
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

--Produtos com preço no intervalo ]1500,5000[
SELECT * 
FROM production.PRODUCT
WHERE ListPrice > 1500 and ListPrice < 5000;

--Produtos que não sejam de cor vermelha
SELECT * 
FROM production.PRODUCT
WHERE Color <> 'red';

/*Exercício: 
	A equipe de produção precisa do nome de todas as peças que pesam mais de 500 kg, mas não mais que 700 kg, para inspeção.
*/

SELECT Name
FROM production.PRODUCT
WHERE Weight >= 500 and Weight <= 700;


/*
	Foi pedido pelo marketing uma relação de todos os empregados que são casados e asalariados
*/
SELECT * 
FROM HumanResources.Employee
WHERE MaritalStatus = 'M' and SalariedFlag = 1

/*
	Um usuário chamado Peter Krebs está devendo um pagamento, consiga o email dele para que 
	possamos enviar uma cobrança.
*/

SELECT EmailAddress
FROM person.EmailAddress
WHERE BusinessEntityID = (SELECT BusinessEntityID 
							FROM person.Person
							WHERE FirstName = 'Peter' and LastName = 'Krebs');


/*
	Comando COUNT: Retorna o número de linhas que estão de acordo com a definição do filtro

	SELECT COUNT(*)
	FROM tabela

	Contagem específica de um campo:
	SELECT COUNT(coluna)
	FROM tabela

	Contagem distinta e específica de um campo:
	SELECT COUNT(DISTINCT coluna)
	FROM tabela
*/

--Contagem dos registros da tabela Person:
SELECT COUNT(*) FROM person.PERSON

--Contagem de títulos
SELECT COUNT(DISTINCT title) FROM person.PERSON

/*Exercício: 
	Quantos produtos estão cadastrados na tabela produtos?
*/
SELECT COUNT(*) as qtd_produtos
FROM Production.Product;

/*Exercício: 
	Quantos tamanhos únicos de produtos estão cadastrados na tabela?
*/
SELECT COUNT(Size)
From Production.Product;

/*Exercício:
	Quantos tamanhos diferentes de produtos estão cadastrados na tabela?
*/

SELECT COUNT(DISTINCT Size)
From Production.Product;

/*
	Comando TOP: Limita a quantidade de dados retornada de uma seleção
	
	SELECT TOP 10 *
	FROM tabela 
*/

--Retorna os primeiros 10 produtos da tabela Products
SELECT TOP 10 *
FROM Production.Product;

/*	ORDER BY: Ordena os resultados da seleção por alguma coluna em ordem
	crescente ou decrescente

	SELECT coluna1, coluna2
	FROM tabela
	ORDER BY coluna1 asc/desc

	Padrão: asc

*/

--Selecionando todas as pessoas em ordem alfabética

SELECT * 
FROM person.PERSON
ORDER BY FirstName asc

--Selecionando todas as pessoas, ordenando em ordem crescente pelo nome 
--e decrescente pelo sobrenome
SELECT * 
FROM person.PERSON
ORDER BY FirstName asc, LastName desc

--É possível ordenar por colunas que não foram selecionadas
--Neste caso, ordena-se de acordo com a parte nome que não foi selecionada
SELECT FirstName, LastName
FROM person.Person
ORDER BY MiddleName asc

/*Exercício: 
	Obtenha o ProductID dos 10 produtos mais caros do sistema, do mais caro para
	o mais barato
*/

SELECT TOP 10 ProductID
FROM Production.Product
ORDER BY ListPrice desc


/*Exercício:
	Obtenha o nome e número dos produtos que têm ProductID entre 1~4
*/

SELECT TOP 4 Name, ProductNumber
FROM Production.Product
ORDER BY ProductID asc

/*
	Comando BETWEEN: Encontra registros cujo determinado campo está
	entre um valor mínimo e máximo estabelecidos

	SELECT * 
	FROM tabela
	WHERE campo1 BETWEEN minimo AND maximo

	Intervalos fechados, equivalente a 

	minimo <= campo1 <= maximo
*/


--Seleciona produtos cujo valor está entre 1000 e 1500 dólares

SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 1500;

--Operador lógico NOT: Pode ser utilizado para selecionar o complemento do intervalo 
--do between

SELECT * 
FROM Production.Product
WHERE ListPrice NOT BETWEEN 1000 AND 1500;

--É possível manipular datas com o BETWEEN:
--Nota: formato padrão SQL: AAAA/MM/DD

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

--Nota: é possível utilizar o NOT também para negar o intervalo do IN
SELECT *
FROM person.Person
WHERE BusinessEntityID NOT IN (2,7,13)

/*
	Comando LIKE: Busca padrões específicos em uma coluna
	Nota: Padrões não são sensíveis a caps lock

	SELECT *
	FROM tabela
	WHERE campo LIKE padrao

	%: qualquer número de caracteres no padrão
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

--Busca todas as pessoas cujo nome contém 'essa':

SELECT * 
FROM person.Person
WHERE FirstName LIKE '%essa%'

--Busca pessoas que possuem apenas um caractere depois de 'ro', mas qualquer número
--de caracteres antes

SELECT *
FROM person.Person
WHERE FirstName LIKE '%ro_'

/* Série de exercícios - Fundamentos SQL */

--Quantos produtos que custam mais de 1500 dólares estão cadastrados no sistema?
SELECT COUNT(*)
FROM Production.Product
WHERE Production.Product.ListPrice > 1500

--Quantas pessoas têm o sobrenome que inicia com a letra P?
SELECT COUNT(LastName)
FROM Person.Person
WHERE PERSON.LastName LIKE 'P%'

--Em quantas cidades únicas estão cadastrados nossos clientes?

SELECT COUNT(DISTINCT City)
FROM Person.Address

--Quais são as cidades únicas que temos cadastradas em nosso sistema?
SELECT DISTINCT City
FROM Person.Address

--Quantos produtos vermelhos têm preço entre 500 e 1000 dólares?

SELECT COUNT(ListPrice)
FROM Production.Product
WHERE Color = 'Red' AND ListPrice BETWEEN 500 AND 1000 

--Quantos produtos cadastrados têm a palavra 'road' no nome deles?
SELECT COUNT(*) FROM Production.Product
WHERE Product.Name LIKE '%road%';


/*
	Funções de agregação: SUM, MIN, MAX, AVG
	
	Agregam ou combinam dados de uma tabela em um único resultado.
*/

--Soma dos 10 primeiros valores do campo de total de vendas
SELECT TOP 10 sum(linetotal) as Soma
FROM SALES.SalesOrderDetail

--Valor mínimo dos 10 primeiros valores do campo de vendas
SELECT TOP 10 min(linetotal) as Minimo
FROM SALES.SalesOrderDetail

--Valor máximo dos 10 primeiros valores do campo de vendas
SELECT TOP 10 MAX(linetotal) as Maximo
FROM Sales.SalesOrderDetail

--Média dos 10 primeiros valores do campo de vendas
SELECT TOP 10 AVG(linetotal) as ValorMedio
FROM Sales.SalesOrderDetail

/*
	Comando GROUP BY: Divide o resultado da pesquisa em grupos
	Para cada grupo, pode-se calcular a soma de um item ou contar
	o número de itens por grupo
	
	SELECT coluna1, <<funcaoAgregacao>coluna2,...>
	FROM tabela
	GROUP BY coluna1

*/

--Encontra os registros com ID de ofertas similares e soma seus respectivos
--valores, agrupando-os por ID

SELECT SpecialOfferID, SUM(UnitPrice) as SOMA
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID

--Encontra a quantidade de cada produto que foi vendida até hoje

SELECT ProductID, SUM(OrderQTY)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID asc

--Encontra quantos nomes similares existem registrados 

SELECT FirstName, COUNT(FirstName) as Quantidade
FROM Person.Person
GROUP BY FirstName

--Encontrar a média de preço para os produtos que são silver

SELECT AVG(ListPrice) as MediaPrecoSilver
FROM Production.Product
WHERE Color = 'Silver'

/*Exercício: 
	Quantas pessoas têm o mesmo MiddleName, agrupadas também por MiddleName?
*/

SELECT MiddleName, COUNT(MiddleName)
FROM Person.Person
GROUP BY MiddleName

/*Exercício:
	Qual a média de vendas por produto?
*/

SELECT ProductID, AVG(OrderQty)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID


/*Exercício:
	Quais foram as 10 vendas que tiveram os maiores valores de venda 
	por produto, em ordem decrescente?
*/
SELECT TOP 10 ProductID, SUM(LineTotal) Total
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY Total desc

/*Exercício:
	Quantos produtos e qual a quantidade media de produtos cadastrados
	nas ordens de serviço, agrupados por ProductID?
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

   O HAVING é aplicado após o agrupamento dos dados, enquanto o WHERE
   é aplicado antes do agrupamento.

 */

 --Quais nomes cadastrados têm ocorrência maior que 10?
 SELECT FirstName, COUNT(FirstName) Quantidade
 FROM Person.person
 GROUP BY FirstName
 HAVING COUNT(FirstName) > 10
 ORDER BY COUNT(FirstName)
 
 --Quais produtos que no total de vendas estão entre 162 a 500 mil
 SELECT ProductID, SUM(LineTotal) SomaTotal
 FROM Sales.SalesOrderDetail
 GROUP BY ProductID
 HAVING SUM(LineTotal) BETWEEN 162000 AND 500000


 --Quais nomes do sistema ocorrem mais de 10 vezes, porém somente
 --aqueles cujo título é Mr
 SELECT Title, FirstName, COUNT(FirstName)
 FROM Person.person
 WHERE Title LIKE 'Mr.'
 GROUP BY Title, FirstName
 HAVING COUNT(FirstName) > 10

 /*Exercício: 
	Identificar as províncias com maior número de cadastros no sistema, aquelas
	com mais de 1000 registros.
*/
SELECT StateProvinceID, COUNT(StateProvinceID)
FROM Person.Address
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) > 1000

/*Exercício:
	Sendo que trata-se de uma multinacional e os gerentes querem saber quais
	produtos não estão trazendo em média no mínimo 1 milhão no total de vendas
*/

SELECT ProductID, AVG(LineTotal)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LineTotal) < 1000000

/*
	Comando AS: Renomear ou dar apelidos para colunas ou agregações 
*/
--Selecionando os 100 primeiros preços de produtos com o apelido de 
--Preco
SELECT TOP 100 ListPrice AS Preco
FROM Production.Product 
ORDER BY ListPrice DESC

SELECT TOP 10 AVG(ListPrice) as 'Preco medio'
FROM Production.Product

/*Exercício:
	Encontrar nome e sobrenome da tabela Person em portugues	
*/

SELECT FirstName as Nome, LastName as Sobrenome 
FROM Person.Person


/*Exercício:
	Encontrar número de produtos da tabela produto em portugues
*/
SELECT ProductNumber as 'Numero de produtos'
FROM Production.Product


/*
	Comando Inner JOIN: Junção horizontal de tabelas
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

--Selecionar apenas os nomes dos produtos e a informação de suas subcategorias

SELECT P.ListPrice, P.Name, S.Name
FROM Production.Product P
INNER JOIN Production.ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID

/*Exercício:
	Criar um INNER Join sobre as colunas BusinessEntityID, PhoneNumberTypeID,
	PhoneNumber
*/

SELECT Pe.BusinessEntityID, Ph.PhoneNumberTypeID, Pe.PhoneNumber
FROM Person.PersonPhone Pe
INNER JOIN Person.PhoneNumberType Ph ON Pe.PhoneNumberTypeID = Ph.PhoneNumberTypeID

/*Exercício:
	Criar um INNER Join sobre as colunas AddressID, City, StateProvinceID, Nome
	do estado
*/
SELECT PA.AddressID, PA.City, PS.StateProvinceID, PS.Name
FROM Person.Address Pa
INNER JOIN Person.StateProvince Ps ON Pa.StateProvinceID = Ps.StateProvinceID


/*	Comando FULL Join: Retorna um conjunto de todos os registros correspondentes
	da tabela A e tabela B quando são iguais. Além disso, se não houverem valores
	correspondentes da tabela A com a tabela B, então os campos serão preenchidos
	com null. O mesmo vale para o caso das correspondências da tabela B.

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
	que estão exclusivamente na tabela secundária, sem intersecção com a 
	principal.
	Semelhante ao FULL Join, com a exceção de que preenche com nulos apenas
	os registros da tabela principal que não estão contidos na tabela secundária,
	desconsiderando aqueles que existem apenas na tabela secundária.

	 TABELAA		TABELAB					LEFT	Join
	-----------    -----------	   ---------------------------------
	id    nome	   id     nome	   id	   nome		id	   nome 
	1	  Robo	   1     Espada    1       Robo		2      Robo
	2	 Macaco    2     Robo      2       Macaco   null   null
	3    Samurai   3     Mario     3       Samurai  4      Samurai
	4	 Monitor   4     Samurai   4       Monitor  null   null
*/


--Encontrar quais pessoas têm um cartão de crédito registrado

SELECT * FROM
Person.Person
INNER JOIN Sales.PersonCreditCard
ON Sales.PersonCreditCard.BusinessEntityID = Person.BusinessEntityID

--Encontrar quais pessoas não têm um cartão de crédito registrado

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

--Encontrar as pessoas que possuem Mr. no título ou A como sobrenome
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

--Encontrar a média de valores vendidos por mês
SELECT AVG(TotalDue), DATEPART(month, OrderDate) Mes
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(month, OrderDate)

/* Exercício:
   Encontrar o dia em que o funcionário foi contratado
*/

SELECT DATEPART(day, HireDate) 'Dia da contratacao'
FROM HumanResources.Employee

/* Comandos para operações em STRING */

/* CONCAT: Concatenar informações */

--Concatenar todos os nomes das pessoas cadastradas
SELECT CONCAT(FirstName,' ', LastName)
FROM PERSON.Person

/* UPPER: Converter o resultado para maiúsculas */

--Tornar o nome completo das pessoas maiúsculo
SELECT UPPER(CONCAT(FirstName, ' ', LastName))
FROM Person.Person

/* LOWER: Converter o resultado para minúsculas*/

--Tornar o nome completo das pessoas minúsculo
SELECT LOWER(CONCAT(FirstName, ' ', LastName))
FROM Person.Person

/*LEN: Contar número de caracteres*/

--Contar o número de caracteres no primeiro nome de cada pessoa
SELECT LEN(FirstName)
FROM Person.Person

/* SUBSTRING: Retorna uma porção da String 
   SUBSTRING(str, x, n)
   Nota: Substring é indexado em 1 (x >= 1), e retorna até o caractere
   de índice n-1 subsequente ao índice x.
   SUBSTRING('CursoSQL', 2, 3) = URS 
*/

--Retornando uma porção do nome de cada pessoa
SELECT SUBSTRING(FirstName, 1, 3)
FROM Person.Person

/* REPLACE: Substitui determinado caractere em uma string */

--Substituindo o '-' no número do produto por '#'
SELECT REPLACE(ProductNumber, '-', '#')
FROM Production.Product

/* Funções matemáticas básicas
	Funções básicas: soma (+), divisão (/), subtração (-) e 
	multiplicação (*)
*/
--Aplicação das operações básicas sobre UnitPrice

--Divisão
SELECT UnitPrice / LineTotal
FROM SALES.SalesOrderDetail

--Subtração 
SELECT UnitPrice - LineTotal
FROM SALES.SalesOrderDetail

--Multiplicação
SELECT UnitPrice * LineTotal
FROM SALES.SalesOrderDetail

--Soma
SELECT UnitPrice + LineTotal
FROM SALES.SalesOrderDetail

/*	Demais funções matemáticas:

	AVG:	média
	MAX:	valor máximo das observações
	ROUND:  arredondamento
	SQRT:   raiz quadrada
*/

--Arredondamento para duas casas decimais de LineTotal
SELECT ROUND(Linetotal, 2) 
FROM Sales.SalesOrderDetail


/* SUBQUERIES */

--Identificar o relatório de todos os produtos cadastrados que possuem
--preço de venda acima da média

SELECT * FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice)
				   FROM Production.Product)

--Encontrar o nome dos funcionários que possuem o cargo de Design Engineer

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

/*Exercício:
  Encontrar todos os endereços que estão no estado de Alberta
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



