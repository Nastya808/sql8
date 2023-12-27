INSERT INTO Employees (Name, Position, Department) VALUES
('John Doe', 'Manager', 'IT'),
('Jane Smith', 'Developer', 'IT'),
('Bob Johnson', 'HR Specialist', 'HR'),
('Alice Brown', 'Sales Representative', 'Sales');

INSERT INTO EmployeeDetails (EmployeeID, Email, PhoneNumber) VALUES
(1, 'john.doe@example.com', '+1234567890'),
(2, 'jane.smith@example.com', '+9876543210'),
(3, 'bob.johnson@example.com', '+1122334455'),
(4, 'alice.brown@example.com', '+9988776655');

-- 1
CREATE PROCEDURE AddEmployee
    @Name NVARCHAR(50),
    @Position NVARCHAR(50),
    @Department NVARCHAR(50),
    @Email NVARCHAR(50),
    @PhoneNumber NVARCHAR(15)
AS
BEGIN
    DECLARE @EmployeeID INT;

    INSERT INTO Employees (Name, Position, Department) VALUES (@Name, @Position, @Department);

    SET @EmployeeID = SCOPE_IDENTITY();

    INSERT INTO EmployeeDetails (EmployeeID, Email, PhoneNumber) VALUES (@EmployeeID, @Email, @PhoneNumber);
END;

-- 2
CREATE PROCEDURE GetEmployeeData
AS
BEGIN
    SELECT Employees.ID, Employees.Name, Employees.Position, Employees.Department, EmployeeDetails.Email, EmployeeDetails.PhoneNumber
    FROM Employees
    INNER JOIN EmployeeDetails ON Employees.ID = EmployeeDetails.EmployeeID;
END;

-- 3
CREATE PROCEDURE UpdateEmployee
    @EmployeeID INT,
    @Name NVARCHAR(50),
    @Position NVARCHAR(50),
    @Department NVARCHAR(50),
    @Email NVARCHAR(50),
    @PhoneNumber NVARCHAR(15)
AS
BEGIN
    UPDATE Employees
    SET Name = @Name, Position = @Position, Department = @Department
    WHERE ID = @EmployeeID;

    UPDATE EmployeeDetails
    SET Email = @Email, PhoneNumber = @PhoneNumber
    WHERE EmployeeID = @EmployeeID;
END;

-- 4
CREATE PROCEDURE DeleteEmployee
    @EmployeeID INT
AS
BEGIN
    DELETE FROM EmployeeDetails WHERE EmployeeID = @EmployeeID;

    DELETE FROM Employees WHERE ID = @EmployeeID;
END;

-- 5
CREATE PROCEDURE AddEmployeeOptional
    @Name NVARCHAR(50),
    @Position NVARCHAR(50),
    @Department NVARCHAR(50),
    @Email NVARCHAR(50) = NULL,
    @PhoneNumber NVARCHAR(15) = NULL
AS
BEGIN
    DECLARE @EmployeeID INT;

    INSERT INTO Employees (Name, Position, Department) VALUES (@Name, @Position, @Department);

    SET @EmployeeID = SCOPE_IDENTITY();

    IF @Email IS NOT NULL OR @PhoneNumber IS NOT NULL
    BEGIN
        INSERT INTO EmployeeDetails (EmployeeID, Email, PhoneNumber) VALUES (@EmployeeID, @Email, @PhoneNumber);
    END;
END;

-- 6
CREATE PROCEDURE GetEmployeeDetails
    @EmployeeID INT,
    @Email NVARCHAR(50) OUTPUT,
    @PhoneNumber NVARCHAR(15) OUTPUT
AS
BEGIN
    SELECT @Email = Email, @PhoneNumber = PhoneNumber
    FROM EmployeeDetails
    WHERE EmployeeID = @EmployeeID;
END;
