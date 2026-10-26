create database if not exists LoanLens;
Use LoanLens;

-- table creation 

create table Branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name Varchar(40) Not null,
    city varchar(50) not null
);

create table Customers (
    customer_id int primary key AUTO_INCREMENT,
    customer_name varchar(50) not null,
    email varchar(100) unique,
    phone varchar(15),
    annual_income decimal(12,2),
    join_date date not null,
    branch_id int,
    FOREIGN KEY (branch_id)references Branches(branch_id)
);

create table Loan_Types (
    loan_type_id int primary key AUTO_INCREMENT,
    loan_type_name varchar(50) not null unique, 
    interest_rate decimal(5,2) not null,
    max_amount decimal(12,2) not null
);

create table Loan_Applications (
    application_id int primary key AUTO_INCREMENT,
    customer_id int not null,
    loan_type_id int not null,
    application_date date not null, 
    status varchar(20) default 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (loan_type_id) REFERENCES Loan_Types(loan_type_id)
);

create table Loans (
    loan_id int primary key auto_increment,
    customer_id int not null,
    application_id int not null unique,
    loan_type_id int not null,
    branch_id int not null,
    amount decimal(12,2) not null,
    status varchar(20) default 'Active',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (loan_type_id) REFERENCES Loan_Types(loan_type_id),
    FOREIGN KEY (application_id) REFERENCES Loan_Applications(application_id),
    FOREIGN KEY (branch_id) REFERENCES Branches (branch_id)
);

create table Repayment_Schedules (
    schedule_id int primary key auto_increment, 
    loan_id int not null,
    due_date date not null,
    due_amount decimal(12,2) not null, 
    paid_amount decimal(12,2) default 0,
    status varchar (20) default 'Pending',
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);

create table Payments(
    payment_id int primary key auto_increment, 
    loan_id int not null, 
    payment_date date not null,
    amount_paid decimal(12,2) not null,
    payment_mode varchar(30),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);

create table Income_Records (
    income_id int primary key auto_increment, 
    customer_id int not null,
    income decimal(12,2) not null,
    employment_type varchar(30),
    record_date date not null,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

Alter table customers add column gender varchar(15), add COLUMN age int , ADD COLUMN employment_status varchar(30);
Alter table loan_types add column tenure int not null default 12;

show tables;
describe branches;
describe loan_types;
describe loans;
DESCRIBE Customers;
DESCRIBE Loan_Applications;
DESCRIBE Repayment_Schedules;
DESCRIBE Payments;
DESCRIBE Income_Records;

-- insert values 

Insert into branches (branch_id,branch_name,city) values 
(1,'Connaught Place','New Delhi'),
(2,'Sector 18','Noida'),
(3, 'Jaipur Central', 'Jaipur'),
(4, 'Cyber City', 'Gurugram'),
(5, 'Lucknow Main', 'Lucknow');

INSERT INTO Customers
(customer_id, customer_name, email, phone, annual_income,
 join_date, branch_id, gender, age, employment_status)
VALUES
(1, 'Aanya Sharma', 'aanya@example.com', '9000000001', 600000, '2024-01-10', 1, 'Female', 28, 'Salaried'),
(2, 'Rohan Verma', 'rohan@example.com', '9000000002', 900000, '2023-05-12', 2, 'Male', 35, 'Salaried'),
(3, 'Meera Gupta', 'meera@example.com', '9000000003', 360000, '2024-03-18', 3, 'Female', 24, 'Self-employed'),
(4, 'Arjun Singh', 'arjun@example.com', '9000000004', 240000, '2022-11-02', 4, 'Male', 42, 'Self-employed'),
(5, 'Kavya Patel', 'kavya@example.com', '9000000005', 480000, '2024-06-20', 5, 'Female', 31, 'Salaried'),
(6, 'Ishaan Rao', 'ishaan@example.com', '9000000006', 180000, '2023-08-14', 1, 'Male', 22, 'Student'),
(7, 'Diya Kapoor', 'diya@example.com', '9000000007', 1200000, '2022-02-08', 2, 'Female', 39, 'Salaried'),
(8, 'Kabir Joshi', 'kabir@example.com', '9000000008', 300000, '2024-09-01', 3, 'Male', 29, 'Self-employed'),
(9, 'Sara Khan', 'sara@example.com', '9000000009', 420000, '2023-12-11', 4, 'Female', 26, 'Salaried'),
(10, 'Aditya Das', 'aditya@example.com', '9000000010', 720000, '2022-07-25', 5, 'Male', 45, 'Salaried');

INSERT INTO Loan_Types
(loan_type_id, loan_type_name, interest_rate, max_amount, tenure)
VALUES
(1, 'Personal Loan', 12.50, 500000, 36),
(2, 'Home Loan', 8.50, 5000000, 240),
(3, 'Education Loan', 7.50, 1500000, 120),
(4, 'Business Loan', 11.00, 2000000, 60),
(5, 'Vehicle Loan', 9.00, 1200000, 60);

INSERT INTO Loan_Applications
(application_id, customer_id, loan_type_id, application_date, status)
VALUES
(1, 1, 1, '2025-01-05', 'Approved'),
(2, 2, 2, '2025-01-12', 'Approved'),
(3, 3, 3, '2025-02-01', 'Approved'),
(4, 4, 4, '2025-02-15', 'Approved'),
(5, 5, 5, '2025-03-03', 'Approved'),
(6, 6, 3, '2025-03-20', 'Pending'),
(7, 7, 2, '2025-04-02', 'Approved'),
(8, 8, 1, '2025-04-10', 'Rejected'),
(9, 9, 4, '2025-05-01', 'Approved'),
(10, 10, 5, '2025-05-15', 'Approved'),
(11, 1, 3, '2025-06-01', 'Approved'),
(12, 3, 1, '2025-06-12', 'Pending');

INSERT INTO Loans
(loan_id, customer_id, application_id, loan_type_id, branch_id, amount, status)
VALUES
(1, 1, 1, 1, 1, 200000, 'Active'),
(2, 2, 2, 2, 2, 2500000, 'Active'),
(3, 3, 3, 3, 3, 400000, 'Active'),
(4, 4, 4, 4, 4, 700000, 'Active'),
(5, 5, 5, 5, 5, 600000, 'Active'),
(6, 7, 7, 2, 2, 3000000, 'Active'),
(7, 9, 9, 4, 4, 500000, 'Active'),
(8, 10, 10, 5, 5, 800000, 'Closed'),
(9, 1, 11, 3, 1, 300000, 'Active');

INSERT INTO Repayment_Schedules
(schedule_id, loan_id, due_date, due_amount, paid_amount, status)
VALUES
(1, 1, '2025-07-05', 10000, 10000, 'Paid'),
(2, 1, '2025-08-05', 10000, 10000, 'Paid'),
(3, 1, '2025-09-05', 10000, 5000, 'Overdue'),
(4, 2, '2025-07-12', 25000, 25000, 'Paid'),
(5, 2, '2025-08-12', 25000, 0, 'Overdue'),
(6, 3, '2025-08-01', 8000, 8000, 'Paid'),
(7, 3, '2025-09-01', 8000, 0, 'Overdue'),
(8, 4, '2025-08-15', 18000, 18000, 'Paid'),
(9, 4, '2025-09-15', 18000, 0, 'Overdue'),
(10, 5, '2025-09-03', 15000, 15000, 'Paid'),
(11, 6, '2025-09-02', 30000, 0, 'Pending'),
(12, 7, '2025-09-01', 14000, 7000, 'Overdue'),
(13, 8, '2025-09-15', 16000, 16000, 'Paid'),
(14, 9, '2025-09-01', 9000, 0, 'Pending'),
(15, 1, '2025-10-05', 10000, 0, 'Pending');

INSERT INTO Payments
(payment_id, loan_id, payment_date, amount_paid, payment_mode)
VALUES
(1, 1, '2025-07-05', 10000, 'UPI'),
(2, 1, '2025-08-05', 10000, 'Bank Transfer'),
(3, 1, '2025-09-05', 5000, 'UPI'),
(4, 2, '2025-07-12', 25000, 'Bank Transfer'),
(5, 3, '2025-08-01', 8000, 'UPI'),
(6, 4, '2025-08-15', 18000, 'Cheque'),
(7, 5, '2025-09-03', 15000, 'UPI'),
(8, 7, '2025-09-01', 7000, 'Bank Transfer'),
(9, 8, '2025-09-15', 16000, 'UPI');

INSERT INTO Income_Records
(income_id, customer_id, income, employment_type, record_date)
VALUES
(1, 1, 550000, 'Salaried', '2024-01-10'),
(2, 1, 600000, 'Salaried', '2025-01-10'),
(3, 2, 850000, 'Salaried', '2024-05-12'),
(4, 2, 900000, 'Salaried', '2025-05-12'),
(5, 3, 300000, 'Self-employed', '2024-03-18'),
(6, 3, 360000, 'Self-employed', '2025-03-18'),
(7, 4, 240000, 'Self-employed', '2025-02-02'),
(8, 5, 480000, 'Salaried', '2025-06-20'),
(9, 6, 180000, 'Student', '2025-03-20'),
(10, 7, 1200000, 'Salaried', '2025-04-02'),
(11, 8, 300000, 'Self-employed', '2025-04-10'),
(12, 9, 420000, 'Salaried', '2025-05-01'),
(13, 10, 720000, 'Salaried', '2025-05-15');

SELECT 'Branches' AS table_name, COUNT(*) AS total FROM Branches
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Loan_Types', COUNT(*) FROM Loan_Types
UNION ALL
SELECT 'Loan_Applications', COUNT(*) FROM Loan_Applications
UNION ALL
SELECT 'Loans', COUNT(*) FROM Loans
UNION ALL
SELECT 'Repayment_Schedules', COUNT(*) FROM Repayment_Schedules
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments
UNION ALL
SELECT 'Income_Records', COUNT(*) FROM Income_Records;

SELECT
    B.branch_name,
    B.city,
    COUNT(L.loan_id) AS total_loans,
    SUM(L.amount) AS total_disbursed
FROM Branches B
LEFT JOIN Loans L
    ON B.branch_id = L.branch_id
GROUP BY B.branch_id, B.branch_name, B.city
ORDER BY total_disbursed DESC;

use loanlens;
SELECT
    LT.loan_type_name,
    COUNT(RS.schedule_id) AS total_overdue_installments,
    SUM(RS.due_amount - RS.paid_amount) AS outstanding_amount
FROM Loan_Types LT
JOIN Loans L
    ON LT.loan_type_id = L.loan_type_id
JOIN Repayment_Schedules RS
    ON L.loan_id = RS.loan_id
WHERE RS.status = 'Overdue'
GROUP BY LT.loan_type_id, LT.loan_type_name
ORDER BY outstanding_amount DESC;