-- Active: 1757231732193@@ep-withered-pine-a9oodxlj-pooler.gwc.azure.neon.tech@5432@neondb@public
SELECT * FROM "User" u
INNER JOIN booking
ON u.user_id = booking.user_id;

-- LEFT JOIN
SELECT * from property p
LEFT JOIN review r
ON p.property_id= r.property_id;

-- FULL OUTER JOIN
SELECT * FROM "User" u
FULL OUTER JOIN booking b
ON u.user_id = b.booking_id;
