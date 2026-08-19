-- Digital Library reservation workflow
-- Run this once in the same PostgreSQL database used by the server.

-- Reservations must support these statuses:
-- Pending  = waiting for an available copy
-- Accepted = admin accepted and the book was issued

ALTER TABLE reservations
ALTER COLUMN status TYPE VARCHAR(20),
ALTER COLUMN status SET DEFAULT 'Pending';

-- Existing blank/null rows become pending requests.
UPDATE reservations
SET status = 'Pending'
WHERE status IS NULL OR status = '';

ALTER TABLE reservations
ALTER COLUMN status SET NOT NULL;

-- Fine policy used by the application:
-- Every loan is 7 days.
-- After the due date, fine = ₹10 per late day.
