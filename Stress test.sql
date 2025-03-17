USE ticketing_db;

-- Stress Testing: Multi-Valued Attributes and Data Integrity Checks
-- Stresstesting for 1NF (1st Normal Form)
-- To check if a table follows First Normal Form (1NF) in SQL, you need to ensure that:
-- 1. Each column contains atomic values (no multiple values in a single column).
-- 2. Each row has a unique identifier (a primary key is defined).
-- 3. All columns store only single-valued attributes (no repeating groups or arrays).
-- Venues Table: Check for Multi-Valued Attributes (unlikely but possible)
SELECT * FROM Venues
WHERE VenueName LIKE '%,%'
   OR Address LIKE '%,%';

-- Events Table: Check for Multi-Valued Attributes (unlikely but possible)
SELECT * FROM Events
WHERE EventName LIKE '%,%'
   OR Description LIKE '%,%';

-- Tickets Table: Check for Multi-Valued Attributes
SELECT * FROM Tickets
WHERE SeatNumber LIKE '%,%'
   OR TicketType LIKE '%,%';

-- Customers Table: Check for Multi-Valued Attributes
SELECT * FROM Customers
WHERE FirstName LIKE '%,%'
   OR LastName LIKE '%,%'
   OR Email LIKE '%,%'
   OR PhoneNumber LIKE '%,%';

-- Orders Table: Check for Multi-Valued Attributes (unlikely but possible)
SELECT * FROM Orders; -- No text fields that would typically have multiple values.

-- OrderTickets Table: Check for Multi-Valued Attributes (unlikely but possible)
SELECT * FROM OrderTickets; -- No text fields that would typically have multiple values.

-- Payments Table: Check for Multi-Valued Attributes
SELECT * FROM Payments
WHERE PaymentMethod LIKE '%,%';

-- Promotions Table: Check for Multi-Valued Attributes
SELECT * FROM Promotions
WHERE PromotionName LIKE '%,%';

-- EventStaff Table: Check for Multi-Valued Attributes
SELECT * FROM EventStaff
WHERE FirstName LIKE '%,%'
   OR LastName LIKE '%,%'
   OR Role LIKE '%,%';

-- Feedback Table: Check for Multi-Valued Attributes
SELECT * FROM Feedback
WHERE Comment LIKE '%,%';

-- Waitlist Table: Check for Multi-Valued Attributes (unlikely but possible)
SELECT * FROM Waitlist; -- No text fields that would typically have multiple values.

-- TicketAvailability Table: Check for Multi-Valued Attributes
SELECT * FROM TicketAvailability
WHERE TicketType LIKE '%,%';

-- Stress Testing: Data Integrity Checks

-- Check for Duplicate Emails in Customers
SELECT Email, COUNT(*) FROM Customers GROUP BY Email HAVING COUNT(*) > 1;

-- Check for Events with Missing Venues (Foreign Key Integrity)
SELECT * FROM Events WHERE VenueID NOT IN (SELECT VenueID FROM Venues);

-- Check for Tickets with Missing Events (Foreign Key Integrity)
SELECT * FROM Tickets WHERE EventID NOT IN (SELECT EventID FROM Events);

-- Check for Orders with Missing Customers (Foreign Key Integrity)
SELECT * FROM Orders WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers);

-- Check for OrderTickets with Missing Orders or Tickets (Foreign Key Integrity)
SELECT * FROM OrderTickets WHERE OrderID NOT IN (SELECT OrderID FROM Orders) OR TicketID NOT IN (SELECT TicketID FROM Tickets);

-- Check for Payments with Missing Orders (Foreign Key Integrity)
SELECT * FROM Payments WHERE OrderID NOT IN (SELECT OrderID FROM Orders);

-- Check for Promotions with Missing Events (Foreign Key Integrity)
SELECT * FROM Promotions WHERE EventID NOT IN (SELECT EventID FROM Events);

-- Check for EventStaff with Missing Events (Foreign Key Integrity)
SELECT * FROM EventStaff WHERE EventID NOT IN (SELECT EventID FROM Events);

-- Check for Feedback with Missing Customers or Events (Foreign Key Integrity)
SELECT * FROM Feedback WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers) OR EventID NOT IN (SELECT EventID FROM Events);

-- Check for Waitlist with Missing Customers or Events (Foreign Key Integrity)
SELECT * FROM Waitlist WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers) OR EventID NOT IN (SELECT EventID FROM Events);

-- Check for TicketAvailability with Missing Events (Foreign Key Integrity)
SELECT * FROM TicketAvailability WHERE EventID NOT IN (SELECT EventID FROM Events);

-- Check for Orders with TotalAmount not matching OrderTickets
SELECT Orders.OrderID
FROM Orders
LEFT JOIN (
    SELECT OrderID, SUM(Tickets.Price * OrderTickets.Quantity) AS CalculatedTotal
    FROM OrderTickets
    JOIN Tickets ON OrderTickets.TicketID = Tickets.TicketID
    GROUP BY OrderID
) AS CalculatedTotals ON Orders.OrderID = CalculatedTotals.OrderID
WHERE Orders.TotalAmount <> COALESCE(CalculatedTotals.CalculatedTotal, 0);

-- Check for Payments with Amount not matching Orders
SELECT Payments.PaymentID
FROM Payments
LEFT JOIN Orders ON Payments.OrderID = Orders.OrderID
WHERE Payments.Amount <> Orders.TotalAmount;

-- Check for Events with EventDate in the past
SELECT * FROM Events WHERE EventDate < NOW();

-- Check for Promotions with EndDate before StartDate
SELECT * FROM Promotions WHERE EndDate < StartDate;

-- Check for available tickets not matching the tickets sold.
SELECT Events.EventName, TicketAvailability.TicketType, SUM(OrderTickets.Quantity) as TicketsSold, TicketAvailability.AvailableTickets
FROM Events
JOIN TicketAvailability ON Events.EventID = TicketAvailability.EventID
LEFT JOIN Tickets ON Events.EventID = Tickets.EventID
LEFT JOIN OrderTickets ON Tickets.TicketID = OrderTickets.TicketID
GROUP BY Events.EventName, TicketAvailability.TicketType, TicketAvailability.AvailableTickets
HAVING SUM(OrderTickets.Quantity) > TicketAvailability.AvailableTickets;

-- no column in any table contains multiple values separated by comma, so, 1NF is not violated.

-- Check for Missing Primary Keys

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'ticketing_db'
AND TABLE_NAME NOT IN (
    SELECT DISTINCT TABLE_NAME
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE CONSTRAINT_NAME = 'PRIMARY'
    );
    -- There are no tables with missing primary keys, so, 1NF is not violated.

-- Check for Repeating Groups

SELECT COLUMN_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ticketing_db'
AND COLUMN_NAME REGEXP '_[0-9]$';

-- As no column names end with _1, _2, _3, etc., 1NF is not violated.

-- As, all checks for 1NF found that, 1NF is not violated, hence we can conclude that our database is 1NF compliant.