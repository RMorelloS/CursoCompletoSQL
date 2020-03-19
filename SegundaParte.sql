/*
	Curso SQL Completo 2019 - Segunda parte
	Este script utiliza da base de dados NorthWind. O arquivo está
	disponível em:
	https://raw.githubusercontent.com/Microsoft/sql-server-samples/master/samples/databases/northwind-pubs/instnwnd.sql
	Para utilizá-la, deve-se descarregar o script e executá-lo no SSMS.
	Desenvolvido por: Ricardo Morello Santos
	Fonte: Curso SQL Completo 2019 [Iniciantes] + Desafios + Muita Prática
	Disponível em: https://www.youtube.com/watch?v=rX2I7OjLqWE
*/

/*
	SELF Join: Agrupar ou ordenar dados dentro da mesma tabela
	Nota: O SELF Join só funciona com um apelido (AS)
*/

--Selecionar todos os clientes que moram na mesma região

SELECT A.ContactName, A.Region, B.ContactName, B.Region
FROM Customers A, Customers B
WHERE A.Region = B.Region

--Selecionar nome e data de contratação de todos os funcionários que foram
--contratados no mesmo ano

SELECT A.FirstName, A.HireDate, B.FirstName, B.HireDate
FROM Employees A, Employees B
Where DATEPART(year, A.HireDate) = DATEPART(year, B.HireDate)

/* Exercício:
	Encontrar, na tabela detalhe do pedido, quais produtos têm o mesmo percentual
	de desconto
*/
SELECT A.OrderID, A.Discount, B.OrderID, B.Discount
FROM [Order Details] A, [Order Details] B
WHERE A.Discount = B.Discount


/*	Tipos de dados no SQL Server
	
	1. Booleanos
	Por padrão, é inicializado como nulo, e pode receber valores 1, 0 ou nulo. 
	No SQL Server, utiliza-se o tipo BIT para representar booleanos.

	2. Caractere
	Utiliza-se CHAR para um tamanho fixo, que ocupa todo o espaço reservado.
	Para tamanhos variáveis, utiliza-se varchar ou nvarchar

	3. Números
	3.1 Valores exatos
		Para armazenar valores inteiros de acordo com o tamanho máximo suportado:
		TINYINT
		SMALLINT
		INT
		BIGINT
		Para armazenar valores exatos ou fracionados, podendo também especificar 
		precisão (número de digitos significativos) e escala (número de dígitos após
		a vírgula):
		NUMERIC ou DECIMAL
	3.2 Valores aproximados
		REAL, FLOAT - precisão aproximada de 15 dígitos
	4. Temporais
	Armazena datas.
	DATE: Armazena no formato AAAA/MM/DD
	DATETIME: Armazena data e horas no formato AAAA/MM/DD:HH:MM:SS
	DATETIME2: Armazena até milissegundos no formato AAAA/MM/DD:HH:MM:SS:sssssss
	SMALLDATETIME: Armaena no limite entre '1900-01-01:00:00:00' até '2079-06-06:23:59:59'
	TIME: Horas, minutos, segundos e milissegundos no intervalo '00:00:00:0000000'
		até '23:59:59:0000000'
	DATETIMEOFFSET: Inclui informações de fuso horário
*/

