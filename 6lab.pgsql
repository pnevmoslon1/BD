CREATE VIEW AthletePlacingDetails AS
SELECT
    a.Id AS AthleteId,
    CONCAT(a.FirstName, ' ', a.LastName) AS AthleteFullName,
    ac.Name AS AthleteClassName,
    s.Name AS SportName,
    h.HotelName,
    r.Name AS RoomName,
    pa.PlacingDate,
    pa.UnplacingDate
FROM Athlete a
LEFT JOIN AthleteClass ac ON a.Class = ac.Id
LEFT JOIN Athlete_Sport asport ON a.Id = asport.AthleteId
LEFT JOIN Sport s ON asport.SportId = s.Id
LEFT JOIN PlacingAthlete pa ON a.Id = pa.AthleteId
LEFT JOIN Rooms r ON pa.RoomId = r.Id
LEFT JOIN Hotel h ON r.HotelId = h.Id
WHERE pa.PlacingDate IS NOT NULL;


CREATE VIEW AthletesWithSports AS
SELECT
    a.Id AS AthleteId,
    a.FirstName,
    a.FatherName,
    ac.Name AS AthleteClassName,
    s.Name AS SportName
FROM Athlete a
LEFT JOIN AthleteClass ac ON a.Class = ac.Id
LEFT JOIN Athlete_Sport asport ON a.Id = asport.AthleteId
LEFT JOIN Sport s ON asport.SportId = s.Id
WHERE ac.Name != 'Любитель';


SELECT * FROM AthletePlacingDetails;


SELECT * FROM AthletesWithSports;
