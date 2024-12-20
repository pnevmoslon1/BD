
CREATE TABLE ActionLog (
    Id SERIAL PRIMARY KEY,
    TableName VARCHAR(255) NOT NULL,
    Action VARCHAR(50) NOT NULL,
    RecordId INTEGER NOT NULL,
    ActionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_athlete_actions()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO ActionLog (TableName, Action, RecordId)
        VALUES ('Athlete', 'INSERT', NEW.Id);
    END IF;
    IF TG_OP = 'DELETE' THEN
        INSERT INTO ActionLog (TableName, Action, RecordId)
        VALUES ('Athlete', 'DELETE', OLD.Id);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_log_athlete_actions
AFTER INSERT OR DELETE ON Athlete
FOR EACH ROW
EXECUTE FUNCTION log_athlete_actions();

INSERT INTO Athlete (FirstName, LastName, FatherName, Class) VALUES ('John', 'Doe', 'Michael', 1);

DELETE FROM Athlete WHERE Id = 1;

SELECT * FROM ActionLog;


-- 
CREATE OR REPLACE FUNCTION validate_room_capacity()
RETURNS TRIGGER AS $$
DECLARE
    current_occupancy INTEGER;
    room_capacity INTEGER;
BEGIN
    SELECT COUNT(*) INTO current_occupancy
    FROM PlacingAthlete
    WHERE RoomId = NEW.RoomId AND UnplacingDate IS NULL;

    SELECT Capacity INTO room_capacity
    FROM Rooms
    WHERE Id = NEW.RoomId;

    IF current_occupancy >= room_capacity THEN
        RAISE EXCEPTION 'Room is full. Current occupancy: %, Capacity: %', current_occupancy, room_capacity;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validate_room_capacity
BEFORE INSERT ON PlacingAthlete
FOR EACH ROW
EXECUTE FUNCTION validate_room_capacity();


SELECT * FROM  actionlog;

INSERT INTO PlacingAthlete (AthleteId, RoomId, PlacingDate)
VALUES (3, 1, CURRENT_DATE);


