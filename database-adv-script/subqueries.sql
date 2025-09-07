-- Find all properties where avg rating is greater than 4

SELECT p.name, p.location, p.price_per_night from property p
INNER JOIN review r
ON p.property_id = r.property_id
WHERE ( SELECT AVG(rating) from review ) > '4.0'
ORDER BY p.property_id DESC;

-- Correlated subqueries

SELECT u.first_name, u.last_name from "User" u
INNER JOIN (
    SELECT user_id
    FROM booking
    GROUP BY user_id
    HAVING COUNT(booking_id) > 3
) bookings on bookings.user_id = u.user_id;