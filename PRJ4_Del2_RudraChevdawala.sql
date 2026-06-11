# Deliverable 2 Big Z Data Warehouse:

DROP DATABASE IF EXISTS BigZ_DW;
CREATE DATABASE BigZ_DW;
USE BigZ_DW;

CREATE TABLE DIM_PRODUCT (
  ProductKey INT AUTO_INCREMENT PRIMARY KEY,
  ProductID VARCHAR(5),
  ProductName VARCHAR(50),
  ProductType VARCHAR(30),
  ProductSupplierName VARCHAR(50)
);

CREATE TABLE DIM_CUSTOMER (
  CustomerKey INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID VARCHAR(5),
  CustomerName VARCHAR(50),
  CustomerType VARCHAR(30),
  CustomerZip VARCHAR(10)
);

CREATE TABLE DIM_DEPOT (
  DepotKey INT AUTO_INCREMENT PRIMARY KEY,
  DepotID VARCHAR(5),
  DepotSize VARCHAR(10),
  DepotZip VARCHAR(10)
);

CREATE TABLE DIM_ORDERCLERK (
  OrderClerkKey INT AUTO_INCREMENT PRIMARY KEY,
  OrderClerkID VARCHAR(5),
  OrderClerkName VARCHAR(50),
  OrderClerkTitle VARCHAR(30),
  OCEducationLevel VARCHAR(30),
  OCYearOfHire INT
);

CREATE TABLE DIM_DATE (
  DateKey INT PRIMARY KEY,
  FullDate DATE,
  DayOfWeek VARCHAR(10),
  DayOfMonth INT,
  Month INT,
  Quarter INT,
  Year INT
);

CREATE TABLE FACT_ORDER_SALES (
  Quantity INT,
  ProductKey INT,
  DateKey INT,
  CustomerKey INT,
  DepotKey INT,
  OrderClerkKey INT,
  FOREIGN KEY (ProductKey) REFERENCES DIM_PRODUCT(ProductKey),
  FOREIGN KEY (DateKey) REFERENCES DIM_DATE(DateKey),
  FOREIGN KEY (CustomerKey) REFERENCES DIM_CUSTOMER(CustomerKey),
  FOREIGN KEY (DepotKey) REFERENCES DIM_DEPOT(DepotKey),
  FOREIGN KEY (OrderClerkKey) REFERENCES DIM_ORDERCLERK(OrderClerkKey)
);


# Loading Dimensions
INSERT INTO DIM_PRODUCT (ProductID,ProductName,ProductType,ProductSupplierName)
SELECT p.ProductID,p.ProductName,p.ProductType,s.SupplierName
FROM BigZ_Orders.PRODUCT p
JOIN BigZ_Orders.SUPPLIER s ON p.SupplierID=s.SupplierID;

INSERT INTO DIM_CUSTOMER (CustomerID,CustomerName,CustomerType,CustomerZip)
SELECT * FROM BigZ_Orders.CUSTOMER;

INSERT INTO DIM_DEPOT (DepotID,DepotSize,DepotZip)
SELECT * FROM BigZ_Orders.DEPOT;

INSERT INTO DIM_ORDERCLERK (OrderClerkID,OrderClerkName,OrderClerkTitle,OCEducationLevel,OCYearOfHire)
SELECT e.EmployeeID,e.Name,e.Title,e.EducationLevel,e.YearOfHire
FROM BigZ_HR.EMPLOYEE e;

INSERT INTO DIM_DATE (DateKey, FullDate, DayOfWeek, DayOfMonth, Month, Quarter, Year)
SELECT DISTINCT
  DATE_FORMAT(o.OrderDate,'%Y%m%d') AS DateKey,
  o.OrderDate,
  DAYNAME(o.OrderDate),
  DAY(o.OrderDate),
  MONTH(o.OrderDate),
  QUARTER(o.OrderDate),
  YEAR(o.OrderDate)
FROM BigZ_Orders.ORDERS o;


# Loading Fact Table
INSERT INTO FACT_ORDER_SALES (Quantity,ProductKey,DateKey,CustomerKey,DepotKey,OrderClerkKey)
SELECT od.Quantity,
       dp.ProductKey,
       dd.DateKey,
       dc.CustomerKey,
       ddp.DepotKey,
       doc.OrderClerkKey
FROM BigZ_Orders.ORDEREDVIA od
JOIN BigZ_Orders.ORDERS o ON od.OrderID=o.OrderID
JOIN DIM_PRODUCT dp ON od.ProductID=dp.ProductID
JOIN DIM_CUSTOMER dc ON o.CustomerID=dc.CustomerID
JOIN DIM_DEPOT ddp ON o.DepotID=ddp.DepotID
JOIN DIM_ORDERCLERK doc ON o.OCID=doc.OrderClerkID
JOIN DIM_DATE dd ON dd.FullDate=o.OrderDate;