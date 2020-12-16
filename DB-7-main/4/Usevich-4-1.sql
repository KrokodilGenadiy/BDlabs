CREATE TABLE Person.PhoneNumberTypeHst (
	ID INT IDENTITY(1, 1) PRIMARY KEY,
	Action CHAR(6) NOT NULL CHECK (Action IN('INSERT', 'UPDATE', 'DELETE')),
	ModifiedDate DATETIME NOT NULL,
	SourceID INT NOT NULL,
	UserName VARCHAR(50) NOT NULL
);

CREATE TRIGGER Person.PhoneNumberTypeInsert
ON Person.PhoneNumberType
AFTER INSERT AS
	INSERT INTO Person.PhoneNumberTypeHst([Action], ModifiedDate, SourceID, UserName)
	SELECT 'INSERT', GETDATE(), ins.PhoneNumberTypeID, USER_NAME()
	FROM inserted AS ins;

CREATE TRIGGER Person.PhoneNumberTypeUpdate
ON Person.PhoneNumberType
AFTER UPDATE AS
	INSERT INTO Person.PhoneNumberTypeHst([Action], ModifiedDate, SourceID, UserName)
	SELECT 'UPDATE', GETDATE(), ins.PhoneNumberTypeID, USER_NAME()
	FROM inserted AS ins;

CREATE TRIGGER Person.PhoneNumberTypeDelete
ON Person.PhoneNumberType
AFTER DELETE AS
	INSERT INTO Person.PhoneNumberTypeHst([Action], ModifiedDate, SourceID, UserName)
	SELECT 'DELETE', GETDATE(), del.PhoneNumberTypeID, USER_NAME()
	FROM deleted AS del;

CREATE VIEW Person.PhoneNumberTypeView
WITH ENCRYPTION
AS SELECT * FROM Person.PhoneNumberType;

INSERT INTO Person.PhoneNumberTypeView (Name, ModifiedDate)
VALUES ('Mobile', GETDATE());

UPDATE Person.PhoneNumberTypeView
SET Name = 'Home_'
WHERE PhoneNumberTypeID = 1;


DELETE FROM Person.PhoneNumberTypeView
WHERE Name = 'Mobile';

SELECT * FROM Person.PhoneNumberTypeHst;
