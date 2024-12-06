


CREATE TABLE Sport (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);


CREATE TABLE AthleteClass (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);


CREATE TABLE Athlete (
    Id SERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FatherName VARCHAR(255),
    Class INTEGER REFERENCES AthleteClass(Id) ON DELETE SET NULL
);


CREATE TABLE Athlete_Sport (
    AthleteId INTEGER REFERENCES Athlete(Id) ON DELETE CASCADE,
    SportId INTEGER REFERENCES Sport(Id) ON DELETE CASCADE,
    PRIMARY KEY (AthleteId, SportId)
);


CREATE TABLE Hotel (
    Id SERIAL PRIMARY KEY,
    HotelName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL
);


CREATE TABLE Rooms (
    Id SERIAL PRIMARY KEY,
    HotelId INTEGER REFERENCES Hotel(Id) ON DELETE CASCADE,
    Name VARCHAR(255) NOT NULL,
    Capacity INTEGER NOT NULL
);


CREATE TABLE PlacingAthlete (
    Id SERIAL PRIMARY KEY,
    AthleteId INTEGER REFERENCES Athlete(Id) ON DELETE CASCADE,
    RoomId INTEGER REFERENCES Rooms(Id) ON DELETE CASCADE,
    PlacingDate DATE NOT NULL,
    UnplacingDate DATE
);

INSERT INTO AthleteClass (Name) VALUES 
('Любитель'),
('Профессионал'),
('Мастер спорта');


INSERT INTO Sport (Name) VALUES 
('Футбол'),
('Баскетбол'),
('Теннис'),
('Хоккей'),
('Волейбол');

INSERT INTO Athlete (FirstName, LastName, FatherName, Class) VALUES 
('Иван', 'Иванов', 'Иванович', 1),
('Петр', 'Петров', 'Сергеевич', 2),
('Сергей', 'Сергеев', 'Александрович', 3),
('Анна', 'Антонова', 'Викторовна', 1),
('Ольга', 'Ольгина', 'Фёдоровна', 2);


INSERT INTO Athlete_Sport (AthleteId, SportId) VALUES 
(1, 1), -- Иван играет в футбол
(1, 2), -- Иван играет в баскетбол
(2, 3), -- Петр играет в теннис
(3, 4), -- Сергей играет в хоккей
(4, 1), -- Анна играет в футбол
(5, 5); -- Ольга играет в волейбол

INSERT INTO Hotel (HotelName, Address) VALUES 
('Гранд Отель', 'Улица Ленина, 1'),
('Премьер Отель', 'Проспект Победы, 25');



INSERT INTO Rooms (HotelId, Name, Capacity) VALUES 
(1, '101', 2),
(1, '102', 3),
(1, '103', 1),
(2, '201', 4),
(2, '202', 2);


INSERT INTO PlacingAthlete (AthleteId, RoomId, PlacingDate, UnplacingDate) VALUES 
(1, 1, '2024-12-01', '2024-12-05'), -- Иван в комнате 101
(2, 2, '2024-12-02', NULL),         -- Петр в комнате 102
(3, 3, '2024-12-03', NULL),         -- Сергей в комнате 103
(4, 4, '2024-12-01', '2024-12-04'), -- Анна в комнате 201
(5, 5, '2024-12-02', '2024-12-06'); -- Ольга в комнате 202

SELECT * FROM Sport;
SELECT * FROM AthleteClass;
SELECT * FROM Athlete;
SELECT * FROM Athlete_Sport;
SELECT * FROM Hotel;
SELECT * FROM Rooms;
SELECT * FROM PlacingAthlete;



