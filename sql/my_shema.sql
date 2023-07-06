CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  publisher VARCHAR(255),
  cover_state VARCHAR(255),
  publish_date DATE,
  archived BOOLEAN,
  label VARCHAR(255),
  color VARCHAR(255)
);
-- label table 
CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  color VARCHAR(255)
  
);