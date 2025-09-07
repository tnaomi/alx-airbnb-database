# High Usage Columns

## `User` entity

- `email` - can be used to search for a user through email (ALREADY DONE)

## `Property` entity

- `location` - can be used to lookup properties in a specific location
- `price_per_night` - Can be used to define price ranges

```sql
CREATE INDEX idx_property_location ON PROPERTY(location);
CREATE INDEX idx_property_price ON PROPERTY(price_per_night);
```

### Result
- Ran 
```sql
EXPLAIN (SELECT * FROM property)
```
QUERY PLAN	| Seq Scan on property (cost=0.00..1.02 rows=2 width=930)

## Booking

- `status_id` - Can be used to create a filter index for a specific status eg active bookings

```sql
CREATE INDEX idx_booking_status ON Booking(status_id);
CREATE UNIQUE INDEX idx_status_name ON booking_status(status_name);
```

## Table Series Autogenerator

```sql

INSERT INTO Booking (property_id, user_id, start_date, end_date, status_id)
SELECT
    (ARRAY[
        'a6dd41d3-f38e-4ba3-91ea-fd625f792ee5'::uuid,
        '740686f0-181d-456a-b920-33f75edb8444'::uuid
    ])[ceil(random()*2)::int],

    (ARRAY[
        '44a7668a-c24e-4bd2-af9f-f92bedd96e1c'::uuid,
        '56bdfc68-067b-4e40-bc51-505c9fa4b90e'::uuid
    ])[ceil(random()*2)::int],

    CURRENT_DATE + (g * 2),                              -- start_date
    CURRENT_DATE + (g * 2) + (2 + (random() * 5)::int),  -- end_date > start_date
    (floor(random() * 3) + 1)::int                       -- status_id (1–3)
FROM generate_series(1, 1000) g;                         -- change 1000 to bigger
```