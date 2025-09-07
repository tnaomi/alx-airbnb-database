-- Active: 1757231732193@@ep-withered-pine-a9oodxlj-pooler.gwc.azure.neon.tech@5432@neondb@public
SELECT u.first_name, u.last_name, u.phone_number, u.email, booking.start_date, booking.end_date FROM "User" u
INNER JOIN booking
ON u.user_id = booking.user_id
ORDER BY booking.created_at;

-- LEFT JOIN
SELECT p.name, p.location, p.price_per_night, r.rating, r.comment from property p
LEFT JOIN review r
ON p.property_id= r.property_id
ORDER BY r.created_at DESC;

-- FULL OUTER JOIN
SELECT u.first_name, u.last_name, u.phone_number, u.email, b.start_date, b.end_date FROM "User" u
FULL OUTER JOIN booking b
ON u.user_id = b.user_id
ORDER BY b.start_date DESC;
