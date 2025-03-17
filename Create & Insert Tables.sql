CREATE DATABASE ticketing_db;
USE ticketing_db;

CREATE TABLE Venues (
    VenueID INT PRIMARY KEY AUTO_INCREMENT,
    VenueName VARCHAR(255),
    Address VARCHAR(255),
    Capacity INT
);

CREATE TABLE Events (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(255),
    EventDate DATETIME,
    Description TEXT,
    VenueID INT,
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)
);

CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    EventID INT,
    Price DECIMAL(10, 2),
    SeatNumber VARCHAR(20),
    TicketType VARCHAR(50),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderTickets (
    OrderTicketID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    TicketID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod VARCHAR(50),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Promotions/Discounts
CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    PromotionName VARCHAR(255),
    DiscountPercentage DECIMAL(5, 2),
    StartDate DATE,
    EndDate DATE,
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- EventStaff
CREATE TABLE EventStaff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Role VARCHAR(100),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- Feedback
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    EventID INT,
    Rating INT,
    Comment TEXT,
    FeedbackDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- Waitlist
CREATE TABLE Waitlist (
    WaitlistID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    EventID INT,
    WaitlistDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- TicketAvailability
CREATE TABLE TicketAvailability (
    AvailabilityID INT PRIMARY KEY AUTO_INCREMENT,
    EventID INT,
    TicketType VARCHAR(50),
    AvailableTickets INT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);
-- Venues
INSERT INTO Venues (VenueName, Address, Capacity) VALUES
('Grand Hall', '123 Main St, Cityville', 500),
('The Plaza', '456 Oak Ave, Townsville', 800),
('Sunset Arena', '789 Pine Ln, Villagetown', 1200),
('Riverside Park', '101 Elm St, Rivercity', 300),
('Central Theater', '202 Maple Ave, Metrocity', 1000),
('Art Gallery', '303 Birch Ln, Artville', 200),
('Sports Complex', '404 Cedar St, Sportstown', 1500),
('Community Center', '505 Willow Ave, Comtown', 400),
('Music Hall', '606 Redwood Ln, Melodyville', 900),
('Convention Center', '707 Spruce St, Confcity', 2000),
('Lakeview Pavilion', '808 Cherry Ave, Laketown', 600),
('Historical Building', '909 Walnut Ln, Historytown', 250),
('Science Museum', '1010 Pinecone St, Scicity', 1100),
('Botanical Garden', '1111 Oakwood Ave, Gardentown', 350),
('City Library', '1212 Willowtree Ln, Libtown', 700),
('Tech Hub', '1313 Redbrick St, Techcity', 1300),
('Fashion Studio', '1414 Bluestone Ave, Fashville', 450),
('Food Court', '1515 Greentile Ln, Foodtown', 850),
('Gaming Arena', '1616 Yellowbrick St, Gametown', 1600),
('Dance Studio', '1717 Whitetile Ave, Dancetown', 550);

-- Events
INSERT INTO Events (EventName, EventDate, Description, VenueID) VALUES
('Tech Conference 2024', '2024-11-15 09:00:00', 'Annual tech conference', 1),
('Art Exhibition', '2024-12-05 10:00:00', 'Modern art showcase', 6),
('Sports Tournament', '2024-11-25 14:00:00', 'Local sports competition', 7),
('Community Meeting', '2024-12-10 18:00:00', 'Neighborhood meeting', 8),
('Music Concert', '2024-11-20 20:00:00', 'Live music performance', 9),
('Business Expo', '2024-12-18 08:00:00', 'Industry expo and networking', 10),
('Lake Festival', '2024-11-30 12:00:00', 'Annual lake festival', 11),
('Historical Tour', '2024-12-08 11:00:00', 'Guided historical building tour', 12),
('Science Fair', '2024-11-22 13:00:00', 'Science projects and demonstrations', 13),
('Garden Workshop', '2024-12-03 15:00:00', 'Gardening workshop', 14),
('Book Reading', '2024-11-18 17:00:00', 'Author book reading event', 15),
('Coding Bootcamp', '2024-12-12 09:00:00', 'Intensive coding workshop', 16),
('Fashion Show', '2024-11-28 19:00:00', 'Local designer fashion show', 17),
('Food Festival', '2024-12-06 16:00:00', 'Local food vendors and tastings', 18),
('Gaming Competition', '2024-11-24 10:00:00', 'E-sports gaming tournament', 19),
('Dance Performance', '2024-12-01 20:00:00', 'Modern dance performance', 20),
('Charity Gala', '2024-12-16 18:00:00', 'Charity fundraising event', 3),
('Film Screening', '2024-11-17 14:00:00', 'Independent film screening', 5),
('Poetry Slam', '2024-12-09 19:00:00', 'Local poetry competition', 2),
('Yoga Retreat', '2024-11-29 08:00:00', 'Weekend yoga and meditation retreat', 4);

-- Tickets
INSERT INTO Tickets (EventID, Price, SeatNumber, TicketType) VALUES
(1, 100.00, 'A1', 'VIP'), (1, 50.00, 'B10', 'General'), (2, 20.00, 'C5', 'General'), (3, 75.00, 'D15', 'Premium'), (4, 10.00, 'E20', 'General'),
(5, 120.00, 'F1', 'VIP'), (6, 90.00, 'G10', 'Premium'), (7, 40.00, 'H5', 'General'), (8, 15.00, 'I20', 'General'), (9, 80.00, 'J15', 'Premium'),
(10, 30.00, 'K10', 'General'), (11, 60.00, 'L5', 'General'), (12, 25.00, 'M20', 'General'), (13, 110.00, 'N1', 'VIP'), (14, 70.00, 'O15', 'Premium'),
(15, 55.00, 'P10', 'General'), (16, 95.00, 'Q5', 'Premium'), (17, 130.00, 'R1', 'VIP'), (18, 45.00, 'S20', 'General'), (19, 105.00, 'T15', 'Premium');

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890'), ('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210'), ('David', 'Lee', 'david.lee@example.com', '555-123-4567'), ('Sarah', 'Jones', 'sarah.jones@example.com', '111-222-3333'), ('Michael', 'Brown', 'michael.brown@example.com', '444-555-6666'),
('Emily', 'Davis', 'emily.davis@example.com', '777-888-9999'), ('Kevin', 'Wilson', 'kevin.wilson@example.com', '101-202-3030'), ('Ashley', 'Garcia', 'ashley.garcia@example.com', '404-505-6060'), ('Brian', 'Rodriguez', 'brian.rodriguez@example.com', '707-808-9090'), ('Jessica', 'Martinez', 'jessica.martinez@example.com', '121-323-4343'),
('Christopher', 'Anderson', 'christopher.anderson@example.com', '545-656-7676'), ('Amanda', 'Thomas', 'amanda.thomas@example.com', '878-989-0909'), ('Matthew', 'Jackson', 'matthew.jackson@example.com', '232-434-5454'), ('Stephanie', 'White', 'stephanie.white@example.com', '656-767-8787'), ('Daniel', 'Harris', 'daniel.harris@example.com', '989-090-1010'),('Nicholas', 'Martin', 'nicholas.martin@example.com', '343-545-6565'), ('Melissa', 'Thompson', 'melissa.thompson@example.com', '767-878-9898'), ('Joseph', 'Moore', 'joseph.moore@example.com', '090-101-2020'), ('Laura', 'Taylor', 'laura.taylor@example.com', '454-565-6767'), ('Patrick', 'Hill', 'patrick.hill@example.com', '878-989-0101');

-- Orders
INSERT INTO Orders (CustomerID, TotalAmount) VALUES
(1, 150.00), (2, 30.00), (3, 80.00), (4, 25.00), (5, 130.00),
(6, 100.00), (7, 50.00), (8, 20.00), (9, 90.00), (10, 35.00),
(11, 120.00), (12, 45.00), (13, 110.00), (14, 60.00), (15, 75.00),
(16, 140.00), (17, 85.00), (18, 55.00), (19, 105.00), (20, 135.00);

-- OrderTickets
INSERT INTO OrderTickets (OrderID, TicketID, Quantity) VALUES
(1, 1, 1), (1, 2, 2), (2, 3, 1), (3, 4, 1), (4, 5, 2),
(5, 6, 1), (6, 7, 1), (7, 8, 2), (8, 9, 1), (9, 10, 1),
(10, 11, 2), (11, 12, 1), (12, 13, 1), (13, 14, 2), (14, 15, 1),
(15, 16, 1), (16, 17, 2), (17, 18, 1), (18, 19, 1), (19, 20, 2);

-- Payments
INSERT INTO Payments (OrderID, PaymentMethod, Amount) VALUES
(1, 'Credit Card', 150.00), (2, 'PayPal', 30.00), (3, 'Mobile Pay', 80.00), (4, 'Credit Card', 25.00), (5, 'PayPal', 130.00),
(6, 'Mobile Pay', 100.00), (7, 'Credit Card', 50.00), (8, 'PayPal', 20.00), (9, 'Mobile Pay', 90.00), (10, 'Credit Card', 35.00),
(11, 'PayPal', 120.00), (12, 'Mobile Pay', 45.00), (13, 'Credit Card', 110.00), (14, 'PayPal', 60.00), (15, 'Mobile Pay', 75.00),
(16, 'Credit Card', 140.00), (17, 'PayPal', 85.00), (18, 'Mobile Pay', 55.00), (19, 'Credit Card', 105.00), (20, 'PayPal', 135.00);

-- Promotions
INSERT INTO Promotions (PromotionName, DiscountPercentage, StartDate, EndDate, EventID) VALUES
('Early Bird', 10.00, '2024-10-15', '2024-11-10', 1), ('Student Discount', 15.00, '2024-11-20', '2024-12-04', 2), ('Group Offer', 20.00, '2024-11-10', '2024-11-24', 3), ('VIP Promo', 25.00, '2024-12-01', '2024-12-15', 5), ('Holiday Sale', 30.00, '2024-11-25', '2024-12-10', 6),
('Summer Deal', 12.00, '2024-10-20', '2024-11-15', 7), ('Winter Offer', 18.00, '2024-11-18', '2024-12-02', 8), ('Spring Discount', 22.00, '2024-12-05', '2024-12-18', 9), ('Autumn Promo', 28.00, '2024-11-12', '2024-11-26', 10), ('New Year Sale', 35.00, '2024-12-16', '2024-12-30', 11),
('Monthly Deal', 8.00, '2024-10-25', '2024-11-20', 12), ('Weekly Offer', 16.00, '2024-11-16', '2024-11-30', 13), ('Weekend Discount', 24.00, '2024-12-03', '2024-12-17', 14), ('Daily Promo', 32.00, '2024-11-14', '2024-11-28', 15), ('Flash Sale', 40.00, '2024-12-18', '2024-12-31', 16),
('Special Offer', 11.00, '2024-10-28', '2024-11-22', 17), ('Limited Time', 19.00, '2024-11-22', '2024-12-06', 18), ('Exclusive Deal', 26.00, '2024-12-07', '2024-12-20', 19), ('Bonus Discount', 33.00, '2024-11-16', '2024-11-30', 20), ('Anniversary Sale', 38.00, '2024-12-20', '2024-12-31', 4);

-- EventStaff
INSERT INTO EventStaff (FirstName, LastName, Role, EventID) VALUES
('Alice', 'Smith', 'Manager', 1), ('Bob', 'Johnson', 'Security', 2), ('Charlie', 'Williams', 'Host', 3), ('David', 'Brown', 'Technician', 4), ('Eve', 'Davis', 'Coordinator', 5),
('Frank', 'Miller', 'Assistant', 6), ('Grace', 'Wilson', 'Organizer', 7), ('Henry', 'Moore', 'Volunteer', 8), ('Ivy', 'Taylor', 'Speaker', 9), ('Jack', 'Anderson', 'Stagehand', 10),
('Kate', 'Thomas', 'Usher', 11), ('Liam', 'Jackson', 'Caterer', 12), ('Mia', 'White', 'Director', 13), ('Noah', 'Harris', 'Sound Engineer', 14), ('Olivia', 'Martin', 'Photographer', 15),
('Peter', 'Thompson', 'Videographer', 16), ('Quinn', 'Moore', 'Designer', 17), ('Ryan', 'Taylor', 'Promoter', 18), ('Sophia', 'Hill', 'Judge', 19), ('Thomas', 'Smith', 'Performer', 20);

-- Feedback
INSERT INTO Feedback (CustomerID, EventID, Rating, Comment) VALUES
(1, 1, 5, 'Great conference!'), (2, 2, 4, 'Enjoyed the art.'), (3, 3, 3, 'Sports were okay.'), (4, 4, 5, 'Good community meeting.'), (5, 5, 4, 'Nice music!'),
(6, 6, 5, 'Informative expo.'), (7, 7, 3, 'Lake festival was average.'), (8, 8, 4, 'Interesting tour.'), (9, 9, 5, 'Excellent science fair.'), (10, 10, 4, 'Useful workshop.'),
(11, 11, 3, 'Book reading was dull.'), (12, 12, 5, 'Great coding bootcamp.'), (13, 13, 4, 'Loved the fashion show.'), (14, 14, 5, 'Delicious food!'), (15, 15, 3, 'Gaming comp was alright.'),
(16, 16, 4, 'Dance performance was good.'), (17, 17, 5, 'Successful gala.'), (18, 18, 4, 'Enjoyed the film.'), (19, 19, 3, 'Poetry slam was so-so.'), (20, 20, 5, 'Relaxing retreat.');

-- Waitlist
INSERT INTO Waitlist (CustomerID, EventID) VALUES
(1, 3), (2, 5), (3, 7), (4, 9), (5, 11),
(6, 13), (7, 15), (8, 17), (9, 19), (10, 1),
(11, 4), (12, 6), (13, 8), (14, 10), (15, 12),
(16, 14), (17, 16), (18, 18), (19, 20), (20, 2);

-- TicketAvailability
INSERT INTO TicketAvailability (EventID, TicketType, AvailableTickets) VALUES
(1, 'VIP', 5), (1, 'General', 20), (2, 'General', 30), (3, 'Premium', 10), (4, 'General', 40),
(5, 'VIP', 3), (6, 'Premium', 15), (7, 'General', 25), (8, 'General', 35), (9, 'Premium', 8),
(10, 'General', 28), (11, 'General', 38), (12, 'VIP', 7), (13, 'Premium', 12), (14, 'General', 32),
(15, 'General', 42), (16, 'Premium', 9), (17, 'VIP', 2), (18, 'General', 33), (19, 'Premium', 11);

