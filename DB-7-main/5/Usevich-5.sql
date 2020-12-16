CREATE FUNCTION Sales.GetTotalOrderPrice(@SalesOrderID INT)
RETURNS MONEY
AS
BEGIN
	RETURN (
		SELECT (SUM(soh.SubTotal) + SUM(soh.TaxAmt) + SUM(soh.Freight))
		FROM Sales.SalesOrderHeader soh
		WHERE soh.SalesOrderID = @SalesOrderID);
END;
GO

CREATE FUNCTION Production.GetOrderDetails(@WorkOrderID INT)
RETURNS TABLE AS RETURN (
	SELECT 
		WorkOrderID,
		ProductID,
		OperationSequence,
		LocationID,
		ScheduledStartDate,
		ScheduledEndDate,
		ActualStartDate,
		ActualEndDate,
		ActualResourceHrs,
		PlannedCost,
		ActualCost,
		ModifiedDate
	FROM Production.WorkOrderRouting
	WHERE Production.WorkOrderRouting.WorkOrderID = @WorkOrderID		
);
GO

SELECT * FROM Production.WorkOrder CROSS APPLY Production.GetOrderDetails(WorkOrderID);
SELECT * FROM Production.WorkOrder OUTER APPLY Production.GetOrderDetails(WorkOrderID);

DROP FUNCTION Production.GetOrderDetails
GO

CREATE FUNCTION Production.GetOrderDetails(@WorkOrderID int)
RETURNS @Details TABLE(
	WorkOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    OperationSequence SMALLINT NOT NULL,
    LocationID SMALLINT NOT NULL,
    ScheduledStartDate DATETIME NOT NULL,
    ScheduledEndDate DATETIME NOT NULL,
    ActualStartDate DATETIME NULL,
    ActualEndDate DATETIME NULL,
    ActualResourceHrs DECIMAL(9, 4) NULL,
    PlannedCost MONEY NOT NULL,
    ActualCost MONEY NULL,
    ModifiedDate DATETIME NOT NULL
) AS 
BEGIN
	INSERT INTO @Details
	SELECT 
		WorkOrderID,
		ProductID,
		OperationSequence,
		LocationID,
		ScheduledStartDate,
		ScheduledEndDate,
		ActualStartDate,
		ActualEndDate,
		ActualResourceHrs,
		PlannedCost,
		ActualCost,
		ModifiedDate
	FROM Production.WorkOrderRouting
	WHERE Production.WorkOrderRouting.WorkOrderID = @WorkOrderID
	RETURN
END;