DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL, 
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  user_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,
  
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)  
);

INSERT INTO
  users(fname, lname)
VALUES
  ("Jon", "Dominguez"), ("Daniel", "Moon"), ("Jessie", "Wong");

INSERT INTO 
  questions (title, body, user_id)
VALUES
  ("SQL Method", "sgsefesrtgesrgr", (SELECT id FROM users WHERE fname = "Daniel" AND lname = "Moon")),
  ("Name", "What's your name?", (SELECT id FROM users WHERE fname = "Jon" AND lname = "Dominguez"));
  
INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Jessie" AND lname = "Wong"),
   (SELECT id FROM questions WHERE title = "SQL Method")), 
  ((SELECT id FROM users WHERE fname = "Daniel" AND lname = "Moon"),
   (SELECT id FROM questions WHERE title = "Name"));
   

INSERT INTO
  replies (question_id, parent_reply_id, user_id, body)
VALUES
  (
    (SELECT id FROM questions WHERE title = "Name"),
    NULL,
    (SELECT id FROM users WHERE fname = "Daniel" AND lname = "Moon"),
    "My name is Daniel");
  

INSERT INTO
  replies (question_id, parent_reply_id, user_id, body)
VALUES
  (
    (SELECT id FROM questions WHERE title = "Name"),
    (SELECT id 
      FROM replies 
      WHERE body = "My name is Daniel" AND user_id = (
        SELECT id FROM users WHERE fname = "Daniel" AND lname = "Moon"
      )),
    (SELECT id FROM users WHERE fname = "Jon" AND lname = "Dominguez"),
    "Thanks for the reply!"
  );
  
  
  INSERT INTO
    question_likes(user_id, question_id)
  VALUES
    ((SELECT id FROM users WHERE fname = "Jessie" AND lname = "Wong"),
     (SELECT id FROM questions WHERE title = "Name")),
    
    ((SELECT id FROM users WHERE fname = "Jon" AND lname = "Dominguez"),
     (SELECT id FROM questions WHERE title = "SQL Method"));