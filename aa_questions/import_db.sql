CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL, 
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  
  FOREIGN KEY () REFERENCES ()
)

