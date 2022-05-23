CREATE SCHEMA `heroesdiary` DEFAULT CHARACTER SET utf8;

use `heroesdiary`;

CREATE TABLE `ComplaintTypes` (
  `Id` int not null AUTO_INCREMENT,
  `Name` varchar(100) not null, 
Primary key (`Id`)
);

CREATE TABLE `ComplaintReasones` (
  `Id` int not null AUTO_INCREMENT,
  `Name` varchar(200) not null, 
Primary key (`Id`)
);

CREATE TABLE `LocationMapes` (
  `Id` int not null AUTO_INCREMENT,
  `Name` varchar(100) not null, 
Primary key (`Id`)
);

CREATE TABLE `ComplaintStatuses` (
  `Id` int not null AUTO_INCREMENT,
  `Name` varchar(100) not null, 
Primary key (`Id`)
);

CREATE TABLE `User` (
  `Id` int not null AUTO_INCREMENT,
  `Nickname` varchar(20) not null,
  `DateOfBirth` date,
  `Email` varchar(129) not null,
  `Password` varchar(32) not null,
  `AvatarInformation` varchar(4000) not null,
  `AvatarImage` blob default null,
  `Blocked` boolean not null default false,
  `Moderator` boolean not null default false,
  `Admin` boolean not null default false,
  `LocationMapId` int not null,
Primary key (`Id`),
FOREIGN KEY (`LocationMapId`) REFERENCES `LocationMapes`(`Id`)
);

CREATE TABLE `Blacklist` (
  `UserId` int not null,
  `BlacklistedUserId` int not null,
Primary key (`UserId`, `BlacklistedUserId`),
  FOREIGN KEY (`BlacklistedUserId`) REFERENCES `User`(`Id`),
  FOREIGN KEY (`UserId`) REFERENCES `User`(`Id`)
);

CREATE TABLE `Article` (
  `Id` int not null AUTO_INCREMENT,
  `CreationTime`date not null,
  `Text` varchar(4000) not null,
  `Image` blob default null,
  `IdAuthor` int not null,
  `Blocked` boolean not null default false,
  `Deleted` boolean not null default false,
Primary key (`Id`),
  FOREIGN KEY (`IdAuthor`) REFERENCES `User`(`Id`)
);

CREATE TABLE `Comment` (
  `Id` int not null AUTO_INCREMENT,
  `ArticleId` int not null,
  `UserId` int not null,
  `CreationTime` datetime not null,
  `Text` varchar(4000) not null,
Primary key (`Id`),
  FOREIGN KEY (`ArticleId`) REFERENCES `Article`(`Id`),
  FOREIGN KEY (`UserId`) REFERENCES `User`(`Id`)
);

CREATE TABLE `Like` (
  `ArticleId` int not null,
  `UserId` int not null,
Primary key (`ArticleId`, `UserId`),
  FOREIGN KEY (`ArticleId`) REFERENCES `Article`(`Id`),
  FOREIGN KEY (`UserId`) REFERENCES `User`(`Id`)
);

CREATE TABLE `Complaint` (
  `Id` int not null AUTO_INCREMENT,
  `ComplaintTypeId` int not null,
  `SenderComplaintId` int not null,
  `ComplaintRecieverId` int not null,
  `ArticleId` int not null,
  `CreationTime` datetime not null,
  `ReasonId` int not null,
  `TextComplaint` varchar(1000) not null,
  `StatusId` int not null,
  `AdminId` int not null,
Primary key (`Id`),
  FOREIGN KEY (`StatusId`) REFERENCES `ComplaintStatuses`(`Id`),
  FOREIGN KEY (`ReasonId`) REFERENCES `ComplaintReasones`(`Id`),
  FOREIGN KEY (`ArticleId`) REFERENCES `Article`(`Id`),
  FOREIGN KEY (`ComplaintRecieverId`) REFERENCES `User`(`Id`),
  FOREIGN KEY (`ComplaintTypeId`) REFERENCES `ComplaintTypes`(`Id`),
  FOREIGN KEY (`SenderComplaintId`) REFERENCES `User`(`Id`),
  FOREIGN KEY (`AdminId`) REFERENCES `User`(`Id`)
);

CREATE TABLE `Chat` (
  `Id` int not null AUTO_INCREMENT,
  `User1Id` int not null,
  `User2Id` int not null,
  `HiddenFromUser1` boolean not null default false,
  `NotificationsDisabled` boolean not null default false,
Primary key (`Id`),
  FOREIGN KEY (`User2Id`) REFERENCES `User`(`Id`),
  FOREIGN KEY (`User1Id`) REFERENCES `User`(`Id`)
);

CREATE TABLE `Message` (
  `Id` int not null AUTO_INCREMENT,
  `CreationTime` datetime not null,
  `SenderId` int not null,
  `ChatId` int not null,
  `MessageText` varchar(1000) not null,
  `Deleted` boolean not null default false,
  `DeleteTime` datetime default null,
  `HiddenFromReciever` int not null,
  `HiddenFromSender` int not null,
  `Image`  blob default null,
Primary key (`Id`),
  FOREIGN KEY (`SenderId`) REFERENCES `User`(`Id`),
  FOREIGN KEY (`ChatId`) REFERENCES `Chat`(`Id`)
);

CREATE TABLE `Friends` (
  `User1Id` int not null,
  `User2Id` int not null,
Primary key (`User1Id`,  `User2Id`),
  FOREIGN KEY (`User1Id`) REFERENCES `User`(`Id`),
  FOREIGN KEY (`User2Id`) REFERENCES `User`(`Id`)
);
