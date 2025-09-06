# 1. Normalize Your Database Design

## 1NF

### Rules

- Each table cell = atomic (no repeating groups or multi-valued attributes).

- Each record must be unique.

### This DB:

- All attributes are atomic (first_name, last_name, etc).

- Primary keys (UUIDs) guarantee uniqueness.

- No repeating groups like phone1, phone2, physical_address, postal_address.

### Satisfies 1NF

## 2NF

### Rules

- Be in 1NF.

- All non-key attributes must depend on the whole primary key (applies mainly to composite PKs).

### This DB:

- All tables use single-column PKs (UUIDs), not composite PKs.

- Example: in Booking, attributes like start_date, end_date, status depend entirely on booking_id (not part of a composite key).

### Schema in 2NF

## 3NF

### Rules

- Be in 2NF.

- Remove transitive dependencies (non-key attributes depending on other non-key attributes).

- Every non-key must depend only on the key.

### This DB:

1. `Booking.total_price` is a derived attribute (depends on property `pricepernight` + dates). It can be removed and computed dynamically, as prices are dynamic as well.

2. `Payment.amount` could stay because payments can be multiple and independent.

3. `Role`, `Status`, `Payment Method` could be introduced as lookup tables for stricter normalization (instead of `CHECK`).



