IF DB_ID('RaceDayDB') IS NULL
BEGIN
    CREATE DATABASE RaceDayDB;
END;
GO

USE RaceDayDB;
GO

-- Drop tables in dependency order
DROP TABLE IF EXISTS Results;
DROP TABLE IF EXISTS Enrolments;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS EventTypes;
DROP TABLE IF EXISTS Users;
GO

CREATE TABLE Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(120) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL,
    Phone NVARCHAR(20) NULL,
    DateOfBirth DATE NULL,
    ProfilePictureUrl NVARCHAR(500) NULL,

    CONSTRAINT CK_Users_Role CHECK (Role IN ('Organiser', 'Participant'))
);
GO

CREATE TABLE EventTypes
(
    EventTypeId INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(20) NOT NULL UNIQUE
);
GO

CREATE TABLE EVENTS
(
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId INT NOT NULL,
    EventTypeId INT NOT NULL,
    Name NVARCHAR(120) NOT NULL,
    Description NVARCHAR(1000) NULL,
    EventDate DATE NOT NULL,
    Location NVARCHAR(150) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    BannerImageUrl NVARCHAR(500) NULL,

    CONSTRAINT CK_Events_Distance CHECK (DistanceKm > 0),
    CONSTRAINT FK_Events_Organiser
        FOREIGN KEY (OrganiserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Events_EventType
        FOREIGN KEY (EventTypeId) REFERENCES EventTypes(EventTypeId)
);
GO

CREATE TABLE Categories
(
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryName NVARCHAR(80) NOT NULL,
    Description NVARCHAR(250) NULL,

    CONSTRAINT UQ_Categories_Event_Category UNIQUE (EventId, CategoryName),
    CONSTRAINT FK_Categories_Event
        FOREIGN KEY (EventId) REFERENCES Events(EventId)
);
GO

CREATE TABLE Enrolments
(
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL,
    EventId INT NOT NULL,
    CategoryId INT NOT NULL,
    EnrolmentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL DEFAULT 'Confirmed',

    CONSTRAINT UQ_Enrolments_Participant_Event UNIQUE (ParticipantId, EventId),
    CONSTRAINT CK_Enrolments_Status CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
    CONSTRAINT FK_Enrolments_Participant
        FOREIGN KEY (ParticipantId) REFERENCES Users(UserId),
    CONSTRAINT FK_Enrolments_Event
        FOREIGN KEY (EventId) REFERENCES Events(EventId),
    CONSTRAINT FK_Enrolments_Category
        FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
GO

CREATE TABLE Results
(
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL UNIQUE,
    FinishTime TIME(0) NOT NULL,
    FinishPosition INT NOT NULL,
    Published BIT NOT NULL DEFAULT 0,

    CONSTRAINT CK_Results_Position CHECK (FinishPosition > 0),
    CONSTRAINT FK_Results_Enrolment
        FOREIGN KEY (EnrolmentId) REFERENCES Enrolments(EnrolmentId)
);
GO

-- Seed data
INSERT INTO EventTypes (TypeName)
VALUES ('Run'), ('Walk'), ('Cycle');
GO

INSERT INTO Users
    (FirstName, LastName, Email, PasswordHash, Role, Phone, DateOfBirth)
VALUES
    ('Thabo', 'Mokoena', 'thabo.organiser@example.com', 'PART1_HASH_001', 'Organiser', '0710000001', '1990-05-12'),
    ('Lerato', 'Nkosi', 'lerato.organiser@example.com', 'PART1_HASH_002', 'Organiser', '0720000002', '1988-11-03'),
    ('Sipho', 'Dlamini', 'sipho.participant@example.com', 'PART1_HASH_003', 'Participant', '0730000003', '2004-02-18'),
    ('Amahle', 'Naidoo', 'amahle.participant@example.com', 'PART1_HASH_004', 'Participant', '0740000004', '2003-08-27');
GO

INSERT INTO Events
    (OrganiserId, EventTypeId, Name, Description, EventDate, Location, DistanceKm)
VALUES
    (1, 1, 'Soweto Community Run', 'Community road running event with 10 km and 21 km options.',
     '2026-10-10', 'Soweto, Gauteng', 10.00),
    (2, 2, 'Cape Town Charity Walk', 'Charity walking event for local community organisations.',
     '2026-11-01', 'Cape Town, Western Cape', 8.00),
    (1, 3, 'Durban Coastal Cycle', 'Road cycling event along the Durban coastal route.',
     '2026-11-21', 'Durban, KwaZulu-Natal', 40.00);
GO

INSERT INTO Categories (EventId, CategoryName, Description)
VALUES
    (1, 'Under 20', 'Participants younger than 20 years.'),
    (1, 'Senior', 'Adult participants in the senior category.'),
    (1, '10km', 'Ten kilometre race category.'),
    (1, '21km', 'Twenty-one kilometre race category.'),
    (2, 'General', 'General charity walking category.'),
    (2, 'Senior Walk', 'Senior walking category.'),
    (3, '40km Open', 'Open 40 kilometre cycling category.'),
    (3, '40km Junior', 'Junior 40 kilometre cycling category.');
GO

INSERT INTO Enrolments
    (ParticipantId, EventId, CategoryId, Status)
VALUES
    (3, 1, 3, 'Confirmed'),
    (4, 1, 4, 'Confirmed'),
    (3, 2, 5, 'Confirmed'),
    (4, 3, 7, 'Pending');
GO

INSERT INTO Results
    (EnrolmentId, FinishTime, FinishPosition, Published)
VALUES
    (1, '00:58:32', 47, 1),
    (2, '01:49:10', 112, 1);
GO

-- Basic verification queries.
SELECT * FROM Users;
SELECT * FROM EventTypes;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Enrolments;
SELECT * FROM Results;
GO