-- Create schemas

-- Create tables
DROP DATABASE IF EXISTS craigslist_db;

CREATE DATABASE craigslist_db;

\c craigslist_db

CREATE TABLE IF NOT EXISTS posts
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    content TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    region_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS users
(
    id SERIAL PRIMARY KEY,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL UNIQUE,
    last_name VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    pref_region_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS regions
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS categories
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS locations
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL
);


-- Create FKs
ALTER TABLE posts
    ADD    FOREIGN KEY (user_id)
    REFERENCES users(id)
;
    
ALTER TABLE users
    ADD    FOREIGN KEY (pref_region_id)
    REFERENCES regions(id)
;
    
ALTER TABLE posts
    ADD    FOREIGN KEY (region_id)
    REFERENCES regions(id)
;
    
ALTER TABLE posts
    ADD    FOREIGN KEY (location_id)
    REFERENCES locations(id)
;

ALTER TABLE posts
    ADD    FOREIGN KEY (category_id)
    REFERENCES categories(id)
;
    
-- Create Indexes
CREATE INDEX title_index ON posts (title);
CREATE INDEX username_index ON users (username);
CREATE INDEX password_index ON users (password);

-- Insert data

INSERT INTO regions
  (name)
VALUES
  ('northern'),
  ('southwestern'),
  ('central');

INSERT INTO categories
  (name)
VALUES
  ('Cleaning Service'),
  ('Cafe '),
  ('Tech world');

INSERT INTO locations
  (name)
VALUES
  ('St.mary'),
  ('Texas'),
  ('Mckinney');

INSERT INTO users
  (username, password, last_name, first_name, pref_region_id)
VALUES
  ('alpha', 'alpha123', 'Mark', 'Tiana', 2),
  ('beta', 'beta456', 'Long', 'Mikayla', 1);

INSERT INTO posts
  (title, content, user_id, location_id, region_id, category_id)
VALUES
  ('carpet cleaning', 'clean as if u purchase today! exc. cond.', 2,2,3,1), 
  ('John Deere coffee maker', 'Two years old; runs great!', 1,3,3,2),
  ('Laptops', 'Like New. Comes with charger', 2,1,3,3);

