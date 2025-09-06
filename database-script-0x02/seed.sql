-- ==========================
-- Lookup Tables
-- ==========================
INSERT INTO Role (role_name) VALUES ('guest'), ('host'), ('admin');
INSERT INTO BookingStatus (status_name) VALUES ('pending'), ('confirmed'), ('canceled');
INSERT INTO PaymentMethod (method_name) VALUES ('credit_card'), ('paypal'), ('stripe');

-- ==========================
-- Users
-- ==========================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role_id)
VALUES
    (uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '111-222-3333', 1), -- guest
    (uuid_generate_v4(), 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '222-333-4444', 2),       -- host
    (uuid_generate_v4(), 'Charlie', 'Brown', 'charlie@example.com', 'hashed_pw3', '333-444-5555', 2),-- host
    (uuid_generate_v4(), 'Diana', 'King', 'diana@example.com', 'hashed_pw4', '444-555-6666', 1),    -- guest
    (uuid_generate_v4(), 'Eve', 'Admin', 'eve@example.com', 'hashed_pw5', '555-666-7777', 3);       -- admin

-- ==========================
-- Properties
-- (Assign to Bob and Charlie as hosts)
-- ==========================
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
    (uuid_generate_v4(), 
        (SELECT user_id FROM "User" WHERE email='bob@example.com'), 
        'Sunny Beach House', 
        'A beautiful house near the beach with 3 bedrooms.', 
        'Cape Town, South Africa', 
        120.00),

    (uuid_generate_v4(), 
        (SELECT user_id FROM "User" WHERE email='charlie@example.com'), 
        'Cozy Mountain Cabin', 
        'Rustic cabin in the mountains, perfect for a weekend getaway.', 
        'Mulanje, Malawi', 
        75.00);

-- ==========================
-- Bookings
-- ==========================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status_id)
VALUES
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name='Sunny Beach House'),
        (SELECT user_id FROM "User" WHERE email='alice@example.com'),
        '2025-09-10', '2025-09-15',
        (SELECT status_id FROM BookingStatus WHERE status_name='confirmed')),

    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name='Cozy Mountain Cabin'),
        (SELECT user_id FROM "User" WHERE email='diana@example.com'),
        '2025-10-01', '2025-10-05',
        (SELECT status_id FROM BookingStatus WHERE status_name='pending'));

-- ==========================
-- Payments
-- ==========================
INSERT INTO Payment (payment_id, booking_id, amount, method_id)
VALUES
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking b
         JOIN Property p ON b.property_id = p.property_id
         WHERE p.name='Sunny Beach House'
         AND b.user_id = (SELECT user_id FROM "User" WHERE email='alice@example.com')),
        600.00,
        (SELECT method_id FROM PaymentMethod WHERE method_name='credit_card'));

-- ==========================
-- Reviews
-- ==========================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name='Sunny Beach House'),
        (SELECT user_id FROM "User" WHERE email='alice@example.com'),
        5,
        'Amazing stay! The beach view was incredible.'),

    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name='Cozy Mountain Cabin'),
        (SELECT user_id FROM "User" WHERE email='diana@example.com'),
        4,
        'Cozy and peaceful, but the WiFi was spotty.');

-- ==========================
-- Messages
-- ==========================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email='alice@example.com'),
        (SELECT user_id FROM "User" WHERE email='bob@example.com'),
        'Hi Bob, is the Sunny Beach House available next month?'),

    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email='bob@example.com'),
        (SELECT user_id FROM "User" WHERE email='alice@example.com'),
        'Hi Alice, yes it is available in October!');
