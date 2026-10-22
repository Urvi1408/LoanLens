create database if not exists LoanLens;
Use LoanLens;

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

