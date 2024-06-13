-- use [Mistrz Smaku];

CREATE TABLE Category(
    CategoryID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Product(
    ProductID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID),
    Price DECIMAL(10, 2) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE Address(
    AddressID INT IDENTITY PRIMARY KEY,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(6) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    State VARCHAR(50),
    BuildingNumber INT NOT NULL,
    ApartmentNumber INT
);

CREATE TABLE Employee(
    EmployeeID INT IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
	Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    AddressID INT FOREIGN KEY REFERENCES Address(AddressID),
    Position VARCHAR(4) -- crew, jsm, sm, asm, gm
);

CREATE TABLE PaymentMethod(
	PaymentMethodID INT IDENTITY PRIMARY KEY,
	Method VARCHAR(50) NOT NULL -- BLIK, Credit Card, Cash 
);

CREATE TABLE PaymentInfo(
    PaymentInfoID INT IDENTITY PRIMARY KEY,
    PaymentMethodID INT FOREIGN KEY REFERENCES PaymentMethod(PaymentMethodID),
    CardNumber VARCHAR(20),
    ExpiryDate DATE NOT NULL
);

CREATE TABLE [Order](
    OrderID INT IDENTITY PRIMARY KEY,
    PaymentInfoID INT FOREIGN KEY REFERENCES PaymentInfo(PaymentInfoID),
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
	EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID)
);

CREATE TABLE OrderItem(
    OrderItemID INT IDENTITY PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES [Order](OrderID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Price DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL
);

CREATE TABLE Inventory(
	InventoryID INT IDENTITY PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
	Quantity INT,
	LastUpdated DATE,
);

CREATE TABLE Supplier(
    SupplierID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactPerson VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE ProductSupplier(
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID),
    SupplyDate DATE NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (ProductID, SupplierID, SupplyDate)
);

CREATE TABLE SupplierCategory (
    SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID),
    CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID),
    PRIMARY KEY (SupplierID, CategoryID)
);