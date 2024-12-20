-- Создаём таблицу для архива
CREATE TABLE PlacingAthleteArchive (
    Id SERIAL PRIMARY KEY,
    AthleteId INTEGER,
    RoomId INTEGER,
    PlacingDate DATE,
    UnplacingDate DATE,
    ArchivedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создаём хранимую процедуру
CREATE OR REPLACE PROCEDURE archive_athlete_placings(athlete_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Перемещаем записи из PlacingAthlete в PlacingAthleteArchive
    INSERT INTO PlacingAthleteArchive (AthleteId, RoomId, PlacingDate, UnplacingDate)
    SELECT AthleteId, RoomId, PlacingDate, UnplacingDate
    FROM PlacingAthlete
    WHERE AthleteId = athlete_id;

    -- Удаляем записи из PlacingAthlete
    DELETE FROM PlacingAthlete WHERE AthleteId = athlete_id;

    RAISE NOTICE 'All placings for athlete % have been archived.', athlete_id;
END;
$$;

CALL archive_athlete_placings(3);



-- Создаём функцию
CREATE OR REPLACE FUNCTION get_athlete_hotels(athlete_id INTEGER)
RETURNS TABLE(HotelName VARCHAR, Address VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT h.HotelName, h.Address
    FROM PlacingAthlete pa
    JOIN Rooms r ON pa.RoomId = r.Id
    JOIN Hotel h ON r.HotelId = h.Id
    WHERE pa.AthleteId = athlete_id;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_athlete_hotels(5);
