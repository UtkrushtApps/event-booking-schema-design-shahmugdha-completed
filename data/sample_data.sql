DROP TABLE users 
DROP TABLE events
DROP TABLE bookings 

-- Drop tables in the correct order to avoid foreign key constraint errors
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create tables
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    seats_booked INT NOT NULL,
    booked_at TIMESTAMP NOT NULL
);

-- Add foreign key constraints
ALTER TABLE bookings
    ADD CONSTRAINT fk_bookings_users,
    ADD CONSTRAINT check_bookings_seats (
        (SELECT SUM(seats_booked) FROM bookings WHERE event_id = events.id) <= events.capacity
    );
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_bookings_events
    FOREIGN KEY (event_id)
    REFERENCES events (id)
    ON DELETE CASCADE;

-- Insert sample data
INSERT INTO users (name, email) VALUES
    ('John Doe', 'john@example.com'),
    ('Jane Doe', 'jane@example.com'),
    ('Bob Smith', 'bob@example.com'),
    ('Alice Johnson', 'alice@example.com'),
    ('Mike Brown', 'mike@example.com'),
    ('Sarah Wilson', 'sarah@example.com'),
    ('David Lee', 'david@example.com'),
    ('Emily Davis', 'emily@example.com'),
    ('Chris Taylor', 'chris@example.com'),
    ('Mugdha Shah', 'shahmugdha15@gmail.com');

INSERT INTO events (title, event_date, capacity) VALUES
    ('Event 1', '2025-10-01', 10),
    ('Event 2', '2025-10-02', 20),
    ('Event 3', '2025-10-03', 30),
    ('Event 4', '2025-10-04', 40),
    ('Event 5', '2025-10-05', 50),
    ('Event 6', '2025-10-06', 60),
    ('Event 7', '2025-10-07', 70),
    ('Event 8', '2025-10-08', 80),
    ('Event 9', '2025-10-09', 90),
    ('Event 10', '2025-10-10', 100);

-- Insert bookings
INSERT INTO bookings (user_id, event_id, seats_booked, booked_at) VALUES
    (1, 1, 10, '2025-10-01 10:00:00'),
    (2, 2, 20, '2025-10-02 10:00:00'),
    (3, 3, 30, '2025-10-03 10:00:00'),
    (1, 4, 40, '2025-10-04 10:00:00'),
    (2, 5, 50, '2025-10-05 10:00:00'),
    (3, 6, 60, '2025-10-06 10:00:00'),
    (1, 7, 70, '2025-10-07 10:00:00'),
    (2, 8, 80, '2025-10-08 10:00:00'),
    (3, 9, 90, '2025-10-09 10:00:00'),
    (1, 10, 100, '2025-10-10 10:00:00'),
    (4, 1, 0, '2025-10-01 11:30:00'),
    (5, 2, 5, '2025-10-02 11:30:00'),
    (6, 3, 0, '2025-10-03 11:30:00'),
    (7, 4, 20, '2025-10-04 11:30:00'),
    (8, 5, 0, '2025-10-05 11:30:00'),
    (9, 6, 30, '2025-10-06 11:30:00'),
    (4, 7, 0, '2025-10-07 11:30:00'),
    (5, 8, 40, '2025-10-08 11:30:00'),
    (6, 9, 0, '2025-10-09 11:30:00'),
    (7, 10, 50, '2025-10-10 11:30:00'),
    (8, 1, 10, '2025-10-01 12:00:00'),
    (9, 2, 15, '2025-10-02 12:00:00'),
    (4, 3, 30, '2025-10-03 12:00:00'),
    (5, 4, 20, '2025-10-04 12:00:00'),
    (6, 5, 50, '2025-10-05 12:00:00'),
    (7, 6, 30, '2025-10-06 12:00:00'),
    (8, 7, 70, '2025-10-07 12:00:00'),
    (9, 8, 40, '2025-10-08 12:00:00'),
    (4, 9, 90, '2025-10-09 12:00:00'),
    (5, 10, 50, '2025-10-10 12:00:00');