CREATE DATABASE IF NOT EXISTS mydatabase;

CREATE USER IF NOT EXISTS 'myuser'@'%' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON mydatabase.* TO 'myuser'@'%';
FLUSH PRIVILEGES;

USE mydatabase;

CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(255) NOT NULL
);

-- Inserting initial data into the books table
INSERT INTO books (id, title, author) VALUES (1, 'To Kill a Mockingbird', 'Harper Lee');
INSERT INTO books (id, title, author) VALUES (2, '1984', 'George Orwell');
INSERT INTO books (id, title, author) VALUES (3, 'Pride and Prejudice', 'Jane Austen');
INSERT INTO books (id, title, author) VALUES (4, 'The Great Gatsby', 'F. Scott Fitzgerald');
