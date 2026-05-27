create database project;
use project;
drop table accommodation;
drop table evaluates;
drop table event_organizer;
drop table eventt;
drop table judge;
drop table organizes;
drop table participant;
drop table rules;
drop table score;
drop table sponsor;
drop table team;
drop table teamregistersfor;
drop table venue;
drop table particregistersfor;
drop table sponsorshippackage;
drop table user;
drop table payment;

SELECT * FROM SponsorshipPackage;
SELECT * FROM SponsorshipPackage WHERE Pack_id = 4;

create table User
( U_id int not null primary key auto_increment,
  UName varchar(100) not null,
  Email varchar(100),
  Address varchar(100) not null, 
  Role varchar(70),
  PhoneNo varchar(15),
  J_id int,
  S_id int, 
  P_id int, 
  Org_id int, 
  Foreign key(J_id) References Judge(J_id),
  Foreign key(S_id) References Sponsor(S_id),
  Foreign key(P_id) References Participant(P_id),
  Foreign key(Org_id) References Event_Organizer(Org_id));

drop table User

  
create table Sponsor
( S_id int not null primary key auto_increment,
  Payment_status enum('True', 'False') not null,
  ContactPerson varchar(80),
  CompanyName varchar(100),
  SponsorType varchar(70),
  Pack_id int not null,
  Foreign key(Pack_id) References sponsorshippackage(Pack_id));

ALTER TABLE Sponsor MODIFY COLUMN S_id INT NOT NULL AUTO_INCREMENT;
drop table sponsor
INSERT INTO Sponsor VALUES

create table SponsorshipPackage
( Pack_id int not null primary key,
  Cost float,
  PackName varchar(100),
  Benefits varchar(100));
  
drop table sponsorshippackage
      
INSERT INTO SponsorshipPackage VALUES
(1, 500000, 'Platinum', 'Booth + Presentation Slot + Logo'),
(2, 300000, 'Gold', 'Booth + Logo Display'),
(4, 150000, 'Silver', 'Logo Display'),
(5, 75000, 'Bronze', 'Mention in brochure');

create table Payment
( Pay_id int not null primary key auto_increment,
  Amount float,
  PayMethod varchar(100),
  PayDate Date,
  S_id int,
  P_id int,
  Foreign key(S_id) References Sponsor(S_id),
  Foreign key(P_id) References Participant(P_id));
  
drop table payment
	
INSERT INTO Payment VALUES
(1, 100000, 'Bank Transfer', '2025-03-15', 1, 1),
(2, 80000, 'Cash', '2025-03-16', 2, 2),
(3, 150000, 'Online', '2025-03-17', 3, 3),
(4, 110000, 'Bank Transfer', '2025-03-18', 4, 4),
(5, 30000, 'Cash', '2025-03-19', 5, 5),
(6, 120000, 'Bank Transfer', '2025-03-20', 6, 6);

create table Participant
( P_id int not null primary key auto_increment,
  UniversityName varchar(100),
  PType varchar(80),
  A_id int,
  T_id int,
  Foreign key(A_id) References Accommodation(A_id),
  Foreign key(T_id) References Team(T_id));
ALTER TABLE Team MODIFY COLUMN T_id INT NOT NULL AUTO_INCREMENT;
SHOW CREATE TABLE Participant;

drop table participant

ALTER TABLE Participant MODIFY COLUMN P_id INT NOT NULL AUTO_INCREMENT;
INSERT INTO Participant VALUES
(1, 'UET Lahore', 'Leader', 1, 1),
(2, 'FAST', 'Member', 2, 1),
(3, 'NUST', 'Leader', 3, 2),
(4, 'COMSATS', 'Member', 4, 2),
(5, 'LUMS', 'Leader', 5, 3),
(6, 'FAST', 'Member', 6, 3),
(7, 'IBA', 'Leader', 7, 4),
(8, 'GIKI', 'Member', 8, 4),
(9, 'FAST', 'Leader', 9, 5),
(10, 'NUST', 'Member', 10, 5);

create table Accommodation
( A_id int not null primary key,
  Availability varchar(50),
  Cost float,
  RoomNo varchar(50),
  NoPeople int);
      
INSERT INTO Accommodation VALUES
(1, 'Yes', 2500, 'R-101', 2),
(2, 'Yes', 2000, 'R-102', 2),
(3, 'No', 1500, 'R-103', 1),
(4, 'Yes', 2200, 'R-104', 2),
(5, 'No', 1800, 'R-105', 1),
(6, 'Yes', 2300, 'R-106', 3),
(7, 'Yes', 2400, 'R-107', 3),
(8, 'No', 1900, 'R-108', 1),
(9, 'Yes', 2100, 'R-109', 2),
(10, 'Yes', 2500, 'R-110', 2);

create table Team
( T_id int not null primary key auto_increment);
  
  
ALTER TABLE Team
DROP COLUMN TName;

drop table user
drop table team
drop table participant


create table Judge
( J_id int not null primary key auto_increment,
  Expertise varchar(100));
  
INSERT INTO Judge VALUES
(1, 'Cyber Security'),
(2, 'Data Science'),
(3, 'Software Engineering'),
(4, 'Literature'),
(5, 'Game Development'),
(6, 'Robotics'),
(7, 'Culinary Arts'),
(8, 'AI Research'),
(9, 'Public Speaking'),
(10, 'Drama & Theatre');

	 
create table Score
( Sc_id int not null primary key auto_increment,
  SValue float,
  Remarks varchar(100),
  J_id int,
  Foreign key(J_id) References Judge(J_id));

INSERT INTO Score VALUES
(1, 95, 'Outstanding', 1),
(2, 88, 'Great work', 2),
(3, 77, 'Good effort', 3),
(4, 90, 'Excellent performance', 4),
(5, 70, 'Decent', 5),
(6, 84, 'Solid', 6),
(7, 60, 'Average', 7),
(8, 92, 'Top class', 8),
(9, 86, 'Persuasive', 9),
(10, 89, 'Impressive', 10);

create table Venue
( V_id int not null primary key,
  VenueType varchar(100),
  VenueName varchar(100),
  Location  varchar(100),
  Capacity int,
  Availability varchar(50));
  
INSERT INTO Venue VALUES
(1, 'Classroom', 'A-303', 'FAST NUCES Islamabad', 50, 'Available'),
(2, 'Classroom', 'A-205', 'FAST NUCES Islamabad', 50, 'Available'),
(3, 'Classroom', 'B-105', 'FAST NUCES Islamabad', 60, 'Available'),
(4, 'Classroom', 'B-304', 'FAST NUCES Islamabad', 60, 'Available'),
(5, 'Classroom', 'C-404', 'FAST NUCES Islamabad', 70, 'Available'),
(6, 'Classroom', 'C-403', 'FAST NUCES Islamabad', 70, 'Available'),
(7, 'Lab', 'C-Rawal IV', 'FAST NUCES Islamabad', 40, 'Available'),
(8, 'Lab', 'Mehran I', 'FAST NUCES Islamabad', 45, 'Available'),
(9, 'Lab', 'Mehran II', 'FAST NUCES Islamabad', 45, 'Available'),
(10, 'Lab', 'C-Margalla I', 'FAST NUCES Islamabad', 40, 'Available'),
(11, 'Lab', 'C-Margalla II', 'FAST NUCES Islamabad', 40, 'Available'),
(12, 'Digital Lab', 'B-Digital', 'FAST NUCES Islamabad', 30, 'Available'),
(13, 'Ground', 'FSM Lawn', 'FAST NUCES Islamabad', 200, 'Available'),
(14, 'Ground', 'FSC Lawn', 'FAST NUCES Islamabad', 250, 'Available');

	 
create table Event_Organizer
( Org_id int not null primary key auto_increment,
  SocietyName varchar(100),
  Dept varchar(100));
  
INSERT INTO Event_Organizer VALUES
(1, 'Fin-Tech Society', 'Management Sciences'),
(2, 'FAST Data Science Society', 'Computer Science'),
(3, 'Cyber Security Club', 'Computer Science'),
(4, 'Culinary Society', 'Social Sciences'),
(5, 'Literary Society', 'Humanities'),
(6, 'Gaming Club', 'Computer Science'),
(7, 'FAST Dramatics Society', 'Media Studies'),
(8, 'Robotics Club', 'Electrical Engineering'),
(9, 'Debating Society', 'Humanities'),
(10, 'AI Society', 'Computer Science');

       
create table Eventt
( Event_id int not null primary key auto_increment,
  Ename varchar(100),
  MaxParticipants int,
  RegFee float,
  EventDesc varchar(300),
  EventDate date,
  EventTime time,
  V_id int,
  Foreign key(V_id) References Venue(V_id));
  
INSERT INTO Eventt VALUES
(1, 'AI Hackathon', 120, 1000.0, 'A coding marathon focused on building AI-powered solutions.', '2025-04-01', '09:00:00', 7),
(2, 'Web Dev', 150, 1500.0, 'Interactive sessions and workshops on modern web development technologies.', '2025-04-05', '10:00:00', 1),
(3, 'GenAI Masterpiece', 100, 500.0, 'A challenge to create creative applications using Generative AI tools.', '2025-04-10', '11:00:00', 8),
(4, 'Edathon', 80, 700.0, 'An educational-themed CTF (Capture the Flag) cybersecurity competition.', '2025-04-15', '12:00:00', 10),
(5, 'Entrepreneurial Venture', 60, 300.0, 'A pitch competition for aspiring entrepreneurs to present startup ideas.', '2025-04-20', '14:00:00', 13),
(6, 'Business Scavenger Hunt', 100, 200.0, 'A fun-filled event exploring business clues across the campus.', '2025-04-25', '16:00:00', 4),
(7, 'Case Quest', 80, 1200.0, 'A case study competition where teams solve real-world business problems.', '2025-05-01', '09:00:00', 9),
(8, 'Crypto', 200, 250.0, 'An event exploring blockchain, cryptocurrency, and decentralized tech.', '2025-05-05', '17:00:00', 14),
(9, 'Squid Bizz', 90, 800.0, 'Business games inspired by survival-based decision making challenges.', '2025-05-10', '13:00:00', 6),
(10, 'NaSCon FIFA Frenzy', 120, 400.0, 'A high-energy FIFA gaming tournament with knockout rounds.', '2025-05-15', '10:00:00', 2),
(11, 'Tekken Iron Fist Championship', 110, 1100.0, 'A competitive Tekken tournament showcasing top fighters.', '2025-05-20', '11:30:00', 5),
(12, 'NaSCon Valo Showdown', 110, 1100.0, 'An eSports event featuring Valorant team battles.', '2025-05-20', '11:30:00', 5),
(13, 'NasCon Got Talent', 110, 1100.0, 'Talent show featuring music, dance, comedy, and other performances.', '2025-05-20', '11:30:00', 5),
(14, 'Bait Baazi', 110, 1100.0, 'A poetic contest where participants recite and build upon Urdu verses.', '2025-05-20', '11:30:00', 5),
(15, 'Dish It Out', 110, 1100.0, 'A culinary competition where participants prepare signature dishes.', '2025-05-20', '11:30:00', 5),
(16, 'Battle of the Bands', 110, 1500.0, 'Live music competition featuring local bands competing for the top spot.', '2025-05-20', '11:30:00', 5);




create table Rules
( Event_id int not null auto_increment,
  Rule varchar(150) not null,
  primary key(Event_id, Rule),
  Foreign key(Event_id) References Eventt(Event_id));
  
INSERT INTO Rules VALUES
(1, 'Each team must have max 4 members'),
(2, 'No plagiarism allowed'),
(3, 'Devices must be approved by organizers'),
(4, 'Only vegetarian food allowed'),
(5, 'Mic must be used during poetry'),
(6, 'Teams must present their game live'),
(7, 'No external help during CTF'),
(8, 'No use of AI writing tools in debate'),
(9, 'Robot size must not exceed 2ft'),
(10, 'Slides are mandatory for data cases'),
(11, 'Use of open source only');


create table Organizes
( Org_id int not null auto_increment,
  Event_id int not null,
  primary key(Org_id, Event_id),
  Foreign key(Org_id) References Event_Organizer(Org_id),
  Foreign key(Event_id) References Eventt(Event_id));

INSERT INTO Organizes (Org_id, Event_id) VALUES
(1, 1), -- Nida Aslam organizes Data Battle Royale
(2, 2), -- Ali Raza organizes Hack-a-Fest
(3, 1), -- Taimoor Javed organizes Data Battle Royale
(2, 3), -- Ali Raza organizes Cyber Olympiad
(1, 2), -- Nida Aslam organizes Hack-a-Fest
(4, 1), -- Shiza Tariq organizes Data Battle Royale
(4, 3); -- Shiza Tariq organizes Cyber Olympiad
  
create table ParticRegistersFor
( P_id int not null auto_increment,
  Event_id int not null,
  primary key(P_id, Event_id),
  Foreign key(P_id) References Participant(P_id),
  Foreign key(Event_id) References Eventt(Event_id));
  
drop table particregistersfor

create table TeamRegistersFor
( T_id int not null auto_increment,
  Event_id int not null,
  primary key(T_id, Event_id),
  Foreign key(T_id) References Team(T_id),
  Foreign key(Event_id) References Eventt(Event_id));
  
drop table teamregistersfor


create table Evaluates
( J_id int not null auto_increment,
  Event_id int not null,
  primary key(J_id, Event_id),
  Foreign key(J_id) References Judge(J_id),
  Foreign key(Event_id) References Eventt(Event_id));
  
INSERT INTO Evaluates VALUES
(1, 4), (2, 11), (3, 3), (4, 6), (5, 7),
(6, 9), (7, 5), (8, 2), (9, 10), (10, 8);

select * from participant
select * from ParticRegistersFor
select * from team
select * from TeamRegistersFor
select * from sponsor
select * from payment
select * from user

  SHOW CREATE TABLE Sponsor;
ALTER TABLE Participant DROP FOREIGN KEY T_id;
ALTER TABLE Team DROP FOREIGN KEY T_id;
ALTER TABLE teamregistersfor DROP FOREIGN KEY T_id;
ALTER TABLE Participant DROP FOREIGN KEY T_id;
-- Repeat for any other referencing tables

ALTER TABLE Participant
  ADD CONSTRAINT fk_participant_team
  FOREIGN KEY (T_id) REFERENCES Team(T_id);

