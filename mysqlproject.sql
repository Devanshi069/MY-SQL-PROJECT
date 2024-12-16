/*Project : Library Management System



Project Overview:
The Library Management System (LMS) aims to manage books, users (members), book loans, and overdue fines.
 The system should keep track of books available in the library, their status (borrowed or available),
 and allow members to borrow and return books. Additionally, it will calculate overdue fines for books 
 returned after their due date. This scenario will simulate a small library system.



Project Scenario:
Library Name: City Central Library
Library Manager: Sarah Mitchell
Library Staff: John, Emma, and Lucas
Members: Alice, Bob, Charlie, and Diana
Books: 100 books in various categories, including fiction, non-fiction, and educational */


-- Create Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    category_id INT,
    publish_date DATE,
    stock_quantity INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Create Users Table (Library Members)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    join_date DATE
);

-- Create Loans Table (Tracks borrowed books)
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    loan_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Fines Table (Tracks overdue fines)
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);



-- Insert Authors
INSERT INTO Authors (name) 
VALUES ('J.D. Salinger'), 
       ('Jane Doe'),
       ('F. Scott Fitzgerald');

 
-- Insert Categories
INSERT INTO Categories (name) 
VALUES ('Fiction'), 
       ('Educational'), 
       ('Non-fiction');

-- Insert Books
INSERT INTO Books (title, author_id, category_id, publish_date, stock_quantity) 
VALUES ('The Catcher in the Rye', 1, 1, '1951-07-16', 5),
       ('Data Science for Beginners', 2, 2, '2020-05-01', 3),
       ('The Great Gatsby', 3, 1, '1925-04-10', 4),
       ('The Power of Habit', 2, 3, '2012-12-11', 2);

-- Insert Users (Members)
INSERT INTO Users (first_name, last_name, email, join_date) 
VALUES ('Alice', 'Johnson', 'alice.johnson@email.com', '2024-12-01'),
       ('Bob', 'Smith', 'bob.smith@email.com', '2024-06-01'),
       ('Charlie', 'Williams', 'charlie.williams@email.com', '2024-11-10'),
       ('Diana', 'Brown', 'diana.brown@email.com', '2024-08-15');

-- Insert Loans (Simulating Book Borrowing)
INSERT INTO Loans (book_id, user_id, loan_date, due_date) 
VALUES (1, 1, '2024-12-01', '2024-12-15'), -- Alice borrows "The Catcher in the Rye"
       (2, 1, '2024-12-01', '2024-12-15'), -- Alice borrows "Data Science for Beginners"
       (3, 2, '2024-11-15', '2024-12-01'); -- Bob borrows "The Great Gatsby"

-- Insert Fines (Bob incurs a fine for overdue book)
INSERT INTO Fines (loan_id, amount) 
VALUES (1, 5.00);  




 -- 1 View All Available Books --

SELECT b.title, a.name AS author, c.name AS category, b.stock_quantity
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
JOIN Categories c ON b.category_id = c.category_id
WHERE b.stock_quantity > 0;


-- 2 View Books Borrowed by a User

SELECT u.first_name, u.last_name, b.title, l.loan_date, l.due_date, l.return_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Users u ON l.user_id = u.user_id
WHERE u.first_name = 'Alice';




-- 3 Borrow a Book

-- Assume Charlie borrows "The Power of Habit"
INSERT INTO Loans (book_id, user_id, loan_date, due_date) 
VALUES (4, 3, CURDATE(), CURDATE() + INTERVAL 15 DAY);

-- 4 Update the stock quantity of the book
UPDATE Books SET stock_quantity = stock_quantity - 1 WHERE book_id = 4;


-- 5. Final Project Summary
/*Project Name: City Central Library Management System (LMS)

Features:

Books Management: Add, update, and track books by title, author, category, and stock.
Member Management: Register users (members) and track their book loans.
Loan Management: Borrow and return books, track overdue loans, and calculate fines.
Fines Management: Automatically calculate overdue fines based on days late.
Stock Management: Automatically update book stock when borrowed or returned. */