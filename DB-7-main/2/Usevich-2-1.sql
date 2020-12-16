SELECT d.Name, MIN(edh.StartDate) as StartDate
FROM HumanResources.Employee e
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name;

SELECT e.BusinessEntityID, e.JobTitle, CASE s.Name
										 WHEN 'Day' THEN 1
										 WHEN 'Evening' THEN 2
										 WHEN 'Night' THEN 3
									   END AS ShiftName
FROM HumanResources.Employee e
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Shift s ON edh.ShiftID = s.ShiftID
WHERE e.JobTitle = 'Stocker';

SELECT e.BusinessEntityID, REPLACE(e.JobTitle, 'and', '&') AS JobTitle, d.Name
FROM HumanResources.Employee e
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID;