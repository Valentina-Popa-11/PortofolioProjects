
--	preview first 5 rows 
SELECT TOP 5 * 
FROM dbo.MyBooks

-- count total no of rows in the table
SELECT COUNT(*)
FROM dbo.MyBooks

--	preview last 3 rows 
SELECT * 
FROM dbo.MyBooks
ORDER BY Autor, Titlu DESC
OFFSET 0 ROW -- decide the starting row to return rows
FETCH NEXT 3 ROW ONLY -- return a set no of rows

-- delete the last two rows
DELETE FROM dbo.MyBooks
WHERE Titlu IS NULL

-- count how many books are in total
SELECT SUM(Volume)
FROM dbo.MyBooks

-- Create views for later visualisations
CREATE VIEW TotalBooks AS SELECT COUNT(Exemplare) AS TotalBooks
FROM dbo.MyBooks

-- count how many books are read and unread
SELECT Citite, COUNT(Citite) 
FROM dbo.MyBooks
GROUP BY Citite

-- Create views for later visualisations
CREATE VIEW TotalReadUnread AS SELECT Citite, COUNT(Citite) AS TotalRead
FROM dbo.MyBooks
GROUP BY Citite

-- count how many books are duplicates
SELECT COUNT(Exemplare)
FROM dbo.MyBooks
WHERE Exemplare > 1

-- Create views for later visualisations
CREATE VIEW Duplicates AS SELECT COUNT(Exemplare) AS Duplicates
FROM dbo.MyBooks

-- count total no of distinct authors
SELECT COUNT (DISTINCT Autor)
FROM dbo.MyBooks

-- count how many books per author, exept series and duplicates
SELECT Autor, COUNT(Exemplare)
FROM dbo.MyBooks
WHERE Exemplare = 1 
GROUP BY Autor
ORDER BY COUNT(Exemplare) DESC

-- Create views for later visualisations
CREATE VIEW PerAuthor AS SELECT Autor, COUNT(Exemplare) AS PerAuthor
FROM dbo.MyBooks
WHERE Exemplare = 1 
GROUP BY Autor

-- select best read books
SELECT Autor
	, Titlu
FROM dbo.MyBooks
WHERE Rating = 5

-- Create views for later visualisations
CREATE VIEW BestBooks AS SELECT Autor, Titlu
FROM dbo.MyBooks
WHERE Rating = 5

-- select worst read books
SELECT Autor
	, Titlu
FROM dbo.MyBooks
WHERE Rating <= 1

-- Create views for later visualisations
CREATE VIEW WorstBooks AS SELECT Autor, Titlu
FROM dbo.MyBooks
WHERE Rating <= 1

-- count how many books are in romanian and how many are in english
SELECT Limba, COUNT(Exemplare)
FROM dbo.MyBooks
GROUP BY Limba

-- Create views for later visualisations
CREATE VIEW Languages AS SELECT Limba, COUNT(Exemplare) AS PerLanguage
FROM dbo.MyBooks
GROUP BY Limba

-- count how many books are in Romania and how many are in UK
SELECT Locatie, COUNT(Exemplare)
FROM dbo.MyBooks
WHERE Exemplare >= 0
GROUP BY Locatie

-- Create views for later visualisations
CREATE VIEW Location AS SELECT Locatie, COUNT(Exemplare) AS PerLocation
FROM dbo.MyBooks
WHERE Exemplare >= 0
GROUP BY Locatie