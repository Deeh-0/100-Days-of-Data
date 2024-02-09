--Question 1: How many accidents have occurred in urban areas versus rural areas?
 SELECT
	[Area],
	COUNT([AccidentIndex]) AS 'Total Accidents'
 FROM
	[dbo].[accident]
GROUP BY
	[Area];

--Question 2: Which day of the week has the highest number of accidents?
SELECT
	[Day],
	COUNT([AccidentIndex]) AS 'Total Accidents'
FROM
	[dbo].[accident]
GROUP BY 
	[Day]
ORDER BY
	'Total Accidents' DESC;

--Question 3: What is the average age of vehicles involved in accidents based on their type?
SELECT 
	[VehicleType],
	COUNT([AccidentIndex]) AS 'Total Accidents',
	AVG([AgeVehicle]) AS 'Average Age'
FROM
	[dbo].[vehicle]
WHERE [AgeVehicle] IS NOT NULL
GROUP BY
	[VehicleType]
ORDER BY 
	'Total Accidents' DESC;

--Question 4: Can we identify any trends in accidents based on the age of vehicles involved?
SELECT
	AgeGroup,
	COUNT([AccidentIndex]) AS 'Total Accidents',
	AVG([AgeVehicle]) AS 'Average Age'
FROM(
	SELECT 
	[AccidentIndex],
	[AgeVehicle],

	CASE
		WHEN [AgeVehicle] BETWEEN 0 AND 5 THEN 'New'
		WHEN [AgeVehicle] BETWEEN 6 AND 10 THEN 'Regular'
		ELSE 'Old'
	END AS AgeGroup
FROM
	[dbo].[vehicle]
) AS Subquery

GROUP BY
	AgeGroup;

--Question 5: Are there any specific weather conditions that contribute to severe accidents?
SELECT 
	[WeatherConditions],
	[Severity],
	COUNT([AccidentIndex]) AS 'Accident Count'
FROM 
	[dbo].[accident]
GROUP BY
	[WeatherConditions],
	[Severity]
ORDER BY
	'Accident Count' DESC;

--Question 6: Do accidents often involve impacts on the left-hand side of vehicles?
SELECT
	[LeftHand],
	COUNT([AccidentIndex]) AS 'Accident Count'
FROM
	[dbo].[vehicle]
WHERE [LeftHand] IS NOT NULL
GROUP BY
	[LeftHand]
ORDER BY
	[LeftHand];
	

--Question 7: Are there any relationships between journey purposes and the severity of accidents?
SELECT
    V.[JourneyPurpose],
    A.[Severity],
    COUNT(*) AS AccidentCount
FROM
    [dbo].[accident] A
JOIN
    [dbo].[vehicle] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY
    V.[JourneyPurpose],
    A.[Severity]
ORDER BY
    V.[JourneyPurpose],
    A.[Severity];


--Question 8: Calculate the average age of vehicles involved in accidents , considering Day light and point of impact:
SELECT 
	A.[LightConditions],
	V.[PointImpact],
	AVG([AgeVehicle]) AS 'Average Age'
FROM
	[dbo].[accident] A
JOIN [dbo].[vehicle] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY 
	A.[LightConditions],
	V.[PointImpact]
ORDER BY
	A.[LightConditions],
	V.[PointImpact];
	