USE ticketing_db;

-- 1. Retrieval and Analyse Queries

-- Venues Table Queries
-- 1.1 List all venues and their capacities.
SELECT VenueName, Capacity FROM Venues;

-- 1.2 Find venues with capacity greater than 1000.
SELECT VenueName, Address FROM Venues WHERE Capacity > 1000;

-- 1.3 Find the venue with the highest capacity.
SELECT VenueName, Capacity FROM Venues ORDER BY Capacity DESC LIMIT 1;

-- 1.4 Count the total number of venues.
SELECT COUNT(*) AS TotalVenues FROM Venues;

-- Events Table Queries
-- 2.1 List all events and their venues.
SELECT EventName, VenueName FROM Events JOIN Venues ON Events.VenueID = Venues.VenueID;

-- 2.2 Find events happening in a specific venue.
SELECT EventName, EventDate FROM Events JOIN Venues ON Events.VenueID = Venues.VenueID WHERE Venues.VenueName = 'Grand Hall';

-- 2.3 Find events happening on a specific date range.
SELECT EventName, EventDate FROM Events WHERE EventDate BETWEEN '2024-11-20' AND '2024-12-05';

-- 2.4 List all events ordered by date.
SELECT EventName, EventDate FROM Events ORDER BY EventDate;

-- 2.5 Show events and their descriptions.
SELECT EventName, Description FROM Events;

-- Tickets Table Queries
-- 3.1 List all tickets for a specific event.
SELECT TicketID, Price, SeatNumber FROM Tickets WHERE EventID = 1;

-- 3.2 Find the average ticket price for each event.
SELECT EventID, AVG(Price) AS AveragePrice FROM Tickets GROUP BY EventID;

-- 3.3 Find the highest priced ticket.
SELECT TicketID, Price, EventID FROM Tickets ORDER BY Price DESC LIMIT 1;

-- 3.4 Count the number of tickets for each event.
SELECT EventID, COUNT(*) AS TicketCount FROM Tickets GROUP BY EventID;

-- 3.5 List all ticket types available.
SELECT DISTINCT TicketType FROM Tickets;

-- Customers Table Queries
-- 4.1 List all customers and their contact information.
SELECT FirstName, LastName, Email, PhoneNumber FROM Customers;

-- 4.2 Find customers with a specific last name.
SELECT FirstName, Email FROM Customers WHERE LastName = 'Smith';

-- 4.3 Find customers whose email contains 'example.com'.
SELECT FirstName, LastName FROM Customers WHERE Email LIKE '%example.com';

-- 4.4 List customers ordered by last name.
SELECT FirstName, LastName FROM Customers ORDER BY LastName;

-- 4.5 Count the total number of customers.
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- Orders Table Queries
-- 5.1 List all orders and their total amounts.
SELECT OrderID, TotalAmount FROM Orders;

-- 5.2 Find orders placed by a specific customer.
SELECT OrderID, OrderDate FROM Orders WHERE CustomerID = 1;

-- 5.3 Show orders placed in a specific date range.
SELECT OrderID, OrderDate, TotalAmount FROM Orders WHERE OrderDate BETWEEN '2024-11-01' AND '2024-12-31';

-- 5.4 Calculate the average order amount.
SELECT AVG(TotalAmount) AS AverageOrderAmount FROM Orders;

-- 5.5 List orders ordered by total amount.
SELECT OrderID, TotalAmount FROM Orders ORDER BY TotalAmount DESC;

-- OrderTickets Table Queries
-- 6.1 List all tickets in a specific order.
SELECT TicketID, Quantity FROM OrderTickets WHERE OrderID = 1;

-- 6.2 Find the total quantity of tickets sold for each event.
SELECT Events.EventName, SUM(OrderTickets.Quantity) AS TotalTicketsSold
FROM OrderTickets
JOIN Tickets ON OrderTickets.TicketID = Tickets.TicketID
JOIN Events ON Tickets.EventID = Events.EventID
GROUP BY Events.EventName;

-- 6.3 Find the most sold ticket.
SELECT Tickets.TicketID, Tickets.SeatNumber, SUM(OrderTickets.Quantity) AS TotalQuantitySold
FROM OrderTickets
JOIN Tickets ON OrderTickets.TicketID = Tickets.TicketID
GROUP BY Tickets.TicketID, Tickets.SeatNumber
ORDER BY TotalQuantitySold DESC LIMIT 1;

-- 6.4 Show the orders and their ticket number.
SELECT Orders.OrderID, Tickets.SeatNumber FROM Orders JOIN OrderTickets ON Orders.OrderID = OrderTickets.OrderID JOIN Tickets ON OrderTickets.TicketID = Tickets.TicketID;

-- 6.5 Show the order with the highest quantity of tickets.
SELECT OrderID, SUM(Quantity) AS TotalTickets FROM OrderTickets GROUP BY OrderID ORDER BY TotalTickets DESC LIMIT 1;

-- Payments Table Queries
-- 7.1 List all payments made for a specific order.
SELECT PaymentDate, PaymentMethod, Amount FROM Payments WHERE OrderID = 1;

-- 7.2 Find the total amount paid using each payment method.
SELECT PaymentMethod, SUM(Amount) AS TotalAmountPaid FROM Payments GROUP BY PaymentMethod;

-- 7.3 Find the highest payment amount.
SELECT PaymentID, Amount FROM Payments ORDER BY Amount DESC LIMIT 1;

-- 7.4 List payments ordered by payment date.
SELECT PaymentID, PaymentDate FROM Payments ORDER BY PaymentDate;

-- 7.5 Calculate the total payment amount.
SELECT SUM(Amount) AS TotalPayments FROM Payments;

-- Promotions Table Queries
-- 8.1 List all active promotions.
SELECT PromotionName, DiscountPercentage FROM Promotions WHERE CURDATE() BETWEEN StartDate AND EndDate;

-- 8.2 Find promotions applicable to a specific event.
SELECT PromotionName, DiscountPercentage FROM Promotions WHERE EventID = 1;

-- 8.3 Find promotions with a discount greater than 20%.
SELECT PromotionName, DiscountPercentage FROM Promotions WHERE DiscountPercentage > 20;

-- 8.4 List promotions ordered by discount percentage.
SELECT PromotionName, DiscountPercentage FROM Promotions ORDER BY DiscountPercentage DESC;

-- 8.5 Find the promotion that ends the soonest.
SELECT PromotionName, EndDate FROM Promotions ORDER BY EndDate LIMIT 1;

-- EventStaff Table Queries
-- 9.1 List all staff members for a specific event.
SELECT FirstName, LastName, Role FROM EventStaff WHERE EventID = 1;

-- 9.2 Find staff members with a specific role.
SELECT FirstName, LastName, EventID FROM EventStaff WHERE Role = 'Manager';

-- 9.3 List staff ordered by last name.
SELECT FirstName, LastName FROM EventStaff ORDER BY LastName;

-- 9.4 List all unique roles.
SELECT DISTINCT Role FROM EventStaff;

-- 9.5 Count the number of staff per event.
SELECT EventID, COUNT(*) AS StaffCount FROM EventStaff GROUP BY EventID;

-- Feedback Table Queries
-- 10.1 List all feedback for a specific event.
SELECT CustomerID, Rating, Comment FROM Feedback WHERE EventID = 1;

-- 10.2 Find the average rating for each event.
SELECT EventID, AVG(Rating) AS AverageRating FROM Feedback GROUP BY EventID;

-- 10.3 Find feedback with a rating of 5.
SELECT CustomerID, Comment FROM Feedback WHERE Rating = 5;

-- 10.4 List feedback ordered by feedback date.
SELECT CustomerID, FeedbackDate FROM Feedback ORDER BY FeedbackDate;

-- 10.5 Find the latest feedback for each event.
SELECT EventID, MAX(FeedbackDate) AS LatestFeedback FROM Feedback GROUP BY EventID;

-- Waitlist Table Queries
-- 11.1 List all customers on the waitlist for a specific event.
SELECT Customers.FirstName, Customers.LastName FROM Waitlist JOIN Customers ON Waitlist.CustomerID = Customers.CustomerID WHERE EventID = 1;

-- 11.2 Count the number of customers on the waitlist for each event.
SELECT EventID, COUNT(*) AS WaitlistCount FROM Waitlist GROUP BY EventID;

-- 11.3 List the waitlist ordered by date.
SELECT CustomerID, WaitlistDate FROM Waitlist ORDER BY WaitlistDate;

-- 11.4 Find the earliest waitlist entry for each event.
SELECT EventID, MIN(WaitlistDate) AS EarliestWaitlist FROM Waitlist GROUP BY EventID;

-- 11.5 List customers and their waitlist event.
SELECT Customers.FirstName, Customers.LastName, Events.EventName FROM Waitlist JOIN Customers ON Waitlist.CustomerID = Customers.CustomerID JOIN Events ON Waitlist.EventID = Events.EventID;

-- TicketAvailability Table Queries
-- 12.1 Show available tickets for an event.
SELECT EventID, TicketType, AvailableTickets FROM TicketAvailability WHERE EventID =1;

-- 12.2 show total available tickets for each event.
SELECT EventID, SUM(AvailableTickets) AS TotalAvailableTickets FROM TicketAvailability GROUP BY EventID;

-- 12.3 Find events where VIP tickets are available.
SELECT Events.EventName FROM TicketAvailability JOIN Events ON TicketAvailability.EventID = Events.EventID WHERE TicketType = 'VIP' AND AvailableTickets > 0;

-- 12.4 List the ticket types with the highest available tickets.
SELECT TicketType, SUM(AvailableTickets) AS TotalAvailable FROM TicketAvailability GROUP BY TicketType ORDER BY TotalAvailable DESC LIMIT 1;

-- 12.5 Find events where general tickets are not available.
SELECT Events.EventName FROM TicketAvailability JOIN Events ON TicketAvailability.EventID = Events.EventID WHERE TicketType = 'General' AND AvailableTickets = 0;

-- 2. Updation Queries

-- Venues Table Updates
-- 1.1 Update the capacity of a specific venue.
UPDATE Venues SET Capacity = 600 WHERE VenueName = 'Grand Hall';

-- 1.2 Change the address of a venue.
UPDATE Venues SET Address = '456 New Oak Ave, Townsville' WHERE VenueName = 'The Plaza';

-- 1.3 Rename a venue.
UPDATE Venues SET VenueName = 'New Grand Hall' WHERE VenueName = 'Grand Hall';

-- 1.4 Increase the capacity of all venues by 10%.
UPDATE Venues SET Capacity = Capacity * 1.1;

-- 1.5 Delete a venue.
DELETE FROM Venues WHERE VenueName = 'Community Center';

-- Events Table Updates
-- 2.1 Update the date of a specific event.
UPDATE Events SET EventDate = '2024-11-16 10:00:00' WHERE EventName = 'Tech Conference 2024';

-- 2.2 Change the description of an event.
UPDATE Events SET Description = 'Updated annual tech conference details.' WHERE EventName = 'Tech Conference 2024';

-- 2.3 Move an event to a different venue.
UPDATE Events SET VenueID = 2 WHERE EventName = 'Tech Conference 2024';

-- 2.4 Cancel an event by setting the date to NULL.
UPDATE Events SET EventDate = NULL WHERE EventName = 'Community Meeting';

-- 2.5 Rename an event.
UPDATE Events SET EventName = 'Updated Tech Conference 2024' WHERE EventName = 'Tech Conference 2024';

-- Tickets Table Updates
-- 3.1 Update the price of a specific ticket.
UPDATE Tickets SET Price = 110.00 WHERE TicketID = 1;

-- 3.2 Change the seat number of a ticket.
UPDATE Tickets SET SeatNumber = 'A2' WHERE TicketID = 1;

-- 3.3 Update the ticket type.
UPDATE Tickets SET TicketType = 'Regular' WHERE TicketID = 2;

-- 3.4 Increase the price of all VIP tickets by 5%.
UPDATE Tickets SET Price = Price * 1.05 WHERE TicketType = 'VIP';

-- 3.5 Delete a ticket.
DELETE FROM Tickets WHERE TicketID = 3;

-- Customers Table Updates
-- 4.1 Update the phone number of a specific customer.
UPDATE Customers SET PhoneNumber = '999-999-9999' WHERE CustomerID = 1;

-- 4.2 Change the email of a customer.
UPDATE Customers SET Email = 'new.email@example.com' WHERE CustomerID = 1;

-- 4.3 Update both first and last name.
UPDATE Customers SET FirstName = 'Robert', LastName = 'Smith' WHERE CustomerID = 2;

-- 4.4 Make all email addresses lowercase.
UPDATE Customers SET Email = LOWER(Email);

-- 4.5 Delete a customer.
DELETE FROM Customers WHERE CustomerID = 3;

-- Orders Table Updates
-- 5.1 Update the total amount of a specific order.
UPDATE Orders SET TotalAmount = 160.00 WHERE OrderID = 1;

-- 5.2 Change the customer associated with an order.
UPDATE Orders SET CustomerID = 2 WHERE OrderID = 1;

-- 5.3 Update the order date.
UPDATE Orders SET OrderDate = '2024-11-16 12:00:00' WHERE OrderID = 4;

-- 5.4 Increase the total amount of all orders by 10.
UPDATE Orders SET TotalAmount = TotalAmount + 10;

-- 5.5 Delete an order.
DELETE FROM Orders WHERE OrderID = 5;

-- OrderTickets Table Updates
-- 6.1 Update the quantity of tickets in a specific order.
UPDATE OrderTickets SET Quantity = 3 WHERE OrderID = 1 AND TicketID = 2;

-- 6.2 Change the ticket associated with an order.
UPDATE OrderTickets SET TicketID = 3 WHERE OrderID = 1 AND TicketID = 2;

-- 6.3 Increase the quantity of all tickets in an order by 1.
UPDATE OrderTickets SET Quantity = Quantity + 1 WHERE OrderID = 6;

-- 6.4 Delete a specific ticket from an order.
DELETE FROM OrderTickets WHERE OrderID = 7 AND TicketID = 8;

-- 6.5 Remove all tickets associated with a specific order.
DELETE FROM OrderTickets WHERE OrderID = 8;

-- Payments Table Updates
-- 7.1 Update the payment method of a specific payment.
UPDATE Payments SET PaymentMethod = 'Bank Transfer' WHERE PaymentID = 1;

-- 7.2 Change the payment amount.
UPDATE Payments SET Amount = 170.00 WHERE PaymentID = 1;

-- 7.3 Update the payment date.
UPDATE Payments SET PaymentDate = '2024-11-16 13:00:00' WHERE PaymentID = 2;

-- 7.4 Increase the payment amount of all payments by 5.
UPDATE Payments SET Amount = Amount + 5;

-- 7.5 Delete a payment.
DELETE FROM Payments WHERE PaymentID = 3;

-- Promotions Table Updates
-- 8.1 Extend the end date of a specific promotion.
UPDATE Promotions SET EndDate = '2024-12-20' WHERE PromotionName = 'Early Bird';

-- 8.2 Change the discount percentage.
UPDATE Promotions SET DiscountPercentage = 12.00 WHERE PromotionName = 'Early Bird';

-- 8.3 Update the start date.
UPDATE Promotions SET StartDate = '2024-10-16' WHERE PromotionName = 'Student Discount';

-- 8.4 Decrease the discount percentage of all promotions by 2.
UPDATE Promotions SET DiscountPercentage = DiscountPercentage - 2;

-- 8.5 Delete a promotion.
DELETE FROM Promotions WHERE PromotionName = 'Group Offer';

-- EventStaff Table Updates
-- 9.1 Update the role of a specific staff member.
UPDATE EventStaff SET Role = 'Senior Manager' WHERE StaffID = 1;

-- 9.2 Change the last name of a staff member.
UPDATE EventStaff SET LastName = 'NewSmith' WHERE StaffID = 1;

-- 9.3 Update both first and last name.
UPDATE EventStaff SET FirstName = 'John', LastName = 'NewDoe' WHERE StaffID = 2;

-- 9.4 Change the event assigned to a staff member.
UPDATE EventStaff SET EventID = 3 WHERE StaffID = 3;

-- 9.5 Delete a staff member.
DELETE FROM EventStaff WHERE StaffID = 4;

-- Feedback Table Updates
-- 10.1 Update the rating of a specific feedback.
UPDATE Feedback SET Rating = 5 WHERE FeedbackID = 3;

-- 10.2 Change the comment of a feedback.
UPDATE Feedback SET Comment = 'Excellent conference!' WHERE FeedbackID = 1;

-- 10.3 Update the customer associated with a feedback.
UPDATE Feedback SET CustomerID = 4 WHERE FeedbackID = 5;

-- 10.4 Update the feedback date.
UPDATE Feedback SET FeedbackDate = '2024-11-16 14:00:00' WHERE FeedbackID = 6;

-- 10.5 Delete a feedback.
DELETE FROM Feedback WHERE FeedbackID = 7;

-- Waitlist Table Updates
-- 11.1 Remove a customer from the waitlist.
DELETE FROM Waitlist WHERE CustomerID = 1 AND EventID = 3;

-- 11.2 Change the event associated with a waitlist entry.
UPDATE Waitlist SET EventID = 4 WHERE CustomerID = 2 AND EventID = 5;

-- 11.3 Update the waitlist date.
UPDATE Waitlist SET WaitlistDate = '2024-11-16 15:00:00' WHERE CustomerID = 6 AND EventID = 13;

-- 11.4 Remove all waitlist entries for a specific event.
DELETE FROM Waitlist WHERE EventID = 7;

-- 11.5 Remove all waitlist entries for a specific customer.
DELETE FROM Waitlist WHERE CustomerID = 8;

-- TicketAvailability Table Updates
-- 12.1 Update the available tickets.
UPDATE TicketAvailability SET AvailableTickets = 10 WHERE EventID = 1 AND TicketType = 'VIP';

-- 12.2 Decrease the available tickets for a specific event and ticket type.
UPDATE TicketAvailability SET AvailableTickets = AvailableTickets - 5 WHERE EventID = 2 AND TicketType = 'General';

-- 12.3 Change the ticket type and available count.
UPDATE TicketAvailability SET TicketType = 'Regular', AvailableTickets = 20 WHERE EventID = 3 AND TicketType = 'Premium';

-- 12.4 Increase the available tickets for all events by 2.
UPDATE TicketAvailability SET AvailableTickets = AvailableTickets + 2;

-- 12.5 Remove an entry from TicketAvailability.
DELETE FROM TicketAvailability WHERE EventID = 4 AND TicketType = 'General';