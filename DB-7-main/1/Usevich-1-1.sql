CREATE DATABASE NewDatabase;

USE NewDatabase;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA persons;
GO

CREATE TABLE sales.Orders (OrderNum INT NULL);
GO

BACKUP DATABASE NewDatabase TO DISK = 'D:\bd\1\NewDatabase.bak';
GO

USE master;
DROP DATABASE NewDatabase;
GO

RESTORE DATABASE NewDatabase FROM DISK = 'D:\bd\1\NewDatabase.bak';
GO