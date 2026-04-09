-- =====================================================
-- database.sql — Lost & Found Campus System
-- Run this in phpMyAdmin or MySQL CLI to set up the DB
-- =====================================================

-- Step 1: Create and select database
CREATE DATABASE IF NOT EXISTS lost_found_campus
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE lost_found_campus;

-- =====================================================
-- TABLE: users
-- Stores registered user accounts
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
  id       INT(11)      NOT NULL AUTO_INCREMENT,
  username VARCHAR(50)  NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,           -- Stored as bcrypt hash
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- =====================================================
-- TABLE: lost_items
-- Items reported as lost by users
-- =====================================================
CREATE TABLE IF NOT EXISTS lost_items (
  id          INT(11)      NOT NULL AUTO_INCREMENT,
  user_id     INT(11)      NOT NULL,
  item_name   VARCHAR(150) NOT NULL,
  description TEXT         NOT NULL,
  location    VARCHAR(200) NOT NULL,
  date        DATE         NOT NULL,
  created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- =====================================================
-- TABLE: found_items
-- Items reported as found by users
-- =====================================================
CREATE TABLE IF NOT EXISTS found_items (
  id          INT(11)      NOT NULL AUTO_INCREMENT,
  user_id     INT(11)      NOT NULL,
  item_name   VARCHAR(150) NOT NULL,
  description TEXT         NOT NULL,
  location    VARCHAR(200) NOT NULL,
  date        DATE         NOT NULL,
  created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- =====================================================
-- SAMPLE DATA — for testing
-- Password for all sample users is: "password123"
-- (bcrypt hash of "password123")
-- =====================================================

INSERT INTO users (username, password) VALUES
  ('alice',  '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'),
  ('bob',    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'),
  ('charlie','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Note: The hash above is for "password" (Laravel default test hash).
-- To generate correct hashes, register through the web app instead.

-- Sample lost items
INSERT INTO lost_items (user_id, item_name, description, location, date) VALUES
  (1, 'Blue Water Bottle',  'Blue Nalgene bottle with stickers, 1 litre',    'Library Ground Floor',    '2025-01-10'),
  (1, 'iPhone Charger',     'White Apple 20W USB-C charger with braided cable','Cafeteria near window',  '2025-01-12'),
  (2, 'Student ID Card',    'SPPU student card, name: Bob, Roll no 42',       'Block A Classroom 201',  '2025-01-14'),
  (2, 'Black Umbrella',     'Folding black umbrella with wooden handle',       'Parking Lot B',          '2025-01-15'),
  (3, 'Calculator',         'Casio fx-991EX scientific calculator',            'Math Lab',               '2025-01-16');

-- Sample found items
INSERT INTO found_items (user_id, item_name, description, location, date) VALUES
  (2, 'Water Bottle',       'Blue bottle with some stickers on it',           'Library Reading Hall',   '2025-01-11'),
  (3, 'Charger Cable',      'White USB-C charging cable, seems new',          'Cafeteria near entrance','2025-01-13'),
  (1, 'ID Card',            'Student identity card found on floor',           'Block A Corridor',       '2025-01-15'),
  (1, 'Umbrella',           'Black folding umbrella left on bench',           'Parking Lot',            '2025-01-16'),
  (2, 'Scientific Calculator','Casio calculator found near lab desks',        'Math Department',        '2025-01-17');

-- =====================================================
-- DONE! Now open the project in XAMPP and run it.
-- =====================================================
