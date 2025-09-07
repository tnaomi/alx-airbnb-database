-- find the total number of bookings made by each user

SELECT b.user_id, COUNT(*) as bookings_per_user from booking b
GROUP BY b.user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT b.property_id, total_bookings,
ROW_NUMBER() OVER(ORDER BY total_bookings DESC) FROM ( -- Forces each detail row, regardless of same value as the next into its own unique position or rule
    SELECT property_id, COUNT(*) AS total_bookings
    FROM booking b
    GROUP BY b.property_id
) b
;

SELECT b.property_id, total_bookings,
RANK() OVER(ORDER BY total_bookings DESC) FROM ( -- Ranks each detail row, same value hold the same rank, skips (x + no of rows with the same value) to the next rank number i.e 1, 1, 1, 4
    SELECT property_id, COUNT(*) AS total_bookings
    FROM booking b
    GROUP BY b.property_id
) b
;