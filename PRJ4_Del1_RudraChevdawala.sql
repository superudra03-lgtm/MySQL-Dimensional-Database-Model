# Deliverable 1 Operational Database:

DROP DATABASE IF EXISTS BigZ_Orders;
CREATE DATABASE BigZ_Orders;
USE BigZ_Orders;

CREATE TABLE DEPOT (
  DepotID VARCHAR(5) PRIMARY KEY,
  DepotSize VARCHAR(10),
  DepotZip VARCHAR(10)
);

CREATE TABLE SUPPLIER (
  SupplierID VARCHAR(5) PRIMARY KEY,
  SupplierName VARCHAR(50)
);

CREATE TABLE PRODUCT (
  ProductID VARCHAR(5) PRIMARY KEY,
  ProductName VARCHAR(50),
  ProductType VARCHAR(30),
  SupplierID VARCHAR(5),
  FOREIGN KEY (SupplierID) REFERENCES SUPPLIER(SupplierID)
);

CREATE TABLE CUSTOMER (
  CustomerID VARCHAR(5) PRIMARY KEY,
  CustomerName VARCHAR(50),
  CustomerType VARCHAR(30),
  CustomerZip VARCHAR(10)
);

CREATE TABLE ORDERCLERK (
  OCID VARCHAR(5) PRIMARY KEY,
  OCName VARCHAR(50)
);

CREATE TABLE ORDERS (
  OrderID VARCHAR(5) PRIMARY KEY,
  CustomerID VARCHAR(5),
  DepotID VARCHAR(5),
  OCID VARCHAR(5),
  OrderDate DATE,
  OrderTime TIME,
  FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
  FOREIGN KEY (DepotID) REFERENCES DEPOT(DepotID),
  FOREIGN KEY (OCID) REFERENCES ORDERCLERK(OCID)
);

CREATE TABLE ORDEREDVIA (
  ProductID VARCHAR(5),
  OrderID VARCHAR(5),
  Quantity INT,
  PRIMARY KEY (ProductID, OrderID),
  FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID),
  FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
);

INSERT INTO DEPOT VALUES
('D1','Small','60611'),
('D2','Large','60660'),
('D3','Large','60611');

INSERT INTO SUPPLIER VALUES
('ST','Super Tires'),
('BE','Batteries Etc');

INSERT INTO PRODUCT VALUES
('P1','BigGripper','Tire','ST'),
('P2','TractionWay','Tire','ST'),
('P3','SureStart','Battery','BE');

INSERT INTO CUSTOMER VALUES
('C1','Auto Doc','Repair Shop','60137'),
('C2','Bo’s Car Repair','Repair Shop','60140'),
('C3','JJ Auto Parts','Retailer','60605');

INSERT INTO ORDERCLERK VALUES
('OC1','Antonio'),
('OC2','Wesley'),
('OC3','Lilly');

INSERT INTO ORDERS VALUES
('O1','C1','D1','OC1','2025-01-01','09:00:00'),
('O2','C2','D1','OC2','2025-01-02','09:00:00'),
('O3','C3','D2','OC3','2025-01-02','09:30:00'),
('O4','C1','D2','OC1','2025-01-03','09:00:00'),
('O5','C2','D3','OC2','2025-01-03','09:15:00'),
('O6','C3','D3','OC3','2025-01-03','09:30:00');

INSERT INTO ORDEREDVIA VALUES
('P1','O1',4),('P2','O1',8),('P1','O2',12),('P2','O3',4),('P3','O4',7),('P3','O5',5),('P2','O6',8),('P1','O6',4);

# HR Database
DROP DATABASE IF EXISTS BigZ_HR;
CREATE DATABASE BigZ_HR;
USE BigZ_HR;

CREATE TABLE EMPLOYEE (
  EmployeeID VARCHAR(5) PRIMARY KEY,
  Name VARCHAR(50),
  Title VARCHAR(30),
  EducationLevel VARCHAR(30),
  YearOfHire INT
);

INSERT INTO EMPLOYEE VALUES
('OC1','Antonio','Order Clerk','High School',2015),
('OC2','Wesley','Order Clerk','College',2021),
('OC3','Lilly','Order Clerk','College',2021);
