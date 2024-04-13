CREATE DATABASE Magic;
USE Magic;

CREATE TABLE Users (
    User_id int NOT NULL PRIMARY KEY,
    FirstName TEXT NOT NULL,
    MiddleName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email varchar(50) NOT NULL,
    Phone int(10) NOT NULL,
    BirthDate DATETIME NOT NULL

);

CREATE TABLE Articles (
    Article_id int NOT NULL PRIMARY KEY,
    Title varchar(30) NOT NULL,
    User_id int NOT NULL,
    Content TEXT NOT NULL,
    UploadDate DATETIME NOT NULL,

    CONSTRAINT userArticle
        FOREIGN KEY (User_id)
    REFERENCES Users (User_id)
    ON UPDATE cascade ON DELETE cascade

);

CREATE TABLE Comments (
  Comment_id int PRIMARY KEY NOT NULL,
  CONTENT TEXT NOT NULL,
  Article_id int NOT NULL,


    CONSTRAINT commentArticle
        FOREIGN KEY (Article_id)
            REFERENCES Articles (Article_id)
            ON UPDATE cascade
            ON DELETE cascade

);

CREATE TABLE Tags (
  Tag_id int PRIMARY KEY,
  TagName varchar(50) NOT NULL
);

CREATE TABLE ArticleTags (
  Article_id int NOT NULL,
  Tag_id int  NOT NULL,
  PRIMARY KEY(Article_id, Tag_id),

    CONSTRAINT articleTagTag
        FOREIGN KEY (Tag_id)
    REFERENCES Tags (Tag_id)
    ON UPDATE cascade ON DELETE cascade,

    CONSTRAINT ArticleTagArticle
            FOREIGN KEY (Article_id)
            REFERENCES Articles (Article_id)
            ON UPDATE cascade
            ON DELETE cascade

);


CREATE TABLE Accounts (
    Account_id int NOT NULL PRIMARY KEY,
    Balance int NOT NULL,
    AccountType varchar(50),
    Date_created DATETIME NOT NULL

);


CREATE TABLE AccountInfo(
  User_id int NOT NULL,
  Account_id int NOT NULL,
  PRIMARY KEY(User_id, Account_id),

    CONSTRAINT accountInfoUser
            FOREIGN KEY (User_id)
            REFERENCES Users (User_id)
            ON UPDATE cascade
            ON DELETE cascade,
    CONSTRAINT AccountInfoAccountID
            FOREIGN KEY (Account_id)
            REFERENCES Accounts (Account_id)
            ON UPDATE cascade
            ON DELETE cascade


);

CREATE TABLE Categories (
    Category_id int NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Goals (
    Goal_id int NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Date DATETIME NOT NULL,
    TotalFund double NOT NULL,
    SavedSoFar double NOT NULL
);

CREATE TABLE Transactions (
    Transaction_id int NOT NULL PRIMARY KEY,
    Category_id int NOT NULL,
    Account_id int NOT NULL,
    Amount double NOT NULL,
    Goal_id int,
    Date DATETIME NOT NULL,
    Description TEXT NOT NULL,

    CONSTRAINT transactionCategoryID
            FOREIGN KEY (Category_id)
            REFERENCES Categories (Category_id)
            ON UPDATE cascade
            ON DELETE cascade,
        CONSTRAINT transactionAccountID
            FOREIGN KEY (Account_id)
            REFERENCES Accounts (Account_id)
            ON UPDATE cascade
            ON DELETE cascade,
        CONSTRAINT transactionGoal
            FOREIGN KEY (Goal_id)
            REFERENCES Goals (Goal_id)
            ON UPDATE cascade
            ON DELETE cascade
);



CREATE TABLE Budgets (
    Budget_id int NOT NULL PRIMARY KEY,
    MaxAmount double NOT NULL,
    AccountID int NOT NULL,
    MinRemaining double NOT NULL,
    CategoryID int NOT NULL,
    Remaining double NOT NULL,
    Spent double NOT NULL,
    MadeFor varchar(30) NOT NULL,

    CONSTRAINT budgetAccount
        FOREIGN KEY (AccountID)
            REFERENCES Accounts (Account_id)
            ON UPDATE cascade
            ON DELETE cascade,
    CONSTRAINT budgetCategory
        FOREIGN KEY (CategoryID)
        REFERENCES Categories (Category_id)
            ON UPDATE cascade
            ON DELETE cascade
);

CREATE TABLE Bills (
    Bill_id int NOT NULL PRIMARY KEY,
    DueBy DATETIME NOT NULL,
    Description varchar(50) NOT NULL,
    Account_id int NOT NULL,
    Budget_id int NOT NULL,

    CONSTRAINT billAccount
        FOREIGN KEY (Account_id)
        REFERENCES Accounts (Account_id)
            ON UPDATE cascade
            ON DELETE cascade,
    CONSTRAINT billBudget
        FOREIGN KEY (Budget_id)
        REFERENCES Budgets (Budget_id)
            ON UPDATE cascade
            ON DELETE cascade

);

CREATE TABLE Investments (
    Investment_id int NOT NULL PRIMARY KEY,
    Account_id int NOT NULL,
    Type  varchar(50) NOT NULL,
    Amount double NOT NULL,
    Description TEXT NOT NULL,
    Date DATETIME NOT NULL,

    CONSTRAINT investmentAccount
                FOREIGN KEY (Account_id)
                REFERENCES Accounts (Account_id)
                ON UPDATE cascade
                ON DELETE cascade
);

CREATE TABLE Portfolios (
    Portfolio_id int NOT NULL PRIMARY KEY,
    name varchar(50) NOT NULL,
    Description TEXT NOT NULL
);

CREATE TABLE Investment_Type (
    InvestmentID int NOT NULL,
    PortfolioID int NOT NULL,
    PRIMARY KEY (InvestmentID, PortfolioID),

    CONSTRAINT investmentTypeInvestment
        FOREIGN KEY (InvestmentID)
        REFERENCES Investments (Investment_id)
            ON UPDATE cascade
            ON DELETE cascade,
    CONSTRAINT investmentTypePortfolio
        FOREIGN KEY (PortfolioID)
        REFERENCES Portfolios (Portfolio_id)
            ON UPDATE cascade
            ON DELETE cascade
);

insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (1, 'Sutton', 'Duddy', 'Marsden', 'smarsden0@typepad.com', '941-211-8778', '11/18/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (2, 'Sylvia', 'Ransbury', 'Goneau', 'sgoneau1@infoseek.co.jp', '425-295-9041', '8/11/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (3, 'Yovonnda', 'Crumpton', 'Klinck', 'yklinck2@mayoclinic.com', '653-882-3329', '8/18/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (4, 'Rosette', 'Carlin', 'Campey', 'rcampey3@samsung.com', '667-962-6757', '7/13/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (5, 'Gavra', 'Berfoot', 'Groome', 'ggroome4@delicious.com', '630-153-6846', '11/9/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (6, 'Eduino', 'Dyball', 'Drane', 'edrane5@pcworld.com', '756-642-7398', '11/4/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (7, 'Selby', 'Driscoll', 'Toretta', 'storetta6@altervista.org', '865-749-7454', '1/27/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (8, 'Dulcia', 'Moffett', 'Dillon', 'ddillon7@tuttocitta.it', '757-102-8296', '8/14/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (9, 'Charity', 'Rohlf', 'Gwinn', 'cgwinn8@freewebs.com', '609-961-9051', '5/12/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (10, 'Samaria', 'Casham', 'Skewes', 'sskewes9@uiuc.edu', '755-165-3063', '6/6/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (11, 'Camel', 'De Moreno', 'Wither', 'cwithera@booking.com', '824-754-9066', '1/24/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (12, 'Quentin', 'Kretchmer', 'Radcliffe', 'qradcliffeb@cisco.com', '571-387-0458', '5/14/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (13, 'Christabella', 'Dobel', 'Braunes', 'cbraunesc@yale.edu', '160-900-4015', '7/30/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (14, 'Cointon', 'Bartolozzi', 'Gamlen', 'cgamlend@state.tx.us', '122-845-7193', '11/2/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (15, 'Bili', 'Rylett', 'Vallow', 'bvallowe@godaddy.com', '628-296-6885', '4/5/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (16, 'Yuma', 'Stapforth', 'Shakesby', 'yshakesbyf@accuweather.com', '859-121-0757', '5/2/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (17, 'Denise', 'Chung', 'Rannells', 'drannellsg@tamu.edu', '702-198-8007', '3/31/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (18, 'Hadley', 'Pinard', 'Bracco', 'hbraccoh@people.com.cn', '667-203-9613', '8/22/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (19, 'Mira', 'Balducci', 'Tarrant', 'mtarranti@biblegateway.com', '797-661-0849', '10/17/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (20, 'Ariana', 'Swainston', 'Fruen', 'afruenj@mysql.com', '977-614-6693', '2/7/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (21, 'Aubrette', 'Plail', 'Bann', 'abannk@webmd.com', '161-693-6127', '7/8/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (22, 'Randell', 'Cardenosa', 'Errol', 'rerroll@eepurl.com', '384-246-6335', '7/18/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (23, 'Alfonse', 'Lamasna', 'Galletly', 'agalletlym@reference.com', '453-912-0238', '7/28/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (24, 'Alexa', 'Melding', 'Trew', 'atrewn@artisteer.com', '927-906-0901', '1/11/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (25, 'Mirelle', 'Senecaux', 'Letherbury', 'mletherburyo@livejournal.com', '437-415-0654', '5/18/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (26, 'Kris', 'Monsey', 'Perri', 'kperrip@symantec.com', '791-490-0005', '2/21/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (27, 'Lanny', 'Truin', 'Weafer', 'lweaferq@addthis.com', '355-352-2339', '12/2/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (28, 'Corrianne', 'Barz', 'Renault', 'crenaultr@youtube.com', '733-550-3897', '12/16/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (29, 'Katalin', 'Folling', 'Hartzogs', 'khartzogss@yahoo.co.jp', '646-889-5781', '9/2/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (30, 'Justin', 'Skyner', 'Tidbald', 'jtidbaldt@liveinternet.ru', '374-979-7581', '1/13/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (31, 'Liva', 'Indruch', 'Grimbleby', 'lgrimblebyu@bravesites.com', '179-373-5822', '3/29/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (32, 'Ashlin', 'Glawsop', 'Kerans', 'akeransv@w3.org', '488-512-9310', '1/14/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (33, 'Brant', 'Dugmore', 'Cockling', 'bcocklingw@dailymotion.com', '212-976-5984', '1/5/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (34, 'Petunia', 'Skurray', 'Gelardi', 'pgelardix@google.co.uk', '809-557-0761', '5/30/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (35, 'Julio', 'Briscoe', 'Smallridge', 'jsmallridgey@xing.com', '949-343-4081', '1/29/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (36, 'Jourdain', 'Moncrieffe', 'Abriani', 'jabrianiz@buzzfeed.com', '530-821-3493', '8/31/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (37, 'Liz', 'Kewley', 'McLevie', 'lmclevie10@wordpress.com', '662-594-8942', '11/4/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (38, 'Thibaud', 'Chester', 'Coultard', 'tcoultard11@walmart.com', '277-477-7823', '4/23/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (39, 'Murdoch', 'Goodier', 'Lenton', 'mlenton12@wsj.com', '128-948-8310', '4/17/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (40, 'Osgood', 'Harbage', 'Phillipp', 'ophillipp13@technorati.com', '383-346-9520', '4/26/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (41, 'Rosa', 'Mummery', 'Oleksiak', 'roleksiak14@trellian.com', '913-689-9180', '9/14/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (42, 'Mommy', 'Dilliway', 'Goudie', 'mgoudie15@biglobe.ne.jp', '119-828-5941', '6/6/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (43, 'Charmine', 'Cornock', 'Reyne', 'creyne16@mayoclinic.com', '919-994-3698', '8/26/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (44, 'Nicky', 'O''Fallon', 'Hanbury', 'nhanbury17@cbc.ca', '323-174-5102', '1/23/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (45, 'Teriann', 'Bernardez', 'Capineer', 'tcapineer18@github.io', '310-351-2975', '6/29/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (46, 'Ilyse', 'Pepper', 'Lonnon', 'ilonnon19@nifty.com', '913-865-8510', '4/1/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (47, 'Archibold', 'Foan', 'Toppas', 'atoppas1a@ihg.com', '642-207-6288', '9/1/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (48, 'Gillie', 'Manders', 'Benfell', 'gbenfell1b@purevolume.com', '693-381-6127', '6/14/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (49, 'Forester', 'Beves', 'Medlicott', 'fmedlicott1c@aol.com', '497-276-8952', '11/28/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (50, 'Christina', 'Gowdie', 'Dunwoody', 'cdunwoody1d@people.com.cn', '494-694-2514', '8/22/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (51, 'Ileana', 'Crookall', 'Aldie', 'ialdie1e@hhs.gov', '315-291-4950', '11/10/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (52, 'Kendricks', 'Worgen', 'Dalby', 'kdalby1f@bloglines.com', '318-486-0677', '1/26/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (53, 'Penelope', 'Sivorn', 'Dreakin', 'pdreakin1g@elegantthemes.com', '229-346-7151', '2/7/2024');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (54, 'Nobie', 'Coxon', 'Sherrum', 'nsherrum1h@163.com', '579-799-7722', '6/2/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (55, 'Leupold', 'Askie', 'Steuart', 'lsteuart1i@com.com', '323-539-1731', '6/30/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (56, 'Beverley', 'Gynne', 'Withull', 'bwithull1j@wordpress.org', '659-967-5362', '11/26/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (57, 'Meyer', 'Risen', 'Cussen', 'mcussen1k@msu.edu', '884-719-8604', '8/21/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (58, 'Sophronia', 'Colt', 'Blockey', 'sblockey1l@reference.com', '799-817-9807', '4/15/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (59, 'Edgard', 'Perrelli', 'Node', 'enode1m@google.co.uk', '668-549-4995', '12/26/2023');
insert into Users (User_id, FirstName, MiddleName, LastName, Email, Phone, BirthDate) values (60, 'Maren', 'Beedon', 'Clemmitt', 'mclemmitt1n@rambler.ru', '139-270-3959', '5/28/2023');


INSERT INTO Categories (Category_id, Name)
VALUES
(1, 'Groceries'),
(2, 'Utilities'),
(3, 'Rent'),
(4, 'Entertainment'),
(5, 'Transportation'),
(6, 'Healthcare'),
(7, 'Shopping'),
(8, 'Education'),
(9, 'Charity'),
(10, 'Home Improvement'),
(11, 'Electronics'),
(12, 'Pet Supplies'),
(13, 'Clothing'),
(14, 'Books and Media');

INSERT INTO Accounts (Account_id, Balance, AccountType, Date_created)
VALUES
(1, 4427, 'high interest', '4/12/2022'),
(2, 371, 'high interest', '12/9/2021'),
(3, 3171, 'checking', '4/20/2020'),
(4, 3135, 'investment', '5/27/2023'),
(5, 6210, 'investment', '1/23/2020'),
(6, 4902, 'online', '9/19/2023'),
(7, 4720, 'investment', '5/2/2020'),
(8, 1166, 'retirement', '2/17/2021'),
(9, 8297, 'high interest', '1/25/2022'),
(10, 8687, 'business', '2/26/2020'),
(11, 4497, 'business', '12/18/2020'),
(12, 8532, 'money market', '2/27/2024'),
(13, 2698, 'investment', '3/13/2023'),
(14, 1813, 'investment', '11/29/2023'),
(15, 8771, 'retirement', '11/20/2023'),
(16, 6906, 'online', '8/11/2021'),
(17, 1647, 'money market', '2/27/2020'),
(18, 8079, 'savings', '7/1/2021'),
(19, 9076, 'retirement', '2/9/2024'),
(20, 7625, 'savings', '2/7/2024'),
(21, 7543, 'retirement', '4/23/2021'),
(22, 9229, 'money market', '6/5/2023'),
(23, 5983, 'business', '12/16/2020'),
(24, 134, 'high interest', '2/22/2024'),
(25, 1827, 'online', '4/28/2022'),
(26, 6189, 'high interest', '6/1/2023'),
(27, 9073, 'online', '11/28/2019'),
(28, 7418, 'business', '10/15/2023'),
(29, 1674, 'high interest', '6/16/2023'),
(30, 840, 'retirement', '1/10/2024'),
(31, 2172, 'money market', '10/19/2020'),
(32, 1603, 'high interest', '11/20/2020'),
(33, 7013, 'student', '7/22/2021'),
(34, 4129, 'retirement', '2/28/2023'),
(35, 6784, 'savings', '6/10/2022'),
(36, 9185, 'online', '12/7/2021'),
(37, 2801, 'student', '3/28/2021'),
(38, 3309, 'money market', '12/28/2020'),
(39, 9786, 'investment', '2/20/2022'),
(40, 8740, 'retirement', '8/3/2022'),
(41, 826, 'savings', '9/22/2023'),
(42, 210, 'savings', '1/30/2021'),
(43, 9036, 'high interest', '8/7/2023'),
(44, 4723, 'business', '7/26/2021'),
(45, 2583, 'joint', '7/6/2020'),
(46, 2795, 'high interest', '3/29/2023'),
(47, 9158, 'high interest', '6/21/2023'),
(48, 7393, 'business', '10/6/2020'),
(49, 5203, 'student', '11/10/2021'),
(50, 642, 'student', '6/23/2021'),
(51, 8294, 'joint', '2/19/2023'),
(52, 9305, 'checking', '1/4/2022'),
(53, 3674, 'high interest', '7/11/2022'),
(54, 3482, 'high interest', '2/11/2021'),
(55, 3678, 'investment', '3/14/2023'),
(56, 9767, 'money market', '4/25/2022'),
(57, 1777, 'high interest', '4/5/2023'),
(58, 4565, 'online', '5/29/2021'),
(59, 9873, 'retirement', '12/21/2021'),
(60, 2336, 'investment', '8/8/2022');

INSERT INTO Goals (Goal_id, Name, Date, TotalFund, SavedSoFar)
VALUES
(1, 'child''s education fund', '5/3/2023', 492, 100),
(2, 'vintage collectibles', '7/25/2023', 511, 0),
(3, 'home down payment', '10/3/2023', 882, 0),
(4, 'vacation', '9/9/2023', 822, 0),
(5, 'concert tickets', '6/2/2023', 659, 360),
(6, 'spa day', '8/29/2023', 848, 0),
(7, 'home down payment', '12/2/2023', 884, 0),
(8, 'clothing haul', '10/25/2023', 603, 469),
(9, 'new car', '3/21/2024', 622, 0),
(10, 'concert tickets', '12/6/2023', 977, 0),
(11, 'vacation', '8/26/2023', 749, 0),
(12, 'new computer', '3/31/2024', 482, 141),
(13, 'wine tasting', '9/10/2023', 640, 0),
(14, 'spa day', '12/10/2023', 182, 134),
(15, 'new car', '12/10/2023', 312, 216),
(16, 'new pet', '12/7/2023', 552, 0),
(17, 'clothing haul', '2/22/2024', 588, 0),
(18, 'child''s education fund', '12/23/2023', 454, 430),
(19, 'kitchen renovation', '10/18/2023', 446, 306),
(20, 'gaming console', '5/29/2023', 679, 491),
(21, 'concert tickets', '1/30/2024', 492, 0),
(22, 'new pet', '2/13/2024', 921, 0),
(23, 'spa day', '12/10/2023', 290, 283),
(24, 'spa day', '12/5/2023', 428, 0),
(25, 'new stove', '1/6/2024', 736, 0),
(26, 'clothing haul', '4/14/2023', 753, 0),
(27, 'new car', '2/3/2024', 278, 0),
(28, 'home down payment', '3/10/2024', 897, 0),
(29, 'home down payment', '10/27/2023', 674, 0),
(30, 'new car', '5/1/2023', 986, 0),
(31, 'new stove', '8/17/2023', 894, 0),
(32, 'child''s education fund', '7/15/2023', 896, 0),
(33, 'vacation', '3/16/2024', 989, 0),
(34, 'new stove', '11/26/2023', 362, 116),
(35, 'new pet', '1/23/2024', 123, 71),
(36, 'vintage collectibles', '7/13/2023', 854, 0),
(37, 'new computer', '6/23/2023', 499, 304),
(38, 'vacation', '12/18/2023', 337, 279),
(39, 'new computer', '6/1/2023', 525, 0),
(40, 'home down payment', '4/6/2024', 877, 0),
(41, 'new stove', '9/8/2023', 561, 0),
(42, 'new computer', '7/16/2023', 991, 0),
(43, 'new pet', '8/15/2023', 430, 0),
(44, 'clothing haul', '1/25/2024', 117, 113),
(45, 'clothing haul', '7/27/2023', 315, 189),
(46, 'vacation', '6/21/2023', 207, 142),
(47, 'new pet', '7/10/2023', 282, 0),
(48, 'kitchen renovation', '5/30/2023', 708, 379),
(49, 'concert tickets', '7/1/2023', 920, 465),
(50, 'vacation', '12/7/2023', 511, 328),
(51, 'clothing haul', '5/7/2023', 618, 0),
(52, 'kitchen renovation', '8/25/2023', 260, 146),
(53, 'concert tickets', '7/20/2023', 859, 0),
(54, 'home down payment', '2/11/2024', 315, 0),
(55, 'kitchen renovation', '9/24/2023', 463, 0),
(56, 'new pet', '4/23/2023', 381, 298),
(57, 'home down payment', '5/16/2023', 774, 0),
(58, 'new car', '1/13/2024', 876, 0),
(59, 'new stove', '2/4/2024', 487, 356),
(60, 'gaming console', '1/31/2024', 395, 211);

INSERT INTO Investments (Investment_id, Type, Description, Date, Amount, Account_id)
VALUES
(1, 'stocks', 'Ownership shares in a company', '1/20/2024', 55, 19),
(2, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '9/12/2023', 392, 26),
(3, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '8/2/2023', 292, 49),
(4, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '2/20/2024', 518, 5),
(5, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '9/8/2023', 652, 4),
(6, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '5/25/2023', 861, 56),
(7, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '12/8/2023', 781, 26),
(8, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '6/19/2023', 917, 4),
(9, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '11/13/2023', 542, 46),
(10, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '7/23/2023', 434, 1),
(11, 'stocks', 'Ownership shares in a company', '1/22/2024', 876, 56),
(12, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '9/18/2023', 679, 49),
(13, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '9/27/2023', 244, 57),
(14, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '10/21/2023', 753, 25),
(15, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '2/19/2024', 545, 42),
(16, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '1/9/2024', 892, 38),
(17, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '11/13/2023', 871, 45),
(18, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '9/14/2023', 655, 53),
(19, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '3/20/2024', 632, 33),
(20, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '11/22/2023', 136, 19),
(21, 'stocks', 'Ownership shares in a company', '9/12/2023', 27, 60),
(22, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '1/17/2024', 871, 17),
(23, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '1/14/2024', 476, 11),
(24, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '3/30/2024', 619, 37),
(25, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '12/2/2023', 243, 41),
(26, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '6/30/2023', 481, 30),
(27, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '9/19/2023', 164, 6),
(28, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '3/30/2024', 202, 30),
(29, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '2/29/2024', 98, 8),
(30, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '7/11/2023', 372, 25),
(31, 'stocks', 'Ownership shares in a company', '8/7/2023', 22, 41),
(32, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '11/13/2023', 882, 18),
(33, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '11/23/2023', 713, 55),
(34, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '6/11/2023', 167, 15),
(35, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '4/12/2023', 155, 29),
(36, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '3/26/2024', 848, 28),
(37, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '12/22/2023', 22, 7),
(38, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '8/29/2023', 338, 3),
(39, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '7/19/2023', 223, 58),
(40, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '7/11/2023', 665, 27),
(41, 'stocks', 'Ownership shares in a company', '12/8/2023', 394, 10),
(42, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '8/20/2023', 3, 47),
(43, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '12/21/2023', 289, 12),
(44, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '9/9/2023', 976, 50),
(45, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '8/1/2023', 649, 54),
(46, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '10/12/2023', 388, 51),
(47, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '1/25/2024', 605, 45),
(48, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '1/1/2024', 72, 46),
(49, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '11/4/2023', 890, 16),
(50, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '4/11/2024', 255, 24),
(51, 'stocks', 'Ownership shares in a company', '7/19/2023', 215, 60),
(52, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '4/26/2023', 686, 44),
(53, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '7/8/2023', 557, 40),
(54, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '6/25/2023', 142, 25),
(55, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '10/13/2023', 949, 4),
(56, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '10/2/2023', 777, 38),
(57, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '1/24/2024', 594, 30),
(58, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '4/19/2023', 804, 13),
(59, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '9/11/2023', 773, 11),
(60, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '6/18/2023', 575, 36);

INSERT INTO Portfolios (Portfolio_id, Name, Description)
VALUES
(1, 'Steady Growth Portfolio', 'A portfolio focused on steady consistent growth with low volatility'),
(2, 'Income Builder Portfolio', 'Designed to generate regular income through dividends or interest payments'),
(3, 'Diversified Holdings Portfolio', 'Invests in a wide range of asset classes to minimize risk'),
(4, 'Freedom Fund', 'Aimed at achieving financial independence and freedom'),
(5, 'Wealth Builder Portfolio', 'Geared towards accumulating wealth over the long term'),
(6, 'Dream Achiever Portfolio', 'Invests in assets aligned with achieving specific life goals or dreams'),
(7, 'Phoenix Portfolio', 'Aims to rise from setbacks or losses focusing on recovery and growth'),
(8, 'Fortress Fund', 'Designed to provide stability and protection during turbulent market conditions'),
(9, 'Navigator Portfolio', 'Strategically navigates market uncertainties to capitalize on opportunities'),
(10, 'Smith Family Legacy Portfolio', 'Built to create a financial legacy for the Smith family'),
(11, 'Retirement Bliss Fund', 'Tailored to secure a comfortable and fulfilling retirement lifestyle'),
(12, 'Emma''s College Fund', 'Saves and invests for Emma''s education expenses and future opportunities'),
(13, 'Global Opportunities Portfolio', 'Seeks investment opportunities across various regions and markets'),
(14, 'Emerging Markets Fund', 'Invests in rapidly growing economies and regions with high potential'),
(15, 'Asia-Pacific Growth Portfolio', 'Focused on capitalizing on growth opportunities in the Asia-Pacific region'),
(16, 'Tech Titans Portfolio', 'Invests in leading technology companies with high growth potential'),
(17, 'Green Energy Fund', 'Supports environmentally sustainable energy companies and initiatives'),
(18, 'Healthcare Innovations Portfolio', 'Invests in cutting-edge healthcare technologies and advancements'),
(19, 'Titan Portfolio', 'A large and powerful portfolio aimed at achieving significant returns'),
(20, 'Renaissance Fund', 'Inspired by historical renewal focused on innovative and forward-looking investments'),
(21, 'Space Exploration Portfolio', 'Invests in companies involved in space exploration and technology'),
(22, 'AI Advancement Fund', 'Supports advancements and innovations in artificial intelligence'),
(23, 'Blockchain Frontier Fund', 'Invests in blockchain technology and cryptocurrencies at the forefront of innovation'),
(24, 'Bull Market Portfolio', 'Thrives in rising market conditions capturing upward trends'),
(25, 'Bear Defensive Fund', 'Designed to protect capital during market downturns and bearish conditions'),
(26, 'Eagle Eye Investments', 'Keeps a vigilant watch on market opportunities seeking out potential gains'),
(27, 'Money Magnets Portfolio', 'Attracts wealth and financial success through strategic investment decisions'),
(28, 'Profit Pioneers Fund', 'Pioneers new investment strategies or opportunities to maximize profits'),
(29, 'Investor''s Oasis Portfolio', 'Provides a safe haven for investors offering stability and growth opportunities'),
(30, 'Steady Growth Portfolio', 'A portfolio focused on steady consistent growth with low volatility'),
(31, 'Income Builder Portfolio', 'Designed to generate regular income through dividends or interest payments'),
(32, 'Diversified Holdings Portfolio', 'Invests in a wide range of asset classes to minimize risk'),
(33, 'Freedom Fund', 'Aimed at achieving financial independence and freedom'),
(34, 'Wealth Builder Portfolio', 'Geared towards accumulating wealth over the long term'),
(35, 'Dream Achiever Portfolio', 'Invests in assets aligned with achieving specific life goals or dreams'),
(36, 'Phoenix Portfolio', 'Aims to rise from setbacks or losses focusing on recovery and growth'),
(37, 'Fortress Fund', 'Designed to provide stability and protection during turbulent market conditions'),
(38, 'Navigator Portfolio', 'Strategically navigates market uncertainties to capitalize on opportunities'),
(39, 'Smith Family Legacy Portfolio', 'Built to create a financial legacy for the Smith family'),
(40, 'Retirement Bliss Fund', 'Tailored to secure a comfortable and fulfilling retirement lifestyle'),
(41, 'Emma''s College Fund', 'Saves and invests for Emma''s education expenses and future opportunities'),
(42, 'Global Opportunities Portfolio', 'Seeks investment opportunities across various regions and markets'),
(43, 'Emerging Markets Fund', 'Invests in rapidly growing economies and regions with high potential'),
(44, 'Asia-Pacific Growth Portfolio', 'Focused on capitalizing on growth opportunities in the Asia-Pacific region'),
(45, 'Tech Titans Portfolio', 'Invests in leading technology companies with high growth potential'),
(46, 'Green Energy Fund', 'Supports environmentally sustainable energy companies and initiatives'),
(47, 'Healthcare Innovations Portfolio', 'Invests in cutting-edge healthcare technologies and advancements'),
(48, 'Titan Portfolio', 'A large and powerful portfolio aimed at achieving significant returns'),
(49, 'Renaissance Fund', 'Inspired by historical renewal focused on innovative and forward-looking investments'),
(50, 'Space Exploration Portfolio', 'Invests in companies involved in space exploration and technology'),
(51, 'AI Advancement Fund', 'Supports advancements and innovations in artificial intelligence'),
(52, 'Blockchain Frontier Fund', 'Invests in blockchain technology and cryptocurrencies at the forefront of innovation'),
(53, 'Bull Market Portfolio', 'Thrives in rising market conditions capturing upward trends'),
(54, 'Bear Defensive Fund', 'Designed to protect capital during market downturns and bearish conditions'),
(55, 'Eagle Eye Investments', 'Keeps a vigilant watch on market opportunities seeking out potential gains'),
(56, 'Money Magnets Portfolio', 'Attracts wealth and financial success through strategic investment decisions'),
(57, 'Profit Pioneers Fund', 'Pioneers new investment strategies or opportunities to maximize profits'),
(58, 'Investor''s Oasis Portfolio', 'Provides a safe haven for investors offering stability and growth opportunities'),
(59, 'Steady Growth Portfolio', 'A portfolio focused on steady consistent growth with low volatility'),
(60, 'Income Builder Portfolio', 'Designed to generate regular income through dividends or interest payments');

INSERT INTO Investment_Type (InvestmentID, PortfolioID)
VALUES
(20, 30),
(21, 31),
(34, 17),
(4, 8),
(59, 6),
(1, 44),
(29, 17),
(25, 28),
(46, 59),
(1, 25),
(44, 2),
(8, 53),
(26, 1),
(21, 34),
(13, 14),
(53, 50),
(11, 56),
(60, 41),
(37, 9),
(2, 54),
(12, 32),
(17, 28),
(46, 52),
(30, 48),
(31, 55),
(41, 22),
(3, 13),
(48, 37),
(7, 8),
(4, 34),
(3, 39),
(48, 58),
(24, 1),
(10, 27),
(5, 17),
(37, 15),
(28, 36),
(9, 20),
(48, 7),
(59, 60),
(25, 18),
(60, 53),
(15, 45),
(20, 29),
(7, 35),
(55, 39),
(2, 53),
(41, 15),
(34, 5),
(50, 4),
(24, 14),
(60, 8),
(54, 15),
(29, 34),
(60, 46),
(12, 38),
(14, 15),
(54, 59),
(27, 40),
(34, 4),
(11, 1),
(1, 6),
(43, 57),
(54, 49),
(35, 37),
(37, 19),
(28, 42),
(10, 56),
(59, 53),
(5, 25),
(43, 15),
(54, 55),
(56, 29),
(28, 17),
(31, 9),
(49, 16),
(27, 5),
(32, 30),
(20, 5),
(41, 2),
(6, 50),
(26, 1),
(55, 35),
(52, 38),
(11, 8),
(43, 26),
(8, 52),
(51, 33),
(22, 47),
(58, 45),
(9, 53),
(11, 48),
(53, 26),
(33, 52),
(31, 45),
(26, 4),
(10, 15),
(44, 18),
(32, 48),
(1, 59),
(11, 60),
(28, 47),
(3, 43),
(60, 3),
(46, 7),
(51, 48),
(58, 53),
(30, 41),
(30, 56),
(8, 34),
(2, 27),
(53, 28),
(43, 51),
(36, 57),
(1, 52),
(43, 39),
(41, 24),
(58, 5),
(59, 31),
(23, 54),
(43, 31),
(7, 41),
(46, 42),
(57, 5),
(12, 55),
(2, 15),
(8, 8),
(11, 24),
(27, 54),
(5, 42),
(1, 60),
(15, 31),
(14, 60),
(46, 29),
(36, 18),
(41, 32),
(32, 24),
(58, 40),
(3, 42),
(24, 44),
(1, 5),
(12, 13),
(34, 43),
(39, 38),
(40, 54),
(49, 56),
(56, 7),
(27, 50),
(48, 47),
(8, 44),
(4, 40),
(5, 38),
(36, 11),
(27, 33),
(51, 19),
(32, 53),
(38, 58),
(42, 35),
(3, 34),
(32, 41),
(21, 32),
(20, 7),
(4, 34),
(11, 52),
(55, 20),
(13, 43),
(42, 24),
(6, 35),
(47, 28),
(44, 19),
(26, 47),
(53, 3),
(34, 22),
(28, 9),
(38, 19),
(4, 18),
(47, 12),
(35, 48),
(36, 45),
(33, 31),
(10, 53),
(39, 9),
(36, 29),
(46, 12),
(33, 7),
(9, 15),
(1, 16),
(9, 55),
(51, 17),
(28, 54),
(19, 46),
(48, 3),
(30, 57),
(59, 35),
(52, 36),
(15, 29),
(11, 9),
(56, 38),
(57, 47),
(40, 51);

INSERT INTO Budgets (Budget_id, MaxAmount, MinRemaining, Spent, Remaining, MadeFor, AccountID, CategoryID)
VALUES
(1, 329, 25, 204, 125, 'Healthcare', 19, 6),
(2, 664, 75, 562, 102, 'Utilities', 31, 2),
(3, 766, 50, 398, 368, 'Books and Media', 40, 14),
(4, 642, 50, 122, 520, 'Pet Supplies', 32, 12),
(5, 471, 25, 283, 188, 'Pet Supplies', 3, 12),
(6, 298, 75, 56, 242, 'Transportation', 6, 5),
(7, 934, 50, 805, 129, 'Entertainment', 55, 4),
(8, 314, 25, 0, 314, 'Education', 24, 8),
(9, 233, 50, 44, 189, 'Education', 37, 8),
(10, 273, 50, 151, 122, 'Clothing', 58, 13),
(11, 973, 25, 853, 120, 'Rent', 19, 3),
(12, 201, 0, 100, 101, 'Rent', 17, 3),
(13, 926, 0, 804, 122, 'Utilities', 55, 2),
(14, 319, 25, 187, 132, 'Shopping', 36, 7),
(15, 387, 50, 313, 74, 'Books and Media', 58, 14),
(16, 708, 50, 491, 217, 'Utilities', 42, 2),
(17, 423, 0, 253, 170, 'Groceries', 52, 1),
(18, 693, 75, 536, 157, 'Home Improvement', 55, 10),
(19, 611, 25, 431, 180, 'Entertainment', 60, 4),
(20, 643, 0, 585, 58, 'Groceries', 28, 1),
(21, 682, 75, 558, 124, 'Books and Media', 3, 14),
(22, 708, 50, 583, 125, 'Home Improvement', 55, 10),
(23, 189, 25, 145, 44, 'Entertainment', 2, 4),
(24, 155, 0, 0, 155, 'Groceries', 7, 1),
(25, 137, 25, 105, 32, 'Entertainment', 11, 4),
(26, 293, 50, 168, 125, 'Books and Media', 57, 14),
(27, 388, 50, 102, 286, 'Books and Media', 31, 14),
(28, 569, 25, 448, 121, 'Home Improvement', 39, 10),
(29, 437, 0, 211, 226, 'Shopping', 57, 7),
(30, 118, 50, 41, 77, 'Groceries', 53, 1),
(31, 144, 25, 67, 77, 'Groceries', 49, 1),
(32, 526, 50, 387, 139, 'Groceries', 54, 1),
(33, 834, 75, 735, 99, 'Electronics', 26, 11),
(34, 492, 25, 267, 225, 'Healthcare', 15, 6),
(35, 736, 25, 595, 141, 'Clothing', 42, 13),
(36, 921, 50, 762, 159, 'Utilities', 21, 2),
(37, 370, 75, 254, 116, 'Transportation', 3, 5),
(38, 134, 75, 89, 45, 'Shopping', 40, 7),
(39, 456, 0, 355, 101, 'Rent', 23, 3),
(40, 958, 50, 791, 167, 'Home Improvement', 17, 10),
(41, 738, 50, 500, 238, 'Education', 5, 8),
(42, 811, 75, 743, 68, 'Charity', 9, 9),
(43, 403, 50, 267, 136, 'Pet Supplies', 25, 12),
(44, 908, 50, 847, 61, 'Entertainment', 51, 4),
(45, 471, 50, 268, 203, 'Books and Media', 56, 14),
(46, 348, 50, 200, 148, 'Education', 7, 8),
(47, 612, 50, 488, 124, 'Transportation', 4, 5),
(48, 125, 25, 46, 79, 'Charity', 49, 9),
(49, 477, 50, 420, 57, 'Utilities', 30, 2),
(50, 868, 0, 662, 206, 'Home Improvement', 41, 10),
(51, 769, 50, 593, 176, 'Entertainment', 35, 4),
(52, 648, 75, 598, 50, 'Rent', 13, 3),
(53, 470, 50, 310, 160, 'Clothing', 20, 13),
(54, 951, 75, 693, 258, 'Shopping', 46, 7),
(55, 322, 75, 158, 164, 'Groceries', 11, 1),
(56, 908, 50, 602, 306, 'Books and Media', 31, 14),
(57, 513, 50, 372, 141, 'Electronics', 27, 11),
(58, 559, 75, 483, 76, 'Healthcare', 47, 6),
(59, 564, 0, 460, 104, 'Pet Supplies', 33, 12),
(60, 566, 25, 413, 153, 'Pet Supplies', 60, 12);

INSERT INTO Bills (Bill_id, DueBy, Description, Budget_id, Account_id)
VALUES
(1, '11/22/2023', 'rent', 52, 5),
(2, '4/4/2024', 'shopping bill', 54, 6),
(3, '6/29/2023', 'utilities bill', 49, 31),
(4, '6/21/2023', 'shopping bill', 14, 58),
(5, '9/19/2023', 'utilities bill', 49, 14),
(6, '4/21/2023', 'ordered books and media', 21, 18),
(7, '5/27/2023', 'groceries bill', 32, 33),
(8, '6/9/2023', 'healthcare bill', 58, 13),
(9, '11/13/2023', 'theater tickets', 23, 19),
(10, '2/26/2024', 'charlie card tickets', 47, 1),
(11, '5/14/2023', 'kitchen renovation bill', 40, 47),
(12, '7/3/2023', 'shopping credit card bill', 54, 34),
(13, '12/1/2023', 'bathroom renovation bill', 40, 58),
(14, '1/3/2024', 'baseball game tickets', 44, 22),
(15, '4/12/2023', 'movie tickets bill', 15, 8),
(16, '6/29/2023', 'ballet tickets bill', 51, 3),
(17, '9/2/2023', 'bill for new deck', 50, 24),
(18, '12/7/2023', 'bill for landscaping', 18, 14),
(19, '4/3/2024', 'new clothes credit card bill', 35, 1),
(20, '6/28/2023', 'new shoes bill', 38, 51),
(21, '1/1/2024', 'utilities bill', 13, 31),
(22, '1/23/2024', 'paying final donations to charity', 42, 59),
(23, '9/16/2023', 'bill for painting the house', 28, 44),
(24, '3/12/2024', 'bill for back to school shopping', 38, 25),
(25, '9/11/2023', 'bill for contractor', 18, 13),
(26, '4/26/2023', 'gucci clothes bill', 53, 46),
(27, '3/28/2024', 'hospital bill for surgery', 58, 57),
(28, '4/10/2024', 'utilities bill', 49, 13),
(29, '3/6/2024', 'bill for latest book haul', 27, 25),
(30, '3/18/2024', 'bill for latest clothing haul', 39, 17),
(31, '12/15/2023', 'bill for dog bed', 5, 55),
(32, '12/23/2023', 'bill for broadway theater performance', 23, 21),
(33, '2/23/2024', 'bill for new macbook', 33, 36),
(34, '8/1/2023', 'bill for latest charlie card semester pass', 6, 35),
(35, '7/8/2023', 'bill for back to school clothing', 10, 7),
(36, '5/1/2023', 'tuition bill', 46, 23),
(37, '1/6/2024', 'bill for vacation clothes', 35, 37),
(38, '5/14/2023', 'rent bill', 11, 47),
(39, '10/15/2023', 'bill for cat bed', 5, 29),
(40, '3/6/2024', 'bill for streaming service', 44, 1),
(41, '5/31/2023', 'utilities bill', 16, 52),
(42, '12/10/2023', 'utilities bill', 36, 44),
(43, '9/28/2023', 'utilities bill', 2, 38),
(44, '6/19/2023', 'back to school clothes bill', 53, 48),
(45, '6/30/2023', 'versace clothes bill', 26, 32),
(46, '5/7/2023', 'HBO max subscription', 21, 41),
(47, '3/10/2024', 'Water bill', 49, 2),
(48, '10/31/2023', 'Star Market subscription', 24, 51),
(49, '2/19/2024', 'The wellness foundation', 42, 30),
(50, '4/23/2023', 'Hulu subscription', 3, 54),
(51, '8/31/2023', 'nepotism' , 41, 26),
(52, '4/7/2024', 'Dental Insurance', 58, 19),
(53, '7/26/2023', 'Hannahford super customer subscription', 32, 45),
(54, '1/7/2024', 'Netflix', 45, 58),
(55, '7/2/2023', 'BJs subscription' , 55, 57),
(56, '1/8/2024', 'library subscription', 27, 53),
(57, '7/3/2023', 'contractor', 22, 11),
(58, '10/6/2023', 'dog healthcare bill', 60, 14),
(59, '6/16/2023', 'electricity', 12, 15),
(60, '2/27/2024', 'tutoring' , 9, 22);

INSERT INTO Transactions (Transaction_id, Amount, Date, Account_id, Category_id, Goal_id, Description)
VALUES
(1, 698, '7/21/2023', 16, 1, NULL, 'bought dinner ingredients'),
(2, 884, '3/21/2024', 42, 11, 12, 'bought a new macbook'),
(3, 281, '12/12/2023', 55, 5, NULL, 'bought a charlie pass for the semester'),
(4, 172, '10/12/2023', 41, 9, NULL, 'donated to the local homeless shelter'),
(5, 26, '8/1/2023', 53, 7, 26, 'bought new workout clothes'),
(6, 229, '11/9/2023', 30, 9, NULL, 'donated to the food pantry'),
(7, 886, '8/19/2023', 27, 2, NULL, 'paid electricity'),
(8, 873, '2/19/2024', 38, 10, 48, 'bought new tiles for the kitchen backsplash'),
(9, 801, '9/10/2023', 27, 11, 39, 'bought a new dell computer'),
(10, 126, '1/18/2024', 22, 10, NULL, 'bought a new rug'),
(11, 479, '1/9/2024', 46, 1, NULL, 'bought smoothie ingredients'),
(12, 69, '10/23/2023', 32, 2, NULL, 'paid for house utilities'),
(13, 327, '7/29/2023', 24, 9, NULL, 'gave to local charity'),
(14, 346, '3/26/2024', 14, 11, 36, 'bought old video game collectibles'),
(15, 141, '3/8/2024', 40, 12, 35, 'bought a bed for dog I want to get soon'),
(16, 366, '4/21/2023', 52, 9, NULL, 'gave to the homeless'),
(17, 992, '11/20/2023', 3, 9, NULL, 'game to the womens shelter'),
(18, 158, '4/5/2024', 51, 8, NULL, 'bought kids textbooks'),
(19, 341, '10/30/2023', 47, 8, 18, 'put into my childs education fund'),
(20, 669, '11/4/2023', 50, 14, 21, 'bought concert tickets and merch'),
(21, 604, '8/14/2023', 27, 7, NULL, 'bought a new bag'),
(22, 288, '8/2/2023', 8, 12, NULL, 'dog food and dog medicine'),
(23, 466, '3/21/2024', 53, 1, NULL, 'ingredients for pizza dinner'),
(24, 199, '1/12/2024', 15, 9, NULL, 'gave to womens shelter downtown'),
(25, 801, '6/2/2023', 46, 5, NULL, 'bought airplane tickets'),
(26, 395, '1/28/2024', 17, 1, NULL, 'bought groceries for the week'),
(27, 662, '12/12/2023', 47, 11, 20, 'bought new xbox'),
(28, 105, '9/29/2023', 37, 8, 32, 'bought new notebooks'),
(29, 902, '3/16/2024', 51, 1, 13, 'got wine'),
(30, 763, '9/15/2023', 59, 6, NULL, 'paid for doctors visit'),
(31, 837, '8/1/2023', 9, 13, NULL, 'got new shoes'),
(32, 851, '4/25/2023', 20, 14, NULL, 'bought books in a series'),
(33, 350, '10/8/2023', 30, 12, NULL, 'got new bedding for hamster'),
(34, 523, '1/13/2024', 38, 4, 11, 'paid for a trip to the ballet'),
(35, 652, '5/2/2023', 14, 13, NULL, 'got new clothes'),
(36, 359, '1/14/2024', 29, 9, NULL, 'gave to the homeless shelter'),
(37, 354, '4/6/2024', 41, 7, NULL, 'got new office supplies'),
(38, 755, '3/26/2024', 60, 1, NULL, 'bought groceries'),
(39, 975, '5/22/2023', 10, 3, NULL, 'paid rent to landlord'),
(40, 939, '3/31/2024', 36, 6, NULL, 'paid for surgery'),
(41, 397, '3/14/2024', 13, 8, NULL, 'bought back to school items'),
(42, 184, '9/25/2023', 50, 11, 60, 'bought new switch'),
(43, 834, '1/17/2024', 32, 5, NULL, 'bought plane tickets'),
(44, 484, '7/8/2023', 59, 10, 59, 'bought a new stove'),
(45, 688, '9/12/2023', 54, 2, NULL, 'paid for plumber visit'),
(46, 27, '4/18/2023', 31, 7, NULL, 'went shopping at the mall'),
(47, 829, '11/30/2023', 17, 1, NULL, 'bought groceries'),
(48, 618, '12/6/2023', 49, 9, NULL, 'gave to homeless youth in need'),
(49, 621, '2/3/2024', 33, 10, NULL, 'got new tile floors'),
(50, 723, '12/10/2023', 11, 4, NULL, 'paying for entertainment subscriptions'),
(51, 660, '10/14/2023', 52, 6, NULL, 'bought medicine after doctors visit'),
(52, 212, '5/25/2023', 5, 8, NULL, 'got a backpack for school'),
(53, 704, '10/1/2023', 16, 11, NULL, 'new headphones'),
(54, 80, '10/3/2023', 7, 14, NULL, 'new books'),
(55, 98, '2/24/2024', 43, 3, NULL, 'paid rent'),
(56, 123, '4/17/2023', 4, 13, 17, 'got new clothes'),
(57, 416, '6/29/2023', 19, 5, NULL, 'got train ticket back home'),
(58, 748, '1/28/2024', 47, 2, NULL, 'paid utilities for multiple missed months'),
(59, 5, '5/16/2023', 44, 12, NULL, 'bought treats for my cat'),
(60, 769, '10/14/2023', 35, 2, NULL, 'paid utilities for previously missed months');



insert into Tags (Tag_id, TagName) values (1, 'finance');
insert into Tags (Tag_id, TagName) values (2, 'budget');
insert into Tags (Tag_id, TagName) values (3, 'investment');
insert into Tags (Tag_id, TagName) values (4, 'budget');
insert into Tags (Tag_id, TagName) values (5, 'economy');
insert into Tags (Tag_id, TagName) values (6, 'finance');
insert into Tags (Tag_id, TagName) values (7, 'stocks');
insert into Tags (Tag_id, TagName) values (8, 'investment');
insert into Tags (Tag_id, TagName) values (9, 'investment');
insert into Tags (Tag_id, TagName) values (10, 'economy');
insert into Tags (Tag_id, TagName) values (11, 'economy');
insert into Tags (Tag_id, TagName) values (12, 'finance');
insert into Tags (Tag_id, TagName) values (13, 'investment');
insert into Tags (Tag_id, TagName) values (14, 'money');
insert into Tags (Tag_id, TagName) values (15, 'finance');
insert into Tags (Tag_id, TagName) values (16, 'budget');
insert into Tags (Tag_id, TagName) values (17, 'investment');
insert into Tags (Tag_id, TagName) values (18, 'finance');
insert into Tags (Tag_id, TagName) values (19, 'budget');
insert into Tags (Tag_id, TagName) values (20, 'stocks');
insert into Tags (Tag_id, TagName) values (21, 'finance');
insert into Tags (Tag_id, TagName) values (22, 'investment');
insert into Tags (Tag_id, TagName) values (23, 'money');
insert into Tags (Tag_id, TagName) values (24, 'budget');
insert into Tags (Tag_id, TagName) values (25, 'stocks');
insert into Tags (Tag_id, TagName) values (26, 'stocks');
insert into Tags (Tag_id, TagName) values (27, 'finance');
insert into Tags (Tag_id, TagName) values (28, 'finance');
insert into Tags (Tag_id, TagName) values (29, 'finance');
insert into Tags (Tag_id, TagName) values (30, 'economy');
insert into Tags (Tag_id, TagName) values (31, 'stocks');
insert into Tags (Tag_id, TagName) values (32, 'stocks');
insert into Tags (Tag_id, TagName) values (33, 'economy');
insert into Tags (Tag_id, TagName) values (34, 'stocks');
insert into Tags (Tag_id, TagName) values (35, 'money');
insert into Tags (Tag_id, TagName) values (36, 'economy');
insert into Tags (Tag_id, TagName) values (37, 'investment');
insert into Tags (Tag_id, TagName) values (38, 'budget');
insert into Tags (Tag_id, TagName) values (39, 'stocks');
insert into Tags (Tag_id, TagName) values (40, 'money');
insert into Tags (Tag_id, TagName) values (41, 'finance');
insert into Tags (Tag_id, TagName) values (42, 'money');
insert into Tags (Tag_id, TagName) values (43, 'investment');
insert into Tags (Tag_id, TagName) values (44, 'economy');
insert into Tags (Tag_id, TagName) values (45, 'finance');
insert into Tags (Tag_id, TagName) values (46, 'money');
insert into Tags (Tag_id, TagName) values (47, 'investment');
insert into Tags (Tag_id, TagName) values (48, 'money');
insert into Tags (Tag_id, TagName) values (49, 'investment');
insert into Tags (Tag_id, TagName) values (50, 'budget');
insert into Tags (Tag_id, TagName) values (51, 'finance');
insert into Tags (Tag_id, TagName) values (52, 'investment');
insert into Tags (Tag_id, TagName) values (53, 'finance');
insert into Tags (Tag_id, TagName) values (54, 'finance');
insert into Tags (Tag_id, TagName) values (55, 'budget');
insert into Tags (Tag_id, TagName) values (56, 'economy');
insert into Tags (Tag_id, TagName) values (57, 'budget');
insert into Tags (Tag_id, TagName) values (58, 'investment');
insert into Tags (Tag_id, TagName) values (59, 'investment');
insert into Tags (Tag_id, TagName) values (60, 'stocks');


insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (1, 'Wealth Management Tips', 'Financial markets are showing volatility today as investors react to the latest economic data.', '4/22/2023', '1');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (2, 'Financial Analysis Report', 'The stock market reached new highs as tech companies reported strong earnings.', '7/4/2023', '3');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (3, 'Financial Analysis Report', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '10/19/2023', '16');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (4, 'Economic Forecasting', 'The stock market reached new highs as tech companies reported strong earnings.', '5/2/2023', '22');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (5, 'Economic Forecasting', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '6/29/2023', '41');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (6, 'Wealth Management Tips', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '11/10/2023', '49');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (7, 'Stock Market Trends', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '10/7/2023', '45');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (8, 'Stock Market Trends', 'The stock market reached new highs as tech companies reported strong earnings.', '1/5/2024', '8');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (9, 'Wealth Management Tips', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '11/14/2023', '19');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (10, 'Wealth Management Tips', 'The stock market reached new highs as tech companies reported strong earnings.', '2/14/2024', '12');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (11, 'Investment Strategies', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2/27/2024', '7');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (12, 'Economic Forecasting', 'Financial markets are showing volatility today as investors react to the latest economic data.', '11/23/2023', '44');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (13, 'Economic Forecasting', 'Financial markets are showing volatility today as investors react to the latest economic data.', '8/8/2023', '46');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (14, 'Stock Market Trends', 'Financial markets are showing volatility today as investors react to the latest economic data.', '5/5/2023', '6');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (15, 'Financial Analysis Report', 'The stock market reached new highs as tech companies reported strong earnings.', '7/30/2023', '35');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (16, 'Economic Forecasting', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '8/13/2023', '52');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (17, 'Economic Forecasting', 'Financial markets are showing volatility today as investors react to the latest economic data.', '5/3/2023', '36');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (18, 'Stock Market Trends', 'Financial markets are showing volatility today as investors react to the latest economic data.', '10/19/2023', '17');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (19, 'Investment Strategies', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '8/6/2023', '4');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (20, 'Financial Analysis Report', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2/13/2024', '48');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (21, 'Investment Strategies', 'The stock market reached new highs as tech companies reported strong earnings.', '10/8/2023', '60');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (22, 'Investment Strategies', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '7/14/2023', '39');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (23, 'Investment Strategies', 'The stock market reached new highs as tech companies reported strong earnings.', '9/18/2023', '31');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (24, 'Investment Strategies', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '1/21/2024', '59');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (25, 'Financial Analysis Report', 'The stock market reached new highs as tech companies reported strong earnings.', '9/19/2023', '47');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (26, 'Economic Forecasting', 'Financial markets are showing volatility today as investors react to the latest economic data.', '2/16/2024', '58');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (27, 'Economic Forecasting', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '9/9/2023', '20');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (28, 'Financial Analysis Report', 'The stock market reached new highs as tech companies reported strong earnings.', '1/1/2024', '30');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (29, 'Investment Strategies', 'Financial markets are showing volatility today as investors react to the latest economic data.', '7/23/2023', '40');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (30, 'Wealth Management Tips', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '10/17/2023', '29');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (31, 'Economic Forecasting', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '11/24/2023', '27');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (32, 'Investment Strategies', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '8/2/2023', '33');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (33, 'Financial Analysis Report', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '11/26/2023', '54');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (34, 'Wealth Management Tips', 'The stock market reached new highs as tech companies reported strong earnings.', '1/6/2024', '21');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (35, 'Stock Market Trends', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '11/28/2023', '56');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (36, 'Economic Forecasting', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '12/14/2023', '18');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (37, 'Investment Strategies', 'Financial markets are showing volatility today as investors react to the latest economic data.', '8/1/2023', '55');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (38, 'Stock Market Trends', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '7/16/2023', '10');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (39, 'Financial Analysis Report', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '3/11/2024', '11');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (40, 'Stock Market Trends', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '12/22/2023', '14');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (41, 'Economic Forecasting', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '8/15/2023', '23');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (42, 'Financial Analysis Report', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '10/20/2023', '38');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (43, 'Financial Analysis Report', 'Financial markets are showing volatility today as investors react to the latest economic data.', '12/10/2023', '50');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (44, 'Investment Strategies', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2/23/2024', '53');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (45, 'Economic Forecasting', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '6/26/2023', '42');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (46, 'Economic Forecasting', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '8/11/2023', '51');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (47, 'Investment Strategies', 'The stock market reached new highs as tech companies reported strong earnings.', '4/24/2023', '37');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (48, 'Wealth Management Tips', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '11/14/2023', '34');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (49, 'Financial Analysis Report', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '3/19/2024', '15');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (50, 'Stock Market Trends', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '8/14/2023', '25');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (51, 'Financial Analysis Report', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '8/6/2023', '43');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (52, 'Investment Strategies', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '11/9/2023', '32');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (53, 'Wealth Management Tips', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '5/6/2023', '26');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (54, 'Investment Strategies', 'The stock market reached new highs as tech companies reported strong earnings.', '12/26/2023', '24');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (55, 'Financial Analysis Report', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2/4/2024', '28');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (56, 'Stock Market Trends', 'Financial markets are showing volatility today as investors react to the latest economic data.', '10/26/2023', '2');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (57, 'Economic Forecasting', 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2/12/2024', '13');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (58, 'Stock Market Trends', 'The stock market reached new highs as tech companies reported strong earnings.', '11/5/2023', '9');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (59, 'Economic Forecasting', 'Analysts predict a potential recession in the housing market due to rising interest rates.', '7/7/2023', '57');
insert into Articles (Article_id, Title, Content, UploadDate, User_id) values (60, 'Investment Strategies', 'Financial markets are showing volatility today as investors react to the latest economic data.', '3/21/2024', '5');


insert into Comments (Comment_id, Content, Article_id) values (1, 'Great article!', '24');
insert into Comments (Comment_id, Content, Article_id) values (2, 'Interesting read.', '49');
insert into Comments (Comment_id, Content, Article_id) values (3, 'Interesting read.', '42');
insert into Comments (Comment_id, Content, Article_id) values (4, 'I disagree with the author''s point.', '40');
insert into Comments (Comment_id, Content, Article_id) values (5, 'Great article!', '25');
insert into Comments (Comment_id, Content, Article_id) values (6, 'Interesting read.', '31');
insert into Comments (Comment_id, Content, Article_id) values (7, 'Well-written piece.', '14');
insert into Comments (Comment_id, Content, Article_id) values (8, 'Great article!', '41');
insert into Comments (Comment_id, Content, Article_id) values (9, 'Well-written piece.', '2');
insert into Comments (Comment_id, Content, Article_id) values (10, 'Great article!', '26');
insert into Comments (Comment_id, Content, Article_id) values (11, 'Interesting read.', '43');
insert into Comments (Comment_id, Content, Article_id) values (12, 'Well-written piece.', '53');
insert into Comments (Comment_id, Content, Article_id) values (13, 'Well-written piece.', '34');
insert into Comments (Comment_id, Content, Article_id) values (14, 'Interesting read.', '3');
insert into Comments (Comment_id, Content, Article_id) values (15, 'Well-written piece.', '21');
insert into Comments (Comment_id, Content, Article_id) values (16, 'Great article!', '18');
insert into Comments (Comment_id, Content, Article_id) values (17, 'I disagree with the author''s point.', '39');
insert into Comments (Comment_id, Content, Article_id) values (18, 'Well-written piece.', '9');
insert into Comments (Comment_id, Content, Article_id) values (19, 'Well-written piece.', '50');
insert into Comments (Comment_id, Content, Article_id) values (20, 'I disagree with the author''s point.', '27');
insert into Comments (Comment_id, Content, Article_id) values (21, 'Great article!', '22');
insert into Comments (Comment_id, Content, Article_id) values (22, 'Well-written piece.', '23');
insert into Comments (Comment_id, Content, Article_id) values (23, 'Great article!', '15');
insert into Comments (Comment_id, Content, Article_id) values (24, 'Well-written piece.', '11');
insert into Comments (Comment_id, Content, Article_id) values (25, 'Great article!', '4');
insert into Comments (Comment_id, Content, Article_id) values (26, 'I disagree with the author''s point.', '13');
insert into Comments (Comment_id, Content, Article_id) values (27, 'Great article!', '51');
insert into Comments (Comment_id, Content, Article_id) values (28, 'Great article!', '36');
insert into Comments (Comment_id, Content, Article_id) values (29, 'Well-written piece.', '54');
insert into Comments (Comment_id, Content, Article_id) values (30, 'Well-written piece.', '59');
insert into Comments (Comment_id, Content, Article_id) values (31, 'Interesting read.', '28');
insert into Comments (Comment_id, Content, Article_id) values (32, 'Well-written piece.', '38');
insert into Comments (Comment_id, Content, Article_id) values (33, 'Interesting read.', '48');
insert into Comments (Comment_id, Content, Article_id) values (34, 'Well-written piece.', '57');
insert into Comments (Comment_id, Content, Article_id) values (35, 'Great article!', '33');
insert into Comments (Comment_id, Content, Article_id) values (36, 'Interesting read.', '52');
insert into Comments (Comment_id, Content, Article_id) values (37, 'Well-written piece.', '6');
insert into Comments (Comment_id, Content, Article_id) values (38, 'Well-written piece.', '60');
insert into Comments (Comment_id, Content, Article_id) values (39, 'I disagree with the author''s point.', '1');
insert into Comments (Comment_id, Content, Article_id) values (40, 'Interesting read.', '30');
insert into Comments (Comment_id, Content, Article_id) values (41, 'Interesting read.', '8');
insert into Comments (Comment_id, Content, Article_id) values (42, 'Great article!', '17');
insert into Comments (Comment_id, Content, Article_id) values (43, 'I disagree with the author''s point.', '46');
insert into Comments (Comment_id, Content, Article_id) values (44, 'I disagree with the author''s point.', '58');
insert into Comments (Comment_id, Content, Article_id) values (45, 'Great article!', '32');
insert into Comments (Comment_id, Content, Article_id) values (46, 'I disagree with the author''s point.', '55');
insert into Comments (Comment_id, Content, Article_id) values (47, 'Great article!', '45');
insert into Comments (Comment_id, Content, Article_id) values (48, 'Great article!', '12');
insert into Comments (Comment_id, Content, Article_id) values (49, 'I disagree with the author''s point.', '44');
insert into Comments (Comment_id, Content, Article_id) values (50, 'Great article!', '20');
insert into Comments (Comment_id, Content, Article_id) values (51, 'I disagree with the author''s point.', '7');
insert into Comments (Comment_id, Content, Article_id) values (52, 'Great article!', '35');
insert into Comments (Comment_id, Content, Article_id) values (53, 'Great article!', '29');
insert into Comments (Comment_id, Content, Article_id) values (54, 'I disagree with the author''s point.', '47');
insert into Comments (Comment_id, Content, Article_id) values (55, 'Interesting read.', '37');
insert into Comments (Comment_id, Content, Article_id) values (56, 'Well-written piece.', '10');
insert into Comments (Comment_id, Content, Article_id) values (57, 'Well-written piece.', '19');
insert into Comments (Comment_id, Content, Article_id) values (58, 'Well-written piece.', '5');
insert into Comments (Comment_id, Content, Article_id) values (59, 'Well-written piece.', '16');
insert into Comments (Comment_id, Content, Article_id) values (60, 'I disagree with the author''s point.', '56');






insert into ArticleTags (Article_id, Tag_id) values ('43', '51');
insert into ArticleTags (Article_id, Tag_id) values ('6', '20');
insert into ArticleTags (Article_id, Tag_id) values ('12', '44');
insert into ArticleTags (Article_id, Tag_id) values ('3', '11');
insert into ArticleTags (Article_id, Tag_id) values ('34', '16');
insert into ArticleTags (Article_id, Tag_id) values ('56', '17');
insert into ArticleTags (Article_id, Tag_id) values ('30', '50');
insert into ArticleTags (Article_id, Tag_id) values ('8', '28');
insert into ArticleTags (Article_id, Tag_id) values ('53', '32');
insert into ArticleTags (Article_id, Tag_id) values ('46', '38');
insert into ArticleTags (Article_id, Tag_id) values ('41', '33');
insert into ArticleTags (Article_id, Tag_id) values ('13', '31');
insert into ArticleTags (Article_id, Tag_id) values ('54', '29');
insert into ArticleTags (Article_id, Tag_id) values ('15', '53');
insert into ArticleTags (Article_id, Tag_id) values ('18', '55');
insert into ArticleTags (Article_id, Tag_id) values ('44', '14');
insert into ArticleTags (Article_id, Tag_id) values ('33', '9');
insert into ArticleTags (Article_id, Tag_id) values ('5', '60');
insert into ArticleTags (Article_id, Tag_id) values ('14', '6');
insert into ArticleTags (Article_id, Tag_id) values ('48', '48');
insert into ArticleTags (Article_id, Tag_id) values ('16', '59');
insert into ArticleTags (Article_id, Tag_id) values ('32', '2');
insert into ArticleTags (Article_id, Tag_id) values ('52', '35');
insert into ArticleTags (Article_id, Tag_id) values ('9', '39');
insert into ArticleTags (Article_id, Tag_id) values ('60', '47');
insert into ArticleTags (Article_id, Tag_id) values ('59', '56');
insert into ArticleTags (Article_id, Tag_id) values ('10', '34');
insert into ArticleTags (Article_id, Tag_id) values ('51', '45');
insert into ArticleTags (Article_id, Tag_id) values ('45', '7');
insert into ArticleTags (Article_id, Tag_id) values ('11', '25');
insert into ArticleTags (Article_id, Tag_id) values ('31', '27');
insert into ArticleTags (Article_id, Tag_id) values ('35', '24');
insert into ArticleTags (Article_id, Tag_id) values ('1', '1');
insert into ArticleTags (Article_id, Tag_id) values ('58', '18');
insert into ArticleTags (Article_id, Tag_id) values ('50', '23');
insert into ArticleTags (Article_id, Tag_id) values ('27', '54');
insert into ArticleTags (Article_id, Tag_id) values ('25', '5');
insert into ArticleTags (Article_id, Tag_id) values ('2', '36');
insert into ArticleTags (Article_id, Tag_id) values ('22', '19');
insert into ArticleTags (Article_id, Tag_id) values ('28', '12');
insert into ArticleTags (Article_id, Tag_id) values ('7', '10');
insert into ArticleTags (Article_id, Tag_id) values ('57', '26');
insert into ArticleTags (Article_id, Tag_id) values ('26', '3');
insert into ArticleTags (Article_id, Tag_id) values ('49', '42');
insert into ArticleTags (Article_id, Tag_id) values ('17', '22');
insert into ArticleTags (Article_id, Tag_id) values ('21', '4');
insert into ArticleTags (Article_id, Tag_id) values ('23', '15');
insert into ArticleTags (Article_id, Tag_id) values ('42', '49');
insert into ArticleTags (Article_id, Tag_id) values ('4', '30');
insert into ArticleTags (Article_id, Tag_id) values ('36', '8');
insert into ArticleTags (Article_id, Tag_id) values ('20', '13');
insert into ArticleTags (Article_id, Tag_id) values ('29', '43');
insert into ArticleTags (Article_id, Tag_id) values ('19', '41');
insert into ArticleTags (Article_id, Tag_id) values ('24', '46');
insert into ArticleTags (Article_id, Tag_id) values ('37', '57');
insert into ArticleTags (Article_id, Tag_id) values ('38', '40');
insert into ArticleTags (Article_id, Tag_id) values ('40', '58');
insert into ArticleTags (Article_id, Tag_id) values ('39', '37');
insert into ArticleTags (Article_id, Tag_id) values ('47', '21');
insert into ArticleTags (Article_id, Tag_id) values ('55', '52');
insert into ArticleTags (Article_id, Tag_id) values ('26', '59');
insert into ArticleTags (Article_id, Tag_id) values ('27', '41');
insert into ArticleTags (Article_id, Tag_id) values ('1', '17');
insert into ArticleTags (Article_id, Tag_id) values ('53', '26');
insert into ArticleTags (Article_id, Tag_id) values ('10', '11');
insert into ArticleTags (Article_id, Tag_id) values ('9', '56');
insert into ArticleTags (Article_id, Tag_id) values ('31', '8');
insert into ArticleTags (Article_id, Tag_id) values ('44', '36');
insert into ArticleTags (Article_id, Tag_id) values ('50', '10');
insert into ArticleTags (Article_id, Tag_id) values ('28', '32');
insert into ArticleTags (Article_id, Tag_id) values ('46', '50');
insert into ArticleTags (Article_id, Tag_id) values ('38', '20');
insert into ArticleTags (Article_id, Tag_id) values ('42', '2');
insert into ArticleTags (Article_id, Tag_id) values ('45', '54');
insert into ArticleTags (Article_id, Tag_id) values ('57', '1');
insert into ArticleTags (Article_id, Tag_id) values ('43', '30');
insert into ArticleTags (Article_id, Tag_id) values ('56', '49');
insert into ArticleTags (Article_id, Tag_id) values ('24', '57');
insert into ArticleTags (Article_id, Tag_id) values ('48', '9');
insert into ArticleTags (Article_id, Tag_id) values ('4', '45');
insert into ArticleTags (Article_id, Tag_id) values ('35', '24');
insert into ArticleTags (Article_id, Tag_id) values ('2', '6');
insert into ArticleTags (Article_id, Tag_id) values ('55', '37');
insert into ArticleTags (Article_id, Tag_id) values ('54', '15');
insert into ArticleTags (Article_id, Tag_id) values ('20', '33');
insert into ArticleTags (Article_id, Tag_id) values ('33', '60');
insert into ArticleTags (Article_id, Tag_id) values ('22', '25');
insert into ArticleTags (Article_id, Tag_id) values ('51', '21');
insert into ArticleTags (Article_id, Tag_id) values ('17', '4');
insert into ArticleTags (Article_id, Tag_id) values ('41', '43');
insert into ArticleTags (Article_id, Tag_id) values ('3', '19');
insert into ArticleTags (Article_id, Tag_id) values ('21', '39');
insert into ArticleTags (Article_id, Tag_id) values ('60', '18');
insert into ArticleTags (Article_id, Tag_id) values ('18', '29');
insert into ArticleTags (Article_id, Tag_id) values ('14', '23');
insert into ArticleTags (Article_id, Tag_id) values ('30', '48');
insert into ArticleTags (Article_id, Tag_id) values ('11', '51');
insert into ArticleTags (Article_id, Tag_id) values ('40', '40');
insert into ArticleTags (Article_id, Tag_id) values ('47', '44');
insert into ArticleTags (Article_id, Tag_id) values ('36', '5');
insert into ArticleTags (Article_id, Tag_id) values ('7', '42');
insert into ArticleTags (Article_id, Tag_id) values ('59', '3');
insert into ArticleTags (Article_id, Tag_id) values ('8', '22');
insert into ArticleTags (Article_id, Tag_id) values ('32', '53');
insert into ArticleTags (Article_id, Tag_id) values ('34', '58');
insert into ArticleTags (Article_id, Tag_id) values ('37', '13');
insert into ArticleTags (Article_id, Tag_id) values ('6', '12');
insert into ArticleTags (Article_id, Tag_id) values ('19', '34');
insert into ArticleTags (Article_id, Tag_id) values ('29', '28');
insert into ArticleTags (Article_id, Tag_id) values ('16', '38');
insert into ArticleTags (Article_id, Tag_id) values ('49', '47');
insert into ArticleTags (Article_id, Tag_id) values ('12', '35');
insert into ArticleTags (Article_id, Tag_id) values ('58', '52');
insert into ArticleTags (Article_id, Tag_id) values ('52', '55');
insert into ArticleTags (Article_id, Tag_id) values ('5', '27');
insert into ArticleTags (Article_id, Tag_id) values ('13', '7');
insert into ArticleTags (Article_id, Tag_id) values ('23', '46');
insert into ArticleTags (Article_id, Tag_id) values ('15', '16');
insert into ArticleTags (Article_id, Tag_id) values ('25', '31');
insert into ArticleTags (Article_id, Tag_id) values ('39', '14');
insert into ArticleTags (Article_id, Tag_id) values ('19', '60');
insert into ArticleTags (Article_id, Tag_id) values ('11', '40');
insert into ArticleTags (Article_id, Tag_id) values ('34', '59');
insert into ArticleTags (Article_id, Tag_id) values ('13', '3');
insert into ArticleTags (Article_id, Tag_id) values ('8', '31');
insert into ArticleTags (Article_id, Tag_id) values ('22', '52');
insert into ArticleTags (Article_id, Tag_id) values ('28', '34');
insert into ArticleTags (Article_id, Tag_id) values ('20', '26');
insert into ArticleTags (Article_id, Tag_id) values ('38', '25');
insert into ArticleTags (Article_id, Tag_id) values ('3', '49');
insert into ArticleTags (Article_id, Tag_id) values ('44', '17');
insert into ArticleTags (Article_id, Tag_id) values ('51', '2');
insert into ArticleTags (Article_id, Tag_id) values ('55', '11');
insert into ArticleTags (Article_id, Tag_id) values ('56', '45');
insert into ArticleTags (Article_id, Tag_id) values ('18', '37');
insert into ArticleTags (Article_id, Tag_id) values ('27', '39');
insert into ArticleTags (Article_id, Tag_id) values ('33', '43');
insert into ArticleTags (Article_id, Tag_id) values ('31', '22');
insert into ArticleTags (Article_id, Tag_id) values ('47', '41');
insert into ArticleTags (Article_id, Tag_id) values ('2', '50');
insert into ArticleTags (Article_id, Tag_id) values ('25', '21');
insert into ArticleTags (Article_id, Tag_id) values ('54', '46');
insert into ArticleTags (Article_id, Tag_id) values ('43', '30');
insert into ArticleTags (Article_id, Tag_id) values ('5', '19');
insert into ArticleTags (Article_id, Tag_id) values ('10', '9');
insert into ArticleTags (Article_id, Tag_id) values ('17', '44');
insert into ArticleTags (Article_id, Tag_id) values ('57', '8');
insert into ArticleTags (Article_id, Tag_id) values ('45', '42');
insert into ArticleTags (Article_id, Tag_id) values ('39', '4');
insert into ArticleTags (Article_id, Tag_id) values ('9', '53');
insert into ArticleTags (Article_id, Tag_id) values ('40', '16');
insert into ArticleTags (Article_id, Tag_id) values ('35', '57');
insert into ArticleTags (Article_id, Tag_id) values ('32', '15');
insert into ArticleTags (Article_id, Tag_id) values ('21', '18');
insert into ArticleTags (Article_id, Tag_id) values ('49', '47');
insert into ArticleTags (Article_id, Tag_id) values ('53', '29');
insert into ArticleTags (Article_id, Tag_id) values ('58', '33');
insert into ArticleTags (Article_id, Tag_id) values ('30', '28');
insert into ArticleTags (Article_id, Tag_id) values ('12', '55');
insert into ArticleTags (Article_id, Tag_id) values ('23', '51');
insert into ArticleTags (Article_id, Tag_id) values ('24', '23');
insert into ArticleTags (Article_id, Tag_id) values ('42', '32');
insert into ArticleTags (Article_id, Tag_id) values ('59', '10');
insert into ArticleTags (Article_id, Tag_id) values ('6', '56');
insert into ArticleTags (Article_id, Tag_id) values ('16', '14');
insert into ArticleTags (Article_id, Tag_id) values ('14', '48');
insert into ArticleTags (Article_id, Tag_id) values ('52', '36');
insert into ArticleTags (Article_id, Tag_id) values ('50', '7');
insert into ArticleTags (Article_id, Tag_id) values ('15', '5');
insert into ArticleTags (Article_id, Tag_id) values ('29', '24');
insert into ArticleTags (Article_id, Tag_id) values ('4', '20');
insert into ArticleTags (Article_id, Tag_id) values ('46', '12');
insert into ArticleTags (Article_id, Tag_id) values ('26', '35');
insert into ArticleTags (Article_id, Tag_id) values ('7', '6');
insert into ArticleTags (Article_id, Tag_id) values ('36', '54');
insert into ArticleTags (Article_id, Tag_id) values ('41', '38');
insert into ArticleTags (Article_id, Tag_id) values ('60', '1');
insert into ArticleTags (Article_id, Tag_id) values ('48', '13');
insert into ArticleTags (Article_id, Tag_id) values ('1', '27');
insert into ArticleTags (Article_id, Tag_id) values ('37', '58');
insert into ArticleTags (Article_id, Tag_id) values ('47', '49');
insert into ArticleTags (Article_id, Tag_id) values ('49', '55');
insert into ArticleTags (Article_id, Tag_id) values ('12', '51');
insert into ArticleTags (Article_id, Tag_id) values ('56', '15');
insert into ArticleTags (Article_id, Tag_id) values ('1', '13');
insert into ArticleTags (Article_id, Tag_id) values ('20', '8');
insert into ArticleTags (Article_id, Tag_id) values ('57', '4');
insert into ArticleTags (Article_id, Tag_id) values ('5', '53');
insert into ArticleTags (Article_id, Tag_id) values ('18', '59');
insert into ArticleTags (Article_id, Tag_id) values ('17', '45');
insert into ArticleTags (Article_id, Tag_id) values ('36', '29');
insert into ArticleTags (Article_id, Tag_id) values ('30', '60');
insert into ArticleTags (Article_id, Tag_id) values ('7', '25');
insert into ArticleTags (Article_id, Tag_id) values ('54', '27');
insert into ArticleTags (Article_id, Tag_id) values ('6', '21');
insert into ArticleTags (Article_id, Tag_id) values ('38', '38');
insert into ArticleTags (Article_id, Tag_id) values ('33', '17');
insert into ArticleTags (Article_id, Tag_id) values ('27', '46');
insert into ArticleTags (Article_id, Tag_id) values ('55', '52');
insert into ArticleTags (Article_id, Tag_id) values ('9', '14');


insert into AccountInfo (User_id, Account_id) values ('26', '19');
insert into AccountInfo (User_id, Account_id) values ('9', '30');
insert into AccountInfo (User_id, Account_id) values ('25', '18');
insert into AccountInfo (User_id, Account_id) values ('1', '57');
insert into AccountInfo (User_id, Account_id) values ('17', '60');
insert into AccountInfo (User_id, Account_id) values ('2', '31');
insert into AccountInfo (User_id, Account_id) values ('16', '43');
insert into AccountInfo (User_id, Account_id) values ('7', '40');
insert into AccountInfo (User_id, Account_id) values ('4', '55');
insert into AccountInfo (User_id, Account_id) values ('6', '37');
insert into AccountInfo (User_id, Account_id) values ('58', '35');
insert into AccountInfo (User_id, Account_id) values ('19', '51');
insert into AccountInfo (User_id, Account_id) values ('34', '25');
insert into AccountInfo (User_id, Account_id) values ('15', '3');
insert into AccountInfo (User_id, Account_id) values ('55', '42');
insert into AccountInfo (User_id, Account_id) values ('54', '12');
insert into AccountInfo (User_id, Account_id) values ('32', '59');
insert into AccountInfo (User_id, Account_id) values ('57', '52');
insert into AccountInfo (User_id, Account_id) values ('52', '53');
insert into AccountInfo (User_id, Account_id) values ('18', '10');
insert into AccountInfo (User_id, Account_id) values ('42', '50');
insert into AccountInfo (User_id, Account_id) values ('33', '58');
insert into AccountInfo (User_id, Account_id) values ('46', '44');
insert into AccountInfo (User_id, Account_id) values ('27', '15');
insert into AccountInfo (User_id, Account_id) values ('28', '2');
insert into AccountInfo (User_id, Account_id) values ('53', '16');
insert into AccountInfo (User_id, Account_id) values ('51', '28');
insert into AccountInfo (User_id, Account_id) values ('48', '48');
insert into AccountInfo (User_id, Account_id) values ('50', '24');
insert into AccountInfo (User_id, Account_id) values ('59', '34');
insert into AccountInfo (User_id, Account_id) values ('13', '26');
insert into AccountInfo (User_id, Account_id) values ('8', '46');
insert into AccountInfo (User_id, Account_id) values ('47', '47');
insert into AccountInfo (User_id, Account_id) values ('23', '22');
insert into AccountInfo (User_id, Account_id) values ('5', '56');
insert into AccountInfo (User_id, Account_id) values ('30', '36');
insert into AccountInfo (User_id, Account_id) values ('60', '6');
insert into AccountInfo (User_id, Account_id) values ('21', '27');
insert into AccountInfo (User_id, Account_id) values ('22', '1');
insert into AccountInfo (User_id, Account_id) values ('35', '20');
insert into AccountInfo (User_id, Account_id) values ('20', '41');
insert into AccountInfo (User_id, Account_id) values ('56', '9');
insert into AccountInfo (User_id, Account_id) values ('11', '54');
insert into AccountInfo (User_id, Account_id) values ('10', '38');
insert into AccountInfo (User_id, Account_id) values ('31', '32');
insert into AccountInfo (User_id, Account_id) values ('12', '8');
insert into AccountInfo (User_id, Account_id) values ('49', '7');
insert into AccountInfo (User_id, Account_id) values ('37', '23');
insert into AccountInfo (User_id, Account_id) values ('36', '49');
insert into AccountInfo (User_id, Account_id) values ('39', '33');
insert into AccountInfo (User_id, Account_id) values ('14', '17');
insert into AccountInfo (User_id, Account_id) values ('45', '4');
insert into AccountInfo (User_id, Account_id) values ('29', '5');
insert into AccountInfo (User_id, Account_id) values ('3', '11');
insert into AccountInfo (User_id, Account_id) values ('44', '14');
insert into AccountInfo (User_id, Account_id) values ('40', '29');
insert into AccountInfo (User_id, Account_id) values ('43', '45');
insert into AccountInfo (User_id, Account_id) values ('24', '39');
insert into AccountInfo (User_id, Account_id) values ('41', '21');
insert into AccountInfo (User_id, Account_id) values ('38', '13');
insert into AccountInfo (User_id, Account_id) values ('10', '15');
insert into AccountInfo (User_id, Account_id) values ('32', '51');
insert into AccountInfo (User_id, Account_id) values ('55', '12');
insert into AccountInfo (User_id, Account_id) values ('48', '18');
insert into AccountInfo (User_id, Account_id) values ('8', '42');
insert into AccountInfo (User_id, Account_id) values ('22', '33');
insert into AccountInfo (User_id, Account_id) values ('27', '3');
insert into AccountInfo (User_id, Account_id) values ('15', '20');
insert into AccountInfo (User_id, Account_id) values ('30', '58');
insert into AccountInfo (User_id, Account_id) values ('7', '56');
insert into AccountInfo (User_id, Account_id) values ('59', '50');
insert into AccountInfo (User_id, Account_id) values ('29', '37');
insert into AccountInfo (User_id, Account_id) values ('21', '36');
insert into AccountInfo (User_id, Account_id) values ('17', '6');
insert into AccountInfo (User_id, Account_id) values ('41', '29');
insert into AccountInfo (User_id, Account_id) values ('20', '11');
insert into AccountInfo (User_id, Account_id) values ('45', '52');
insert into AccountInfo (User_id, Account_id) values ('38', '54');
insert into AccountInfo (User_id, Account_id) values ('26', '30');
insert into AccountInfo (User_id, Account_id) values ('3', '28');
insert into AccountInfo (User_id, Account_id) values ('42', '22');
insert into AccountInfo (User_id, Account_id) values ('34', '4');
insert into AccountInfo (User_id, Account_id) values ('60', '49');
insert into AccountInfo (User_id, Account_id) values ('1', '5');
insert into AccountInfo (User_id, Account_id) values ('6', '41');
insert into AccountInfo (User_id, Account_id) values ('58', '53');
insert into AccountInfo (User_id, Account_id) values ('44', '45');
insert into AccountInfo (User_id, Account_id) values ('46', '19');
insert into AccountInfo (User_id, Account_id) values ('5', '40');
insert into AccountInfo (User_id, Account_id) values ('57', '44');
insert into AccountInfo (User_id, Account_id) values ('43', '39');
insert into AccountInfo (User_id, Account_id) values ('2', '38');
insert into AccountInfo (User_id, Account_id) values ('51', '57');
insert into AccountInfo (User_id, Account_id) values ('39', '13');
insert into AccountInfo (User_id, Account_id) values ('28', '21');
insert into AccountInfo (User_id, Account_id) values ('19', '14');
insert into AccountInfo (User_id, Account_id) values ('56', '9');
insert into AccountInfo (User_id, Account_id) values ('25', '8');
insert into AccountInfo (User_id, Account_id) values ('53', '2');
insert into AccountInfo (User_id, Account_id) values ('4', '24');
insert into AccountInfo (User_id, Account_id) values ('18', '25');
insert into AccountInfo (User_id, Account_id) values ('40', '16');
insert into AccountInfo (User_id, Account_id) values ('37', '47');
insert into AccountInfo (User_id, Account_id) values ('14', '55');
insert into AccountInfo (User_id, Account_id) values ('12', '48');
insert into AccountInfo (User_id, Account_id) values ('54', '34');
insert into AccountInfo (User_id, Account_id) values ('49', '1');
insert into AccountInfo (User_id, Account_id) values ('36', '10');
insert into AccountInfo (User_id, Account_id) values ('47', '59');
insert into AccountInfo (User_id, Account_id) values ('11', '26');
insert into AccountInfo (User_id, Account_id) values ('23', '43');
insert into AccountInfo (User_id, Account_id) values ('31', '35');
insert into AccountInfo (User_id, Account_id) values ('33', '23');
insert into AccountInfo (User_id, Account_id) values ('35', '27');
insert into AccountInfo (User_id, Account_id) values ('52', '60');
insert into AccountInfo (User_id, Account_id) values ('16', '46');
insert into AccountInfo (User_id, Account_id) values ('13', '7');
insert into AccountInfo (User_id, Account_id) values ('9', '32');
insert into AccountInfo (User_id, Account_id) values ('50', '17');
insert into AccountInfo (User_id, Account_id) values ('24', '31');
insert into AccountInfo (User_id, Account_id) values ('13', '60');
insert into AccountInfo (User_id, Account_id) values ('14', '22');
insert into AccountInfo (User_id, Account_id) values ('36', '29');
insert into AccountInfo (User_id, Account_id) values ('24', '21');
insert into AccountInfo (User_id, Account_id) values ('52', '2');
insert into AccountInfo (User_id, Account_id) values ('3', '36');
insert into AccountInfo (User_id, Account_id) values ('46', '23');
insert into AccountInfo (User_id, Account_id) values ('23', '26');
insert into AccountInfo (User_id, Account_id) values ('60', '12');
insert into AccountInfo (User_id, Account_id) values ('30', '32');
insert into AccountInfo (User_id, Account_id) values ('17', '53');
insert into AccountInfo (User_id, Account_id) values ('21', '58');
insert into AccountInfo (User_id, Account_id) values ('28', '10');
insert into AccountInfo (User_id, Account_id) values ('15', '33');
insert into AccountInfo (User_id, Account_id) values ('27', '38');
insert into AccountInfo (User_id, Account_id) values ('26', '51');
insert into AccountInfo (User_id, Account_id) values ('55', '9');
insert into AccountInfo (User_id, Account_id) values ('53', '31');
insert into AccountInfo (User_id, Account_id) values ('48', '8');
insert into AccountInfo (User_id, Account_id) values ('1', '56');
insert into AccountInfo (User_id, Account_id) values ('20', '39');
insert into AccountInfo (User_id, Account_id) values ('39', '47');
insert into AccountInfo (User_id, Account_id) values ('25', '3');
insert into AccountInfo (User_id, Account_id) values ('57', '57');
insert into AccountInfo (User_id, Account_id) values ('45', '52');
insert into AccountInfo (User_id, Account_id) values ('54', '42');
insert into AccountInfo (User_id, Account_id) values ('40', '17');
insert into AccountInfo (User_id, Account_id) values ('49', '37');
insert into AccountInfo (User_id, Account_id) values ('59', '30');
insert into AccountInfo (User_id, Account_id) values ('37', '24');
insert into AccountInfo (User_id, Account_id) values ('5', '34');
insert into AccountInfo (User_id, Account_id) values ('16', '55');
insert into AccountInfo (User_id, Account_id) values ('35', '45');
insert into AccountInfo (User_id, Account_id) values ('18', '1');
insert into AccountInfo (User_id, Account_id) values ('32', '7');
insert into AccountInfo (User_id, Account_id) values ('19', '54');
insert into AccountInfo (User_id, Account_id) values ('51', '35');
insert into AccountInfo (User_id, Account_id) values ('58', '46');
insert into AccountInfo (User_id, Account_id) values ('11', '20');
insert into AccountInfo (User_id, Account_id) values ('43', '5');
insert into AccountInfo (User_id, Account_id) values ('33', '13');
insert into AccountInfo (User_id, Account_id) values ('41', '44');
insert into AccountInfo (User_id, Account_id) values ('9', '50');
insert into AccountInfo (User_id, Account_id) values ('10', '28');
insert into AccountInfo (User_id, Account_id) values ('44', '40');
insert into AccountInfo (User_id, Account_id) values ('12', '27');
insert into AccountInfo (User_id, Account_id) values ('50', '41');
insert into AccountInfo (User_id, Account_id) values ('42', '18');
insert into AccountInfo (User_id, Account_id) values ('8', '14');
insert into AccountInfo (User_id, Account_id) values ('56', '11');
insert into AccountInfo (User_id, Account_id) values ('2', '16');
insert into AccountInfo (User_id, Account_id) values ('7', '6');
insert into AccountInfo (User_id, Account_id) values ('29', '48');
insert into AccountInfo (User_id, Account_id) values ('22', '59');
insert into AccountInfo (User_id, Account_id) values ('38', '19');
insert into AccountInfo (User_id, Account_id) values ('6', '15');
insert into AccountInfo (User_id, Account_id) values ('31', '25');
insert into AccountInfo (User_id, Account_id) values ('47', '49');
insert into AccountInfo (User_id, Account_id) values ('34', '4');
insert into AccountInfo (User_id, Account_id) values ('4', '43');
insert into AccountInfo (User_id, Account_id) values ('10', '47');
insert into AccountInfo (User_id, Account_id) values ('53', '27');
insert into AccountInfo (User_id, Account_id) values ('14', '17');
insert into AccountInfo (User_id, Account_id) values ('45', '19');
insert into AccountInfo (User_id, Account_id) values ('35', '59');
insert into AccountInfo (User_id, Account_id) values ('27', '35');
insert into AccountInfo (User_id, Account_id) values ('7', '37');
insert into AccountInfo (User_id, Account_id) values ('32', '6');
insert into AccountInfo (User_id, Account_id) values ('16', '3');
insert into AccountInfo (User_id, Account_id) values ('1', '52');
insert into AccountInfo (User_id, Account_id) values ('36', '29');
insert into AccountInfo (User_id, Account_id) values ('33', '32');
insert into AccountInfo (User_id, Account_id) values ('20', '51');
insert into AccountInfo (User_id, Account_id) values ('37', '5');
insert into AccountInfo (User_id, Account_id) values ('50', '20');
insert into AccountInfo (User_id, Account_id) values ('5', '49');
insert into AccountInfo (User_id, Account_id) values ('59', '25');
insert into AccountInfo (User_id, Account_id) values ('41', '30');
insert into AccountInfo (User_id, Account_id) values ('30', '26');
insert into AccountInfo (User_id, Account_id) values ('60', '8');



