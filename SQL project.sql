-- Membuat tabel DimBranch
CREATE TABLE DimBranch (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    BranchLocation VARCHAR(100)
);

-- Membuat tabel DimCustomer
CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Address VARCHAR(200),
    CityName VARCHAR(100),
    StateName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Email VARCHAR(100)
);


-- Membuat tabel DimAccount
CREATE TABLE DimAccount (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(50),
    Balance DECIMAL(18, 2),
    DateOpened DATE,
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);

-- Membuat tabel FactTransaction
CREATE TABLE FactTransaction (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    Amount DECIMAL(18, 2),
    TransactionType VARCHAR(50),
    BranchID INT,
    FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID),
    FOREIGN KEY (BranchID) REFERENCES DimBranch(BranchID)
);

SELECT * FROM DimAccount;
SELECT * FROM DimBranch;
SELECT * FROM DimCustomer;
SELECT* FROM FactTransaction;

-- Daily Transaction
CREATE PROCEDURE DailyTransaction
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        CAST(TransactionDate AS DATE) AS [Date],
        COUNT(*) AS TotalTransactions,
        SUM(Amount) AS TotalAmount
    FROM 
        FactTransaction
    WHERE 
        TransactionDate BETWEEN @StartDate AND @EndDate
    GROUP BY 
        CAST(TransactionDate AS DATE);
END;

EXEC DailyTransaction @StartDate = '2024-01-18', @EndDate = '2024-01-20';

-- Balance per customer
CREATE PROCEDURE BalancePerCustomer
    @CustomerName VARCHAR(255)
AS
BEGIN
    SELECT 
        c.CustomerName AS CustomerName,
        a.AccountType AS AccountType,
        a.Balance AS Balance,
        a.Balance + ISNULL(SUM(
            CASE 
                WHEN t.TransactionType = 'Deposit' THEN t.Amount
                ELSE -t.Amount
            END
        ), 0) AS CurrentBalance
    FROM 
        DimCustomer c
    JOIN 
        DimAccount a ON c.CustomerID = a.CustomerID
    LEFT JOIN 
        FactTransaction t ON a.AccountID = t.AccountID
    WHERE 
        c.CustomerName = @CustomerName
        AND a.Status = 'Active'
    GROUP BY 
        c.CustomerName, a.AccountType, a.Balance
	ORDER BY 
		Balance DESC;
END;

EXEC BalancePerCustomer @CustomerName = 'SHELLY JUWITA';
