DROP DATABASE IF EXISTS Magic;
CREATE DATABASE Magic;
USE Magic;

CREATE TABLE IF NOT EXISTS Users (
    User_id int NOT NULL PRIMARY KEY,
    FirstName TEXT NOT NULL,
    MiddleName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email varchar(50) NOT NULL,
    Phone varchar(12) NOT NULL,
    BirthDate DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS Articles (
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

CREATE TABLE IF NOT EXISTS Comments (
  Comment_id int PRIMARY KEY NOT NULL,
  CONTENT TEXT NOT NULL,
  Article_id int NOT NULL,


    CONSTRAINT commentArticle
        FOREIGN KEY (Article_id)
            REFERENCES Articles (Article_id)
            ON UPDATE cascade
            ON DELETE cascade

);

CREATE TABLE IF NOT EXISTS Tags (
  Tag_id int PRIMARY KEY,
  TagName varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS ArticleTags (
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


CREATE TABLE IF NOT EXISTS Accounts (
    Account_id int NOT NULL PRIMARY KEY,
    Balance int NOT NULL,
    AccountType varchar(50),
    Date_created DATETIME NOT NULL

);


CREATE TABLE IF NOT EXISTS AccountInfo(
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

CREATE TABLE IF NOT EXISTS Categories (
    Category_id int NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Goals (
    Goal_id int NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Date DATETIME NOT NULL,
    TotalFund double NOT NULL,
    SavedSoFar double NOT NULL
);

CREATE TABLE IF NOT EXISTS Transactions (
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



CREATE TABLE IF NOT EXISTS Budgets (
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

CREATE TABLE IF NOT EXISTS Bills (
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

CREATE TABLE IF NOT EXISTS Investments (
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

CREATE TABLE IF NOT EXISTS Portfolios (
    Portfolio_id int NOT NULL PRIMARY KEY,
    name varchar(50) NOT NULL,
    Description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Investment_Type (
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

INSERT INTO Users VALUES
(1, 'Flemming', 'Abberley', 'Stopford', 'fstopford0@sogou.com', '845-557-3115', '2024-03-05 12:20:00'),
(2, 'Arie', 'Arkley', 'Ferie', 'aferie1@comsenz.com', '213-420-3467', '2023-05-05 05:44:00'),
(3, 'Dorena', 'Paskerful', 'Leebeter', 'dleebeter2@jiathis.com', '784-249-1584', '2024-01-18 12:18:00'),
(4, 'Orland', 'Webster', 'Ingley', 'oingley3@merriam-webster.com', '396-307-0973', '2023-10-08 09:57:00'),
(5, 'Lolita', 'Bottle', 'O''Feeny', 'lofeeny4@google.co.uk', '842-135-8478', '2024-02-14 17:04:00'),
(6, 'Hyacinthia', 'Albutt', 'Measen', 'hmeasen5@tinypic.com', '303-270-4022', '2023-12-21 07:37:00'),
(7, 'Maybelle', 'Richemond', 'Bayford', 'mbayford6@studiopress.com', '603-980-1658', '2023-05-02 12:26:00'),
(8, 'Evania', 'Othen', 'Wiersma', 'ewiersma7@squidoo.com', '650-981-9226', '2023-06-27 11:44:00'),
(9, 'Joye', 'Shieldon', 'Gobel', 'jgobel8@stumbleupon.com', '220-116-4176', '2023-12-14 08:37:00'),
(10, 'Selie', 'Alison', 'Carter', 'scarter9@statcounter.com', '819-535-0790', '2023-08-13 15:05:00'),
(11, 'Rudy', 'Babinski', 'Cutsforth', 'rcutsfortha@odnoklassniki.ru', '439-722-0534', '2023-07-06 02:25:00'),
(12, 'Effie', 'Alastair', 'Dalgliesh', 'edalglieshb@cam.ac.uk', '525-826-8142', '2023-12-22 09:21:00'),
(13, 'Finley', 'Bing', 'Toohey', 'ftooheyc@51.la', '260-518-6799', '2024-02-05 10:48:00'),
(14, 'Lonni', 'Pye', 'Loadsman', 'lloadsmand@tmall.com', '362-156-1445', '2023-11-26 23:47:00'),
(15, 'Doralia', 'Coldicott', 'Prine', 'dprinee@tmall.com', '543-381-7097', '2023-07-16 05:45:00'),
(16, 'Bee', 'Ogle', 'Burchett', 'bburchettf@businesswire.com', '434-419-6255', '2023-04-14 02:13:00'),
(17, 'Emalee', 'Traviss', 'Haldon', 'ehaldong@newsvine.com', '908-901-5768', '2024-03-12 01:19:00'),
(18, 'Yuma', 'O'' Culligan', 'Grolle', 'ygrolleh@nps.gov', '846-456-4310', '2023-04-12 05:31:00'),
(19, 'Charissa', 'Blakeston', 'Bebbell', 'cbebbelli@usnews.com', '924-416-0400', '2024-01-05 04:21:00'),
(20, 'Derwin', 'Tomczykowski', 'Nend', 'dnendj@wikispaces.com', '223-522-2014', '2023-04-22 12:10:00'),
(21, 'Noland', 'Ramsbottom', 'Wolseley', 'nwolseleyk@microsoft.com', '333-534-3030', '2023-06-30 14:21:00'),
(22, 'Delila', 'Cissell', 'Lorking', 'dlorkingl@twitter.com', '681-612-3923', '2024-02-14 00:52:00'),
(23, 'Kevan', 'Blackbourn', 'Spottswood', 'kspottswoodm@economist.com', '820-185-6701', '2023-05-07 20:47:00'),
(24, 'Andrea', 'Whyffen', 'Jelk', 'ajelkn@so-net.ne.jp', '479-614-9275', '2023-09-29 15:46:00'),
(25, 'Rancell', 'McGougan', 'Joe', 'rjoeo@surveymonkey.com', '138-125-1914', '2024-02-09 06:23:00'),
(26, 'Matthus', 'Spaight', 'Brommage', 'mbrommagep@usgs.gov', '182-548-1384', '2023-11-12 15:27:00'),
(27, 'Shaylyn', 'Jessop', 'Paszek', 'spaszekq@live.com', '904-370-6461', '2023-06-20 10:14:00'),
(28, 'Aldric', 'Felderer', 'Greensite', 'agreensiter@simplemachines.org', '241-810-2638', '2023-11-09 12:32:00'),
(29, 'Cathe', 'Aves', 'Suermeiers', 'csuermeierss@blog.com', '162-117-3202', '2023-07-03 02:20:00'),
(30, 'Camala', 'Wardale', 'Ropert', 'cropertt@com.com', '206-681-1881', '2023-09-14 18:47:00'),
(31, 'Janenna', 'Tincey', 'McKendry', 'jmckendryu@reference.com', '321-274-6807', '2024-01-19 08:17:00'),
(32, 'Wilhelm', 'Baum', 'Hammerstone', 'whammerstonev@epa.gov', '333-657-3709', '2023-11-22 18:53:00'),
(33, 'Paulita', 'Lease', 'Winney', 'pwinneyw@blogspot.com', '543-565-8147', '2024-02-22 10:42:00'),
(34, 'Hayes', 'Shalloe', 'Dugald', 'hdugaldx@japanpost.jp', '847-252-6704', '2023-12-12 20:15:00'),
(35, 'Marcos', 'Yearron', 'Antognozzii', 'mantognozziiy@hatena.ne.jp', '865-141-9624', '2023-08-07 20:20:00'),
(36, 'Leslie', 'Starbuck', 'De Mitri', 'ldemitriz@nbcnews.com', '957-365-4302', '2023-09-18 12:53:00'),
(37, 'Dulcinea', 'Aliberti', 'Follows', 'dfollows10@reddit.com', '143-713-0774', '2023-12-12 02:21:00'),
(38, 'Lisbeth', 'Carbin', 'Dyshart', 'ldyshart11@booking.com', '800-725-6078', '2023-10-10 01:59:00'),
(39, 'Darrick', 'Ricson', 'Braddon', 'dbraddon12@loc.gov', '996-393-2573', '2023-12-23 22:40:00'),
(40, 'Yvette', 'Screase', 'Codrington', 'ycodrington13@merriam-webster.com', '565-576-3268', '2023-06-20 21:30:00'),
(41, 'Idette', 'Allardyce', 'Diss', 'idiss14@forbes.com', '774-617-4762', '2023-06-14 16:41:00'),
(42, 'Cornelle', 'Rothman', 'Metzing', 'cmetzing15@xrea.com', '250-137-7885', '2023-07-16 21:51:00'),
(43, 'Gregoire', 'Lidgett', 'Saggers', 'gsaggers16@google.es', '687-176-9115', '2023-11-18 15:22:00'),
(44, 'Elicia', 'Roscamps', 'Cridlin', 'ecridlin17@microsoft.com', '513-962-7598', '2023-11-08 09:14:00'),
(45, 'Ulises', 'Dechelette', 'Trahair', 'utrahair18@furl.net', '970-437-1946', '2024-01-19 00:50:00'),
(46, 'Mead', 'Loy', 'Bortoluzzi', 'mbortoluzzi19@businessinsider.com', '678-237-6534', '2023-05-21 16:48:00'),
(47, 'Guss', 'Yanez', 'Bowling', 'gbowling1a@mtv.com', '173-580-4780', '2023-11-21 21:07:00'),
(48, 'Gaye', 'Absolom', 'Cowe', 'gcowe1b@quantcast.com', '369-375-7616', '2023-11-21 05:21:00'),
(49, 'Reuven', 'Downham', 'Broxton', 'rbroxton1c@oracle.com', '830-975-0783', '2023-08-01 17:14:00'),
(50, 'Renate', 'Oehm', 'Leverington', 'rleverington1d@multiply.com', '183-455-4375', '2023-06-28 01:16:00'),
(51, 'Jaimie', 'Lagne', 'Salmond', 'jsalmond1e@disqus.com', '644-937-9406', '2024-03-02 23:54:00'),
(52, 'Prentice', 'Meaton', 'Esome', 'pesome1f@yahoo.co.jp', '173-400-3847', '2023-05-28 04:49:00'),
(53, 'Micheil', 'Sackett', 'Charter', 'mcharter1g@imdb.com', '459-726-3446', '2023-10-24 04:00:00'),
(54, 'Hyacinthie', 'Stollenhof', 'Franzoli', 'hfranzoli1h@adobe.com', '109-154-9388', '2023-06-25 04:22:00'),
(55, 'Vally', 'Burles', 'Cammack', 'vcammack1i@smh.com.au', '229-139-7574', '2023-05-08 05:46:00'),
(56, 'Alma', 'Kittel', 'Deboy', 'adeboy1j@deliciousdays.com', '584-369-4793', '2023-04-17 01:18:00'),
(57, 'Ozzie', 'Sanchez', 'Tzuker', 'otzuker1k@prlog.org', '673-547-2589', '2023-07-09 15:56:00'),
(58, 'Godard', 'Tomeo', 'Jirick', 'gjirick1l@tinyurl.com', '899-640-3999', '2023-04-20 11:34:00'),
(59, 'Morty', 'Gavrielli', 'Lemme', 'mlemme1m@mozilla.com', '314-797-7644', '2023-07-28 00:28:00'),
(60, 'Birgitta', 'Salzburg', 'Doward', 'bdoward1n@who.int', '156-921-8826', '2024-03-20 12:29:00');


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

INSERT INTO Accounts (Account_id, Balance, AccountType, Date_created) VALUES
(1, 7875, 'checking', '2020-10-04 00:09:00'),
(2, 9170, 'high interest', '2023-05-10 21:18:00'),
(3, 2197, 'investment', '2023-04-30 11:59:00'),
(4, 3244, 'joint', '2022-06-20 18:12:00'),
(5, 4956, 'business', '2022-08-06 22:03:00'),
(6, 2959, 'student', '2023-03-18 23:46:00'),
(7, 2097, 'online', '2022-09-17 13:27:00'),
(8, 9491, 'business', '2022-12-24 14:30:00'),
(9, 1069, 'joint', '2021-07-25 11:08:00'),
(10, 2815, 'retirement', '2020-06-15 23:27:00'),
(11, 3097, 'joint', '2021-12-15 15:05:00'),
(12, 7021, 'high interest', '2022-02-13 22:38:00'),
(13, 6733, 'investment', '2023-01-21 02:34:00'),
(14, 4597, 'savings', '2019-11-17 03:12:00'),
(15, 8202, 'retirement', '2024-03-06 19:59:00'),
(16, 3244, 'money market', '2023-12-03 05:54:00'),
(17, 7185, 'joint', '2020-07-13 20:33:00'),
(18, 2178, 'high interest', '2024-04-02 01:22:00'),
(19, 1205, 'investment', '2023-01-07 00:44:00'),
(20, 2071, 'online', '2020-02-02 21:25:00'),
(21, 1570, 'checking', '2021-09-14 17:32:00'),
(22, 6251, 'checking', '2024-04-07 12:09:00'),
(23, 3407, 'investment', '2023-09-23 21:03:00'),
(24, 4757, 'joint', '2022-12-28 20:16:00'),
(25, 4385, 'joint', '2022-09-01 14:58:00'),
(26, 7530, 'savings', '2019-11-22 07:08:00'),
(27, 6492, 'checking', '2021-04-01 19:04:00'),
(28, 8287, 'checking', '2023-08-21 07:06:00'),
(29, 83, 'online', '2020-02-14 22:05:00'),
(30, 1614, 'investment', '2021-02-13 04:40:00'),
(31, 8604, 'online', '2022-03-30 23:44:00'),
(32, 7463, 'savings', '2022-02-03 07:47:00'),
(33, 3031, 'student', '2023-07-26 16:33:00'),
(34, 2530, 'investment', '2023-03-20 18:08:00'),
(35, 1586, 'retirement', '2023-03-14 07:58:00'),
(36, 7870, 'investment', '2022-10-01 02:06:00'),
(37, 4105, 'student', '2021-06-26 06:57:00'),
(38, 5143, 'investment', '2019-12-21 03:30:00'),
(39, 3479, 'student', '2023-11-18 20:02:00'),
(40, 3834, 'investment', '2021-12-08 09:11:00'),
(41, 6012, 'money market', '2024-03-24 21:26:00'),
(42, 8361, 'money market', '2024-03-23 01:01:00'),
(43, 4455, 'checking', '2020-09-15 00:13:00'),
(44, 9869, 'money market', '2023-03-30 19:58:00'),
(45, 6984, 'business', '2021-09-01 07:08:00'),
(46, 7318, 'investment', '2021-01-30 22:02:00'),
(47, 9013, 'retirement', '2023-08-31 19:03:00'),
(48, 6488, 'online', '2021-01-20 15:49:00'),
(49, 5169, 'checking', '2021-01-23 23:54:00'),
(50, 2786, 'online', '2020-09-04 01:22:00'),
(51, 4070, 'student', '2024-03-10 09:36:00'),
(52, 1606, 'student', '2023-04-10 01:53:00'),
(53, 4019, 'business', '2020-04-25 00:06:00'),
(54, 5914, 'student', '2022-06-08 14:54:00'),
(55, 3538, 'money market', '2021-10-23 07:57:00'),
(56, 7975, 'business', '2020-05-09 08:09:00'),
(57, 5875, 'checking', '2020-10-23 07:17:00'),
(58, 3772, 'online', '2022-03-25 04:01:00'),
(59, 6433, 'savings', '2022-12-12 15:34:00'),
(60, 4475, 'student', '2022-04-18 18:27:00');

INSERT INTO Goals (Goal_id, Name, Date, TotalFund, SavedSoFar) VALUES
(1, 'vacation', '2024-03-22 03:17:00', 947, 0),
(2, 'gaming console', '2023-08-31 13:10:00', 745, 389),
(3, 'vintage collectibles', '2023-06-12 19:26:00', 929, 0),
(4, 'wine tasting', '2023-06-17 02:45:00', 180, 0),
(5, 'new car', '2023-11-10 18:49:00', 300, 204),
(6, 'kitchen renovation', '2024-03-29 06:34:00', 832, 417),
(7, 'new stove', '2024-02-15 06:29:00', 489, 0),
(8, 'new pet', '2023-11-23 10:08:00', 793, 0),
(9, 'child''s education fund', '2023-08-01 14:42:00', 668, 0),
(10, 'gaming console', '2023-04-19 13:32:00', 824, 0),
(11, 'vacation', '2023-11-04 19:50:00', 254, 0),
(12, 'concert tickets', '2024-02-13 15:04:00', 809, 0),
(13, 'home down payment', '2023-10-20 01:57:00', 361, 292),
(14, 'gaming console', '2024-04-01 08:07:00', 412, 0),
(15, 'wine tasting', '2023-05-16 23:30:00', 391, 198),
(16, 'new pet', '2023-09-23 03:13:00', 391, 126),
(17, 'new computer', '2023-07-20 01:51:00', 867, 0),
(18, 'home down payment', '2023-10-06 06:15:00', 883, 0),
(19, 'kitchen renovation', '2023-11-09 15:38:00', 775, 0),
(20, 'child''s education fund', '2023-11-12 16:43:00', 494, 342),
(21, 'vacation', '2023-12-30 12:24:00', 231, 128),
(22, 'kitchen renovation', '2023-08-01 08:49:00', 576, 485),
(23, 'new pet', '2023-07-20 15:17:00', 546, 0),
(24, 'concert tickets', '2024-03-16 08:37:00', 884, 443),
(25, 'new car', '2023-10-21 02:05:00', 326, 207),
(26, 'child''s education fund', '2023-07-04 03:45:00', 489, 0),
(27, 'home down payment', '2023-10-15 02:54:00', 433, 407),
(28, 'spa day', '2023-12-04 05:26:00', 445, 0),
(29, 'clothing haul', '2023-08-21 11:00:00', 457, 319),
(30, 'concert tickets', '2023-12-25 20:53:00', 202, 119),
(31, 'concert tickets', '2023-08-02 01:29:00', 123, 120),
(32, 'vacation', '2023-07-13 13:50:00', 251, 232),
(33, 'child''s education fund', '2023-08-22 05:19:00', 879, 0),
(34, 'child''s education fund', '2024-02-05 07:54:00', 746, 0),
(35, 'new pet', '2023-12-27 01:49:00', 896, 0),
(36, 'new stove', '2023-12-11 06:54:00', 435, 394),
(37, 'new car', '2024-01-09 00:20:00', 652, 0),
(38, 'home down payment', '2023-06-14 17:59:00', 372, 0),
(39, 'clothing haul', '2023-07-21 18:31:00', 158, 122),
(40, 'kitchen renovation', '2024-01-09 16:42:00', 459, 295),
(41, 'child''s education fund', '2023-10-15 05:24:00', 685, 0),
(42, 'child''s education fund', '2024-02-14 11:29:00', 566, 0),
(43, 'spa day', '2023-11-01 14:19:00', 866, 0),
(44, 'wine tasting', '2023-05-24 08:36:00', 451, 340),
(45, 'wine tasting', '2023-10-12 08:39:00', 516, 418),
(46, 'kitchen renovation', '2023-11-25 06:47:00', 475, 282),
(47, 'new computer', '2023-08-18 23:25:00', 436, 376),
(48, 'clothing haul', '2023-12-02 21:13:00', 690, 469),
(49, 'new computer', '2023-12-25 21:55:00', 557, 0),
(50, 'new computer', '2023-05-30 05:40:00', 618, 0),
(51, 'new computer', '2024-03-04 01:45:00', 445, 255),
(52, 'wine tasting', '2024-02-03 13:42:00', 990, 0),
(53, 'gaming console', '2023-10-17 21:06:00', 166, 151),
(54, 'vintage collectibles', '2023-12-19 22:01:00', 188, 156),
(55, 'new computer', '2024-02-01 22:41:00', 563, 0),
(56, 'spa day', '2023-11-11 00:51:00', 754, 0),
(57, 'clothing haul', '2023-05-16 23:52:00', 234, 146),
(58, 'new stove', '2023-05-08 15:44:00', 627, 0),
(59, 'vacation', '2024-01-29 08:38:00', 609, 410),
(60, 'gaming console', '2024-02-15 19:15:00', 569, 0);


INSERT INTO Investments (Investment_id, Type, Description, Date, Amount, Account_id)
VALUES
(1, 'stocks', 'Ownership shares in a company', '2024-01-20 12:57:33', 55, 19),
(2, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '2023-09-12 09:18:42', 392, 26),
(3, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '2023-08-02 18:37:29', 292, 49),
(4, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '2024-02-20 21:05:08', 518, 5),
(5, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '2023-09-08 06:49:17', 652, 4),
(6, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '2023-05-25 16:28:54', 861, 56),
(7, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '2023-12-08 08:13:22', 781, 26),
(8, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '2023-06-19 17:39:08', 917, 4),
(9, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '2023-11-13 14:27:56', 542, 46),
(10, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '2023-07-23 20:09:34', 434, 1),
(11, 'stocks', 'Ownership shares in a company', '2024-01-22 23:18:07', 876, 56),
(12, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '2023-09-18 10:27:49', 679, 49),
(13, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '2023-09-27 19:45:37', 244, 57),
(14, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '2023-10-21 07:38:16', 753, 25),
(15, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '2024-02-19 04:32:50', 545, 42),
(16, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '2024-01-09 18:24:59', 892, 38),
(17, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '2023-11-13 22:59:30', 871, 45),
(18, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '2023-09-14 05:20:41', 655, 53),
(19, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '2024-03-20 14:48:23', 632, 33),
(20, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '2023-11-22 07:11:38', 136, 19),
(21, 'stocks', 'Ownership shares in a company', '2023-09-12 08:59:04', 27, 60),
(22, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '2024-01-17 05:47:20', 871, 17),
(23, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '2024-01-14 13:58:31', 476, 11),
(24, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '2024-03-30 16:40:09', 619, 37),
(25, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '2023-12-02 17:24:50', 243, 41),
(26, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '2023-06-30 08:12:57', 481, 30),
(27, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '2023-09-19 23:56:15', 164, 6),
(28, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '2024-03-30 22:02:47', 202, 30),
(29, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '2024-02-29 18:59:38', 98, 8),
(30, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '2023-07-11 13:02:17', 372, 25),
(31, 'stocks', 'Ownership shares in a company', '2023-08-07 11:28:35', 22, 41),
(32, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '2023-11-13 20:57:46', 882, 18),
(33, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '2023-11-23 23:37:55', 713, 55),
(34, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '2023-06-11 03:05:57', 167, 15),
(35, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '2023-04-12 02:29:49', 155, 29),
(36, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '2024-03-26 16:39:20', 848, 28),
(37, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '2023-12-22 21:09:33', 22, 7),
(38, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '2023-08-29 17:41:58', 338, 3),
(39, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '2023-07-19 08:47:41', 223, 58),
(40, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '2023-07-11 19:43:28', 665, 27),
(41, 'stocks', 'Ownership shares in a company', '2023-12-08 14:15:09', 394, 10),
(42, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '2023-08-20 13:21:24', 3, 47),
(43, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '2023-12-21 11:46:18', 289, 12),
(44, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '2023-09-09 08:08:58', 976, 50),
(45, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '2023-08-01 07:18:29', 649, 54),
(46, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '2023-10-12 15:23:51', 388, 51),
(47, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '2024-01-25 03:46:09', 605, 45),
(48, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '2024-01-01 05:29:27', 72, 46),
(49, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '2023-11-04 04:22:01', 890, 16),
(50, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '2024-04-11 10:36:52', 255, 24),
(51, 'stocks', 'Ownership shares in a company', '2023-07-19 07:01:15', 215, 60),
(52, 'bonds', 'Debt securities where investors lend money to an entity in exchange for interest payments over time', '2023-04-26 22:31:34', 686, 44),
(53, 'real estate', 'Investments in physical properties such as residential commercial or industrial real estate', '2023-07-08 01:12:19', 557, 40),
(54, 'mutual funds', 'Pooled funds from various investors to invest in a diversified portfolio of stocks bonds or other securities', '2023-06-25 13:06:38', 142, 25),
(55, 'cryptocurrency', 'Digital or virtual currencies secured by cryptography such as Bitcoin or Ethereum', '2023-10-13 11:29:24', 949, 4),
(56, 'commodities', 'Raw materials or primary agricultural products that are bought and sold such as gold oil or wheat', '2023-10-02 18:52:47', 777, 38),
(57, 'peer-to-peer lending', 'Platforms that connect borrowers with lenders for loans without the involvement of traditional financial institutions', '2024-01-24 02:14:37', 594, 30),
(58, 'options', 'Contracts that give the holder the right but not the obligation to buy or sell an asset at a predetermined price within a specified time period', '2023-04-19 14:27:58', 804, 13),
(59, 'ETFs', 'Investment funds traded on stock exchanges that hold assets such as stocks bonds or commodities and generally operate with an arbitrage mechanism', '2023-09-11 23:51:38', 773, 11),
(60, 'retirement accounts', 'Accounts specifically designed to help individuals save for retirement such as 401(k)s or IRAs (Individual Retirement Accounts) or pension plans', '2023-06-18 10:24:19', 575, 36);


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
(44, 2),
(8, 53),
(26, 1),
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
(3, 39),
(48, 58),
(24, 1),
(10, 27),
(5, 17),
(37, 15),
(28, 36),
(9, 20),
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
(54, 15),
(29, 34),
(60, 46),
(12, 38),
(14, 15),
(54, 59),
(27, 40),
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
(31, 9),
(49, 16),
(27, 5),
(32, 30),
(20, 5),
(41, 2),
(6, 50),
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
(33, 52),
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
(7, 41),
(46, 42),
(57, 5),
(12, 55),
(2, 15),
(8, 8),
(11, 24),
(27, 54),
(5, 42),
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
(1, '2023-05-12 14:05:00', 'rent', 27, 55),
(2, '2023-07-08 14:47:00', 'shopping bill', 29, 58),
(3, '2023-04-20 04:17:00', 'utilities bill', 4, 8),
(4, '2023-08-05 16:58:00', 'shopping bill', 41, 48),
(5, '2023-12-04 12:46:00', 'utilities bill', 32, 47),
(6, '2023-10-14 23:29:00', 'ordered books and media', 46, 44),
(7, '2023-06-19 19:07:00', 'groceries bill', 48, 6),
(8, '2023-09-19 14:42:00', 'healthcare bill', 4, 36),
(9, '2023-11-15 17:41:00', 'theater tickets', 60, 18),
(10, '2024-01-26 01:58:00', 'charlie card tickets', 24, 24),
(11, '2023-11-11 20:01:00', 'kitchen renovation bill', 16, 24),
(12, '2023-06-15 09:47:00', 'back to school clothes bill', 7, 8),
(13, '2023-05-22 08:05:00', 'utilities bill', 30, 24),
(14, '2023-06-19 17:08:00', 'new shoes bill', 34, 7),
(15, '2023-12-03 11:19:00', 'movie tickets bill', 50, 42),
(16, '2024-02-16 04:18:00', 'ballet tickets bill', 31, 24),
(17, '2024-03-29 02:24:00', 'bill for new deck', 29, 4),
(18, '2023-09-01 00:50:00', 'bill for landscaping', 37, 59),
(19, '2023-11-29 08:35:00', 'new clothes credit card bill', 8, 12),
(20, '2023-08-23 17:57:00', 'HBO max subscription', 2, 42),
(21, '2023-08-02 02:02:00', 'utilities bill', 17, 6),
(22, '2023-09-16 18:24:00', 'paying final donations to charity', 19, 41),
(23, '2023-12-08 21:23:00', 'bill for painting the house', 6, 55),
(24, '2023-06-18 20:37:00', 'bill for contractor', 18, 17),
(25, '2023-05-22 23:42:00', 'bill for new macbook', 16, 53),
(26, '2024-01-19 08:25:00', 'gucci clothes bill', 56, 7),
(27, '2023-04-27 21:15:00', 'utilities bill', 47, 3),
(28, '2023-09-19 16:07:00', 'rent bill', 19, 40),
(29, '2023-11-29 15:35:00', 'new shoes bill', 35, 29),
(30, '2023-09-07 14:30:00', 'shopping bill', 29, 56),
(31, '2024-01-22 04:04:00', 'back to school clothes bill', 16, 33),
(32, '2023-11-25 23:39:00', 'utilities bill', 48, 58),
(33, '2024-01-20 04:46:00', 'Hannahford super customer subscription', 20, 41),
(34, '2023-11-05 02:11:00', 'bill for latest charlie card semester pass', 10, 37),
(35, '2023-06-23 16:30:00', 'utilities bill', 32, 55),
(36, '2024-03-08 05:41:00', 'bill for latest clothing haul', 39, 25),
(37, '2023-10-22 05:06:00', 'rent bill', 19, 44),
(38, '2023-08-12 04:47:00', 'utilities bill', 36, 31),
(39, '2023-04-20 05:33:00', 'back to school clothes bill', 11, 21),
(40, '2024-01-22 16:53:00', 'BJs subscription', 5, 33),
(41, '2023-07-26 10:07:00', 'utilities bill', 29, 28),
(42, '2023-12-18 16:03:00', 'utilities bill', 56, 42),
(43, '2023-04-12 14:28:00', 'hospital bill for surgery', 27, 4),
(44, '2023-09-04 05:44:00', 'bought old video game collectibles', 43, 8),
(45, '2023-11-02 20:08:00', 'theater tickets', 60, 48),
(46, '2023-09-20 07:38:00', 'bill for landscaping', 18, 39),
(47, '2023-12-06 11:51:00', 'groceries bill', 3, 43),
(48, '2024-03-20 07:33:00', 'bill for painting the house', 21, 1),
(49, '2023-06-26 21:35:00', 'back to school clothes bill', 28, 56),
(50, '2023-05-18 11:57:00', 'utilities bill', 42, 38),
(51, '2023-09-26 12:19:00', 'utilities bill', 4, 2),
(52, '2023-07-21 02:16:00', 'kitchen renovation bill', 40, 16),
(53, '2024-03-11 21:25:00', 'rent bill', 2, 6),
(54, '2024-03-22 15:45:00', 'Netflix', 15, 15),
(55, '2023-07-10 22:40:00', 'bill for contractor', 6, 57),
(56, '2023-10-14 12:58:00', 'rent bill', 38, 34),
(57, '2023-06-06 19:43:00', 'baseball game tickets', 34, 54),
(58, '2023-04-29 07:19:00', 'bought airplane tickets', 57, 26),
(59, '2024-01-17 01:58:00', 'utilities bill', 13, 20),
(60, '2024-01-22 05:47:00', 'theater tickets', 12, 10);


INSERT INTO Transactions (Transaction_id, Amount, Date, Account_id, Category_id, Goal_id, Description)
VALUES
(1, 698, '2023-07-21 09:37:18', 16, 1, NULL, 'bought dinner ingredients'),
(2, 884, '2024-03-21 15:20:45', 42, 11, 12, 'bought a new macbook'),
(3, 281, '2023-12-12 06:54:32', 55, 5, NULL, 'bought a charlie pass for the semester'),
(4, 172, '2023-10-12 18:02:11', 41, 9, NULL, 'donated to the local homeless shelter'),
(5, 26, '2023-08-01 11:28:59', 53, 7, 26, 'bought new workout clothes'),
(6, 229, '2023-11-09 22:39:17', 30, 9, NULL, 'donated to the food pantry'),
(7, 886, '2023-08-19 07:55:36', 27, 2, NULL, 'paid electricity'),
(8, 873, '2024-02-19 05:14:28', 38, 10, 48, 'bought new tiles for the kitchen backsplash'),
(9, 801, '2023-09-10 16:21:50', 27, 11, 39, 'bought a new dell computer'),
(10, 126, '2024-01-18 00:37:42', 22, 10, NULL, 'bought a new rug'),
(11, 479, '2024-01-09 03:59:21', 46, 1, NULL, 'bought smoothie ingredients'),
(12, 69, '2023-10-23 14:08:13', 32, 2, NULL, 'paid for house utilities'),
(13, 327, '2023-07-29 19:46:54', 24, 9, NULL, 'gave to local charity'),
(14, 346, '2024-03-26 10:27:03', 14, 11, 36, 'bought old video game collectibles'),
(15, 141, '2024-03-08 20:59:31', 40, 12, 35, 'bought a bed for dog I want to get soon'),
(16, 366, '2023-04-21 14:38:05', 52, 9, NULL, 'gave to the homeless'),
(17, 992, '2023-11-20 08:43:02', 3, 9, NULL, 'game to the womens shelter'),
(18, 158, '2024-04-05 02:11:27', 51, 8, NULL, 'bought kids textbooks'),
(19, 341, '2023-10-30 19:29:59', 47, 8, 18, 'put into my childs education fund'),
(20, 669, '2023-11-04 13:28:04', 50, 14, 21, 'bought concert tickets and merch'),
(21, 604, '2023-08-14 23:07:38', 27, 7, NULL, 'bought a new bag'),
(22, 288, '2023-08-02 04:55:16', 8, 12, NULL, 'dog food and dog medicine'),
(23, 466, '2024-03-21 11:32:59', 53, 1, NULL, 'ingredients for pizza dinner'),
(24, 199, '2024-01-12 13:40:22', 15, 9, NULL, 'gave to womens shelter downtown'),
(25, 801, '2023-06-02 20:03:17', 46, 5, NULL, 'bought airplane tickets'),
(26, 395, '2024-01-28 17:16:48', 17, 1, NULL, 'bought groceries for the week'),
(27, 662, '2023-12-12 23:29:38', 47, 11, 20, 'bought new xbox'),
(28, 105, '2023-09-29 06:45:59', 37, 8, 32, 'bought new notebooks'),
(29, 902, '2024-03-16 05:12:33', 51, 1, 13, 'got wine'),
(30, 763, '2023-09-15 09:28:11', 59, 6, NULL, 'paid for doctors visit'),
(31, 837, '2023-08-01 02:30:57', 9, 13, NULL, 'got new shoes'),
(32, 851, '2023-04-25 08:39:02', 20, 14, NULL, 'bought books in a series'),
(33, 350, '2023-10-08 17:53:20', 30, 12, NULL, 'got new bedding for hamster'),
(34, 523, '2024-01-13 19:54:11', 38, 4, 11, 'paid for a trip to the ballet'),
(35, 652, '2023-05-02 14:30:47', 14, 13, NULL, 'got new clothes'),
(36, 359, '2024-01-14 18:47:33', 29, 9, NULL, 'gave to the homeless shelter'),
(37, 354, '2024-04-06 23:12:19', 41, 7, NULL, 'got new office supplies'),
(38, 755, '2024-03-26 11:55:08', 60, 1, NULL, 'bought groceries'),
(39, 975, '2023-05-22 10:28:39', 10, 3, NULL, 'paid rent to landlord'),
(40, 939, '2024-03-31 13:01:17', 36, 6, NULL, 'paid for surgery'),
(41, 397, '2024-03-14 20:19:46', 13, 8, NULL, 'bought back to school items'),
(42, 184, '2023-09-25 07:58:24', 50, 11, 60, 'bought new switch'),
(43, 834, '2024-01-17 22:01:31', 32, 5, NULL, 'bought plane tickets'),
(44, 484, '2023-07-08 03:15:58', 59, 10, 59, 'bought a new stove'),
(45, 688, '2023-09-12 16:30:29', 54, 2, NULL, 'paid for plumber visit'),
(46, 27, '2023-04-18 10:23:54', 31, 7, NULL, 'went shopping at the mall'),
(47, 829, '2023-11-30 21:05:42', 17, 1, NULL, 'bought groceries'),
(48, 618, '2023-12-06 04:59:03', 49, 9, NULL, 'gave to homeless youth in need'),
(49, 621, '2024-02-03 16:49:08', 33, 10, NULL, 'got new tile floors'),
(50, 723, '2023-12-10 19:32:47', 11, 4, NULL, 'paying for entertainment subscriptions'),
(51, 660, '2023-10-14 05:27:18', 52, 6, NULL, 'bought medicine after doctors visit'),
(52, 212, '2023-05-25 18:12:36', 5, 8, NULL, 'got a backpack for school'),
(53, 704, '2023-10-01 01:18:51', 16, 11, NULL, 'new headphones'),
(54, 80, '2023-10-03 17:28:04', 7, 14, NULL, 'new books'),
(55, 98, '2024-02-24 08:45:29', 43, 3, NULL, 'paid rent'),
(56, 123, '2023-04-17 14:39:50', 4, 13, 17, 'got new clothes'),
(57, 416, '2023-06-29 05:57:12', 19, 5, NULL, 'got train ticket back home'),
(58, 748, '2024-01-28 19:52:31', 47, 2, NULL, 'paid utilities for multiple missed months'),
(59, 5, '2023-05-16 22:13:44', 44, 12, NULL, 'bought treats for my cat'),
(60, 769, '2023-10-14 13:48:59', 35, 2, NULL, 'paid utilities for previously missed months');




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


INSERT INTO Articles (Article_id, Title, User_id, Content, UploadDate) VALUES
(1, 'Financial Analysis Report', 45, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-10-07 22:30:00'),
(2, 'Wealth Management Tips', 16, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-08-19 11:32:00'),
(3, 'Wealth Management Tips', 48, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2024-02-22 01:54:00'),
(4, 'Investment Strategies', 11, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2024-03-06 07:12:00'),
(5, 'Financial Analysis Report', 40, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-12-16 22:08:00'),
(6, 'Economic Forecasting', 56, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2024-01-16 20:51:00'),
(7, 'Stock Market Trends', 15, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-06-19 20:38:00'),
(8, 'Economic Forecasting', 42, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-06-24 02:33:00'),
(9, 'Economic Forecasting', 3, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-10-16 20:37:00'),
(10, 'Wealth Management Tips', 53, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2024-02-07 22:08:00'),
(11, 'Investment Strategies', 32, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-08-06 22:57:00'),
(12, 'Investment Strategies', 6, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-10-29 11:29:00'),
(13, 'Stock Market Trends', 46, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2024-04-07 20:37:00'),
(14, 'Stock Market Trends', 2, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-04-24 16:31:00'),
(15, 'Wealth Management Tips', 55, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2024-01-24 09:25:00'),
(16, 'Financial Analysis Report', 59, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-10-16 02:07:00'),
(17, 'Investment Strategies', 22, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-12-12 08:51:00'),
(18, 'Stock Market Trends', 35, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2024-02-09 16:19:00'),
(19, 'Investment Strategies', 33, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-04-20 17:01:00'),
(20, 'Investment Strategies', 1, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-05-24 15:52:00'),
(21, 'Wealth Management Tips', 27, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-11-14 12:32:00'),
(22, 'Stock Market Trends', 31, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2024-02-09 03:21:00'),
(23, 'Wealth Management Tips', 24, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-11-08 14:28:00'),
(24, 'Financial Analysis Report', 4, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-07-02 07:41:00'),
(25, 'Economic Forecasting', 50, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-12-02 10:07:00'),
(26, 'Wealth Management Tips', 13, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-05-22 08:10:00'),
(27, 'Economic Forecasting', 41, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-11-17 16:42:00'),
(28, 'Economic Forecasting', 25, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-09-08 07:26:00'),
(29, 'Stock Market Trends', 37, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-04-20 21:12:00'),
(30, 'Wealth Management Tips', 43, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-05-27 10:30:00'),
(31, 'Economic Forecasting', 47, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-09-25 20:03:00'),
(32, 'Wealth Management Tips', 44, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-10-23 21:00:00'),
(33, 'Wealth Management Tips', 5, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-04-28 02:03:00'),
(34, 'Economic Forecasting', 9, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-10-03 12:10:00'),
(35, 'Economic Forecasting', 34, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-09-01 09:31:00'),
(36, 'Investment Strategies', 28, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-05-29 13:15:00'),
(37, 'Wealth Management Tips', 12, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-11-06 21:54:00'),
(38, 'Stock Market Trends', 21, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-10-17 04:16:00'),
(39, 'Investment Strategies', 8, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-09-30 01:24:00'),
(40, 'Economic Forecasting', 54, 'The stock market reached new highs as tech companies reported strong earnings.', '2024-01-09 15:25:00'),
(41, 'Investment Strategies', 58, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-11-12 23:45:00'),
(42, 'Financial Analysis Report', 51, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-04-14 11:53:00'),
(43, 'Investment Strategies', 29, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-12-26 11:31:00'),
(44, 'Investment Strategies', 18, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2024-01-26 01:43:00'),
(45, 'Economic Forecasting', 20, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-05-21 15:22:00'),
(46, 'Financial Analysis Report', 7, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-08-10 00:17:00'),
(47, 'Stock Market Trends', 19, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2024-04-02 04:55:00'),
(48, 'Economic Forecasting', 23, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-11-17 16:41:00'),
(49, 'Wealth Management Tips', 36, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2023-12-23 10:54:00'),
(50, 'Wealth Management Tips', 38, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-05-15 02:02:00'),
(51, 'Stock Market Trends', 30, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2024-03-14 05:25:00'),
(52, 'Stock Market Trends', 60, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-11-03 14:02:00'),
(53, 'Wealth Management Tips', 57, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2024-02-05 03:21:00'),
(54, 'Investment Strategies', 39, 'Investors are advised to diversify their portfolios to mitigate risk in uncertain economic times.', '2024-03-20 01:13:00'),
(55, 'Wealth Management Tips', 52, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-09-09 12:08:00'),
(56, 'Wealth Management Tips', 10, 'The stock market reached new highs as tech companies reported strong earnings.', '2024-01-10 22:44:00'),
(57, 'Investment Strategies', 17, 'Financial markets are showing volatility today as investors react to the latest economic data.', '2023-10-10 06:46:00'),
(58, 'Financial Analysis Report', 49, 'The stock market reached new highs as tech companies reported strong earnings.', '2023-09-23 19:27:00'),
(59, 'Economic Forecasting', 26, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2023-05-26 21:16:00'),
(60, 'Investment Strategies', 14, 'Analysts predict a potential recession in the housing market due to rising interest rates.', '2024-02-02 18:53:00');



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
insert into ArticleTags (Article_id, Tag_id) values ('35', '26');
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
insert into ArticleTags (Article_id, Tag_id) values ('43', '31');
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
insert into ArticleTags (Article_id, Tag_id) values ('49', '48');
insert into ArticleTags (Article_id, Tag_id) values ('53', '30');
insert into ArticleTags (Article_id, Tag_id) values ('58', '46');
insert into ArticleTags (Article_id, Tag_id) values ('30', '3');
insert into ArticleTags (Article_id, Tag_id) values ('12', '40');
insert into ArticleTags (Article_id, Tag_id) values ('23', '51');
insert into ArticleTags (Article_id, Tag_id) values ('24', '18');
insert into ArticleTags (Article_id, Tag_id) values ('42', '12');
insert into ArticleTags (Article_id, Tag_id) values ('59', '10');
insert into ArticleTags (Article_id, Tag_id) values ('6', '56');
insert into ArticleTags (Article_id, Tag_id) values ('16', '14');
insert into ArticleTags (Article_id, Tag_id) values ('14', '28');
insert into ArticleTags (Article_id, Tag_id) values ('52', '36');
insert into ArticleTags (Article_id, Tag_id) values ('50', '7');
insert into ArticleTags (Article_id, Tag_id) values ('15', '5');
insert into ArticleTags (Article_id, Tag_id) values ('29', '24');
insert into ArticleTags (Article_id, Tag_id) values ('4', '20');
insert into ArticleTags (Article_id, Tag_id) values ('46', '30');
insert into ArticleTags (Article_id, Tag_id) values ('26', '35');
insert into ArticleTags (Article_id, Tag_id) values ('7', '6');
insert into ArticleTags (Article_id, Tag_id) values ('36', '54');
insert into ArticleTags (Article_id, Tag_id) values ('41', '38');
insert into ArticleTags (Article_id, Tag_id) values ('60', '1');
insert into ArticleTags (Article_id, Tag_id) values ('48', '13');
insert into ArticleTags (Article_id, Tag_id) values ('1', '27');
insert into ArticleTags (Article_id, Tag_id) values ('37', '58');
insert into ArticleTags (Article_id, Tag_id) values ('47', '49');
insert into ArticleTags (Article_id, Tag_id) values ('56', '42');
insert into ArticleTags (Article_id, Tag_id) values ('1', '19');
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
insert into ArticleTags (Article_id, Tag_id) values ('55', '54');
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
insert into AccountInfo (User_id, Account_id) values ('56', '11');
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
insert into AccountInfo (User_id, Account_id) values ('45', '54');
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
insert into AccountInfo (User_id, Account_id) values ('56', '13');
insert into AccountInfo (User_id, Account_id) values ('2', '16');
insert into AccountInfo (User_id, Account_id) values ('7', '6');
insert into AccountInfo (User_id, Account_id) values ('29', '48');
insert into AccountInfo (User_id, Account_id) values ('22', '59');
insert into AccountInfo (User_id, Account_id) values ('38', '19');
insert into AccountInfo (User_id, Account_id) values ('6', '15');
insert into AccountInfo (User_id, Account_id) values ('31', '25');
insert into AccountInfo (User_id, Account_id) values ('47', '49');
insert into AccountInfo (User_id, Account_id) values ('34', '6');
insert into AccountInfo (User_id, Account_id) values ('4', '43');
insert into AccountInfo (User_id, Account_id) values ('10', '47');
insert into AccountInfo (User_id, Account_id) values ('53', '27');
insert into AccountInfo (User_id, Account_id) values ('14', '19');
insert into AccountInfo (User_id, Account_id) values ('45', '19');
insert into AccountInfo (User_id, Account_id) values ('35', '59');
insert into AccountInfo (User_id, Account_id) values ('27', '35');
insert into AccountInfo (User_id, Account_id) values ('7', '37');
insert into AccountInfo (User_id, Account_id) values ('32', '6');
insert into AccountInfo (User_id, Account_id) values ('16', '3');
insert into AccountInfo (User_id, Account_id) values ('1', '52');
insert into AccountInfo (User_id, Account_id) values ('36', '27');
insert into AccountInfo (User_id, Account_id) values ('33', '32');
insert into AccountInfo (User_id, Account_id) values ('20', '51');
insert into AccountInfo (User_id, Account_id) values ('37', '5');
insert into AccountInfo (User_id, Account_id) values ('50', '20');
insert into AccountInfo (User_id, Account_id) values ('5', '49');
insert into AccountInfo (User_id, Account_id) values ('59', '25');
insert into AccountInfo (User_id, Account_id) values ('41', '30');
insert into AccountInfo (User_id, Account_id) values ('30', '26');
insert into AccountInfo (User_id, Account_id) values ('60', '8');

insert into Users
values (61, "Robert", "R", "Robertson", "rrr@gmail.com", "603-820-2043", "1982-05-31 09:52:36"), 
(62, "Sally", "S", "Sallyson", "sss@yahoo.com", "251-982-5306", "2000-06-16 08:00:00"), 
(63,  "Brian", "C", "Cryingson", "bcc@hotmail.com", "207-853-0340", "1992-03-01 11:00:00"), 
(64,  "Emily", "Y", "Smith", "emily102@reddiff.com", "860-852-8893", "1999-04-01 12:02:00");

insert into Accounts
values (61, 43, "Checking", "2020-10-01 03:00:00"),
(62, 7000, "Savings", "2021-03-30 09:52:00"),
(63, 300, "Savings", "2024-04-15 06:21:00"),
(64, 42000, "Family", "2002-02-02 03:12:00"),
(65, 23, "Personal", "2001-02-01 03:13:00"),
(66, 123000, "Business", "2008-02-23 02:00:00"),
(67, 2, "Personal", "2008-02-24 02:00:00");

insert into AccountInfo 
values (61, 61), 
(61, 62),
(62, 63),
(63, 64),
(63, 65),
(64, 66),
(64, 67);

insert into Budgets -- robert, sally, brian
values (61, 4000.00, 61, 0.05, 6, 4000.00, 0, "Emergency Medical Fund"), 
(62, 300.00, 61, 20.00, 1, 220.00, 80.00, "Groceries for the month"), 
(63, 150.00, 62, 0.00, 7, 130.00, 20.00, "Gifts"), 
(64, 200.00, 63, 0.00, 7, 0.00, 200.00, "Plants"), 
(65, 300.00, 64, 30.00, 4, 226.00, 74.00, "Kids soccer"), 
(66, 20.00, 64, 0.00, 4, 19.99, 0.01, "Smokes");

insert into Investments -- robert
values (61, 62, "Stocks", 1200.00, "Stonks", "2020-04-13 03:00:00"), 
(62, 62, "Bonds", 20000.00, "Bonks", "2020-04-14 03:00:00");

insert into Bills -- sally, brian
values (61, "2024-05-01 11:59:59", "Water bill", 63, 64), 
(62, "2024-04-17 11:59:59", "Car bill", 64, 65), 
(63, "2024-04-18 11:59:59", "Professional soccer training", 64, 65),
(64, "2024-04-19 11:59:59", "Lung screening", 64, 66);

insert into Goals -- sally
values (61, "Buying a venus fly trap", "2024-05-30 12:00:00", 150.00, 25.00), 
(62, "Flies for venus fly trap", "2024-05-31 12:00:00", 20.00, 20.00);

insert into Transactions -- sally
values (61, 7, 63, 701.95, NULL, "2024-03-31 15:00:00", "Succulents"), 
(62, 7, 63, 23.00, 61, "2024-03-29 15:00:00", "Pots"), 
(63, 7, 63, 302.95, 62, "2024-02-14 15:00:00", "Spider repellent");

insert into Articles -- emily
values (61, "Women in Business", 64, "Women in business are rad, go business", "2024-01-16 18:00:00"),
(62, "Bonks and Stonks", 64, "bonk bonk bonk stonk stonk stonk. GO BONKS GO STONKS.", "2024-04-16 19:08:00");

insert into Comments -- emily
values (61, "Get women more bonks", 61), 
(62, "I met a woman in business once", 61), 
(63, "I LOVE stonks", 62), 
(64, "Should I get more bonks or more stonks? Which one is best?", 62);