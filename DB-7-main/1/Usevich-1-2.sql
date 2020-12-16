SELECT DepartmentID, Name 
FROM HumanResources.Department 
WHERE Name LIKE 'F%e';

SELECT AVG(VacationHours)AS 'AvgVacationHours', AVG(SickLeaveHours) AS 'AvgSickLeaveHours'  
FROM HumanResources.Employee; 

SELECT BusinessEntityID, JobTitle, Gender, DATEDIFF(year, HireDate, GETDATE()) AS YearsWorked
FROM HumanResources.Employee
WHERE DATEDIFF(year, BirthDate, GETDATE()) > 65; 