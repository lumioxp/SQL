--Aktualizacja ceny produktu:
SELECT * FROM Product p WHERE p.Name LIKE 'March%'; 
UPDATE Product SET Price = 3.00 WHERE Name LIKE 'March%';

/*
        Zaktualizuj adres Jana Kowalskiego na nowy adres:
            Ulica "Nowa", miasto "Gda�sk", kod pocztowy "80-001", kraj "Polska", stan "Pomorskie", numer budynku 15, numer mieszkania 2.
*/

--SELECT AddressID FROM Employee WHERE FirstName = 'Jan' AND LastName = 'Kowalski';
BEGIN TRANSACTION;
SELECT * FROM  Employee e
JOIN [Address] a ON e.AddressID = a.AddressID
WHERE e.AddressID = (SELECT AddressID FROM Employee WHERE FirstName = 'Jan' AND LastName = 'Kowalski'); 

UPDATE [Address] SET Street = 'Nowa', City = 'Gda�sk', PostalCode = '80-001', State = 'Pomorskie', BuildingNumber = 15, ApartmentNumber = 1 WHERE AddressID = 1;

ROLLBACK;
SELECT * FROM Address;


--Danie ograniczenia CHECK do tabeli OrderItem:
ALTER TABLE OrderItem
ADD CONSTRAINT chk_Quantity CHECK (Quantity > 0);


--Utworzenie indeksu na kolumnie Name w tabeli Product:
CREATE INDEX idx_Product_Name
ON Product (Name);


--Pobieranie produkt�w z kategorii "Owoce" i sortowanie ich wed�ug ceny rosn�co:
SELECT p.Name, p.Price
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID
WHERE c.Name = 'Owoce'
ORDER BY p.Price ASC;

--Pobieranie zam�wie� zrealizowanych przez pracownik�w o nazwisku "Kowalski":
SELECT o.OrderID, o.OrderDate, o.TotalAmount
FROM [Order] o
JOIN Employee e ON o.EmployeeID = e.EmployeeID
WHERE e.LastName = 'Kowalski';


--Obliczanie �redniej ceny produkt�w w ka�dej kategorii:
SELECT c.Name AS CategoryName, AVG(p.Price) AS AveragePrice
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID
GROUP BY c.Name;

--Zliczanie liczby zam�wie� z�o�onych przez ka�dego pracownika:
SELECT e.FirstName, e.LastName, COUNT(o.OrderID) AS OrderCount
FROM [Order] o
JOIN Employee e ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName;

--Pobieranie informacji o zam�wieniach wraz z nazwiskami pracownik�w i metodami p�atno�ci:
SELECT o.OrderID, o.OrderDate, o.TotalAmount, e.LastName AS EmployeeLastName, pm.Method AS PaymentMethod
FROM [Order] o
JOIN Employee e ON o.EmployeeID = e.EmployeeID
JOIN PaymentInfo pi ON o.PaymentInfoID = pi.PaymentInfoID
JOIN PaymentMethod pm ON pi.PaymentMethodID = pm.PaymentMethodID;

--Pobieranie produkt�w, kt�rych cena jest wy�sza ni� �rednia cena wszystkich produkt�w:
SELECT p.Name, p.Price
FROM Product p
WHERE p.Price > (SELECT AVG(Price) FROM Product);

--Tworzenie widoku wy�wietlaj�cego szczeg�y zam�wie�:
CREATE VIEW OrderDetailsView AS
SELECT o.OrderID, o.OrderDate, oi.Quantity, oi.Price AS ItemPrice, p.Name AS ProductName
FROM [Order] o
JOIN OrderItem oi ON o.OrderID = oi.OrderID
JOIN Product p ON oi.ProductID = p.ProductID;

SELECT * FROM OrderDetailsView;

DROP VIEW OrderDetailsView;

--Obliczanie sumy wszystkich zam�wie�:
SELECT SUM(TotalAmount) AS TotalSum FROM [Order];

--Obliczanie maksymalnej ceny produktu:
SELECT MAX(Price) FROM Product;

--Pobieranie pi�ciu najdro�szych produkt�w:
SELECT TOP 5 * FROM Product ORDER BY Price DESC;

--Pobieranie pi�ciu najta�szych produkt�w z kategorii "Napoje":
SELECT TOP 5 p.* 
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID
WHERE c.Name = 'Napoje'
ORDER BY p.Price ASC;
