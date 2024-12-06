--A
SELECT * 
FROM Athlete
WHERE Class = 2;

--B
SELECT * 
FROM Athlete
ORDER BY LastName ASC;

--C
SELECT Class, COUNT(*) AS AthleteCount
FROM Athlete
GROUP BY Class;

--D
SELECT * 
FROM Athlete
WHERE LastName LIKE 'И%';

SELECT CONCAT(LastName, ' ', FirstName) AS FullName
FROM Athlete;

--E
SELECT * 
FROM PlacingAthlete
WHERE PlacingDate > '2024-12-01';

SELECT AthleteId, PlacingDate, CURRENT_DATE - PlacingDate AS DaysInPlace
FROM PlacingAthlete;
