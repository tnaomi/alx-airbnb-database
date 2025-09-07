CREATE INDEX idx_property_location ON PROPERTY(location);
CREATE INDEX idx_property_price ON PROPERTY(price_per_night);

CREATE INDEX idx_booking_status ON Booking(status_id);
CREATE UNIQUE INDEX idx_status_name ON booking_status(status_name);

EXPLAIN ANALYZE
SELECT b.*
FROM Booking b
JOIN BookingStatus s ON b.status_id = s.status_id
WHERE s.status_name = 'confirmed';
