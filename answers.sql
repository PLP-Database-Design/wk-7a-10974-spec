--Question 1: Achieving 1NF (First Normal Form)


CREATE TABLE ProductDetail_1NF AS
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM 
    ProductDetail
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) numbers
    ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
WHERE 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) != '';


--Question 2: Achieving 2NF (Second Normal Form)

-- Create Orders table 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Create OrderItems table for product details
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Populate OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
