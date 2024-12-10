--A
SELECT a.FirstName, a.LastName, s.Name AS SportName
FROM Athlete AS a
INNER JOIN Athlete_Sport AS asport ON a.Id = asport.AthleteId
INNER JOIN Sport AS s ON asport.SportId = s.Id;


SELECT a.FirstName, a.LastName, s.Name AS SportName
FROM Athlete AS a
FULL JOIN Athlete_Sport AS asport ON a.Id = asport.AthleteId
FULL JOIN Sport AS s ON asport.SportId = s.Id;

--B
SELECT a.FirstName, a.LastName, ac.Name AS AthleteClass, s.Name AS SportName
FROM Athlete AS a
INNER JOIN AthleteClass AS ac ON a.Class = ac.Id
INNER JOIN Athlete_Sport AS asport ON a.Id = asport.AthleteId
INNER JOIN Sport AS s ON asport.SportId = s.Id;

--C
SELECT s.Name AS SportName, COUNT(a.Id) AS AthleteCount
FROM Sport AS s
INNER JOIN Athlete_Sport AS asport ON s.Id = asport.SportId
INNER JOIN Athlete AS a ON asport.AthleteId = a.Id
GROUP BY s.Name;

--D
SELECT a.FirstName, a.LastName
FROM Athlete AS a
WHERE a.Id IN (
    SELECT asport.AthleteId
    FROM Athlete_Sport AS asport
    WHERE asport.SportId = (
        SELECT s.Id 
        FROM Sport AS s
        WHERE s.Name = 'Теннис'
    )
);

SELECT a.FirstName, a.LastName
FROM Athlete AS a
WHERE a.Id IN (
    SELECT pa.AthleteId
    FROM PlacingAthlete AS pa
    WHERE pa.RoomId IN (
        SELECT r.Id
        FROM Rooms AS r
        WHERE r.HotelId = (
            SELECT h.Id
            FROM Hotel AS h
            WHERE h.HotelName = 'Гранд Отель'
        )
    )
);


