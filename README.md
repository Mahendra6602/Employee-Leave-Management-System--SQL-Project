Employee Leave Management System

A MySQL-based Employee Leave Management System created to practice and demonstrate SQL database concepts using a real-world leave management scenario.

📌 Project Overview

This project manages:

Employees

Departments

Managers

Leave Types

Leave Requests

Leave Request Logs

Leave Status History

It contains SQL queries for retrieving, filtering, joining, grouping, and analyzing employee leave data. The project also includes views, transactions, stored-procedure work, and trigger-based logging.

🗂️ Database Structure

Main Tables

Table

Purpose

departments

Stores department details

managers

Stores manager details

leave_types

Stores different types of leave

employees

Stores employee information and department relationship

leave_requests

Stores employee leave requests

leave_request_log

Stores information about newly inserted leave requests

leave_status_history

Stores old and new leave status information

Table Relationships

departments
     │
     └── employees
            │
            └── leave_requests
                 ├── managers
                 └── leave_types

leave_requests uses foreign keys to connect employees, managers, and leave types.

🔎 SQL Operations and Analysis

The project includes queries to:

List all leave requests

Display leave requests with employee names

Find approved, pending, and rejected requests

Find employees currently on leave

Count leave requests department-wise

Count leave requests by status

Calculate average leave days by department

Find employees with maximum leave days

Find the department with maximum leave requests

Find employees who never applied for leave

Display the latest 5 leave requests

Find leave requests from the last 30 days

Calculate leave duration

Generate leave references such as EL-1001

Generate monthly leave statistics

Compare employee leave days with department averages

👁️ Views

The project creates views for frequently required leave information:

CREATE VIEW approved_leaves AS
SELECT *
FROM leave_requests
WHERE now_status = 'Approved';

CREATE VIEW pending_leaves AS
SELECT *
FROM leave_requests
WHERE now_status = 'Pending';

🔄 Transactions

A transaction is used to approve a leave request:

START TRANSACTION;

UPDATE leave_requests
SET now_status = 'Approved'
WHERE leave_id = 1002;

COMMIT;

⚙️ Stored Procedure

The project includes work on a stored procedure to calculate the total number of approved leave days taken by an employee.

Example usage:

CALL employee_total_leave_days(101);

🔔 Triggers

The project includes trigger exercises for automatic tracking of leave information.

Leave Request Log

When a new leave request is inserted, the trigger is designed to store:

leave_id

employee_id

leave_type_id

now_status

created_date

in the leave_request_log table.

Leave Status History

When a leave request status changes, the trigger is designed to store:

leave_id

employee_id

old_status

new_status

change_date

in the leave_status_history table.

🧠 SQL Concepts Practiced

Database and table creation

Primary keys

Foreign keys

Data insertion

SELECT, UPDATE

JOIN

GROUP BY

HAVING

Aggregate functions: COUNT(), AVG(), MAX(), SUM()

Subqueries

ORDER BY and LIMIT

Date functions: DATEDIFF(), CURDATE(), INTERVAL

String functions: UPPER(), LOWER(), LEFT(), CONCAT()

Views

Transactions

Stored Procedures

Triggers

🛠️ Technologies Used

MySQL

SQL

MySQL Workbench

▶️ How to Run

Install MySQL and MySQL Workbench.

Open the mahesql.sql file in MySQL Workbench.

Run the database and table creation statements.

Insert the sample data.

Execute the SQL queries to view and analyze the leave data.

Execute the views, transactions, stored-procedure, and trigger exercises as required.

📁 Project Files

Employee-Leave-Management/
│
├── mahesql.sql
└── README.md

mahesql.sql

Contains the database creation, table definitions, sample data, SQL queries, views, transaction, stored-procedure work, and trigger exercises.

🎯 Objective

The main objective of this project is to build practical SQL skills by designing and querying an employee leave management database and applying SQL concepts to common business requirements.

Project Type: SQL / Database Project
Database: MySQL
