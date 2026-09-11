CREATE DATABASE project;
use project;
create table Departments(department_id int primary key,depart_name varchar(70));
select * from leave_requests;


create table managers(manager_id int primary key,manager_name varchar(40));
create table leave_types(leave_type_id int primary key,leave_type_name varchar(40));
create table employees(employee_id int primary key,department_id int,employee_name varchar(40),phone varchar(11),email varchar(70),foreign key (department_id) references departments (department_id));
create table leave_requests(leave_id int  primary key,employee_id int,manager_id int,leave_type_id int,start_date date ,end_date date,total_days int, now_status varchar(40),reason varchar(140),foreign key (employee_id) references employees(employee_id),foreign key (manager_id) references managers (manager_id),foreign key (leave_type_id) references leave_types (leave_type_id));

#data inserion:
#Departments

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Administration');


#Managers

INSERT INTO managers VALUES
(1, 'Ramesh'),
(2, 'Priya'),
(3, 'Kiran'),
(4, 'Sneha'),
(5, 'Arun');


# Leave Types

INSERT INTO Leave_Types VALUES
(1, 'Casual Leave'),
(2, 'Sick Leave'),
(3, 'Earned Leave'),
(4, 'Maternity Leave'),
(5, 'Unpaid Leave');


#Employees

INSERT INTO employees VALUES
(101, 1, 'Aarav', '9876500001', 'aarav@mail.com'),
(102, 2, 'Bhavya', '9876500002', 'bhavya@mail.com'),
(103, 3, 'Charan', '9876500003', 'charan@mail.com'),
(104, 4, 'Divya', '9876500004', 'divya@mail.com'),
(105, 5, 'Esha', '9876500005', 'esha@mail.com'),
(106, 2, 'Farhan', '9876500006', 'farhan@mail.com'),
(107, 1, 'Gopi', '9876500007', 'gopi@mail.com'),
(108, 3, 'Hari', '9876500008', 'hari@mail.com'),
(109, 4, 'Isha', '9876500009', 'isha@mail.com'),
(110, 5, 'John', '9876500010', 'john@mail.com');


# Leave Requests

INSERT INTO leave_requests VALUES
(1001, 101, 1, 1, '2026-07-01', '2026-07-03', 3, 'Approved', 'Personal work'),
(1002, 102, 2, 2, '2026-07-02', '2026-07-04', 3, 'Pending', 'Fever'),
(1003, 103, 3, 3, '2026-07-05', '2026-07-06', 2, 'Approved', 'Vacation'),
(1004, 104, 4, 1, '2026-07-07', '2026-07-08', 2, 'Rejected', 'Family function'),
(1005, 105, 5, 5, '2026-07-10', '2026-07-12', 3, 'Approved', 'Personal'),
(1006, 106, 2, 2, '2026-07-11', '2026-07-11', 1, 'Pending', 'Medical'),
(1007, 107, 1, 1, '2026-07-13', '2026-07-15', 3, 'Approved', 'Travel'),
(1008, 108, 3, 3, '2026-07-16', '2026-07-20', 5, 'Approved', 'Vacation'),
(1009, 109, 4, 2, '2026-07-18', '2026-07-19', 2, 'Rejected', 'Sick'),
(1010, 110, 5, 1, '2026-07-21', '2026-07-22', 2, 'Pending', 'Personal');


select * from employees;
select * from managers;
select * from departments;
select * from leave_types;
select * from leave_requests;


#tasks:
#List all leave requests 
select * from leave_requests;
#Display leave request with employee name. 
select employees.employee_name,leave_requests.* from leave_requests join employees  on leave_requests.employee_id = employees.employee_id;
#Show approved leave requests. 
select * from leave_requests where now_status = 'Approved';
#show pending leave requests.
select * from leave_requests where now_status = 'Pending' ;
#Employees currently on leave. -want to do
select e.employee_name,lr.* from leave_requests lr join employees e on e.employee_id = lr.employee_id where '2026-07-11' between lr.start_date and lr.end_date;#
#Count leave requests department-wise. 
select count(leave_id) as cout_of_dept_leaves,d.depart_name from leave_requests lr join employees e on e.employee_id=lr.employee_id join departments d on d.department_id = e.department_id group by d.depart_name;

#Count leave requests by status.
select count(leave_id) as leave_request_count,now_status from leave_requests group by now_status;
#Average leave days by department.
select d.depart_name,avg(total_days) as each_department_avg from leave_requests lr join employees e on e.employee_id=lr.employee_id join departments d on e.department_id = d.department_id group by d.depart_name;

#Employee with maximum leave days.
select e.employee_id,e.employee_name,lr.total_days as max_leave_requests_employees from leave_requests lr join employees e on  e.employee_id = lr.employee_id where lr.total_days =(select max(total_days) from leave_requests);
# Department with maximum leave requests.
select d.depart_name,count(lr.total_days )as max_leave_requests_department from leave_requests lr join employees e on e.employee_id = lr.employee_id join departments d on d.department_id=e.department_id group by  d.depart_name order by max_leave_requests_department desc limit 1;



#Employees with more than 2 leave requests.
select e.employee_id, e.employee_name, count(lr.leave_id) as leave_request_count from leave_requests lr join employees e on e.employee_id = lr.employee_id group by e.employee_id, e.employee_name having count(lr.leave_id) > 2;#we have only 1 request

#Employees who never applied for leave
select e.employee_id,e.employee_name from employees e left join leave_requests lr on e.employee_id = lr.employee_id where lr.leave_id is null;

#Latest 5 leave requests.
select * from leave_requests order by start_date desc limit 5;

#Leave requests in last 30 days.
select * from leave_requests where start_date >= curdate() - interval 30 day;
select *from leave_requests where start_date >= '2026-07-22' - interval 30 day;

#Display employee names in uppercase and lowercase.
select upper(employee_name) as uppercase_name, lower(employee_name) as lowercase_name from employees;
#Show first 3 characters of employee names.
select employee_name, left(employee_name,3) as first_three_characters from employees;
#Calculate leave duration.
select leave_id, datediff(end_date,start_date)+1 as leave_duration from leave_requests;
#Generate Leave Reference (EL-1001).
select leave_id, concat('EL-',leave_id) as leave_reference from leave_requests;
#Leave types used more than 5 times.
select lt.leave_type_name, count(lr.leave_type_id) as usage_count from leave_requests lr join leave_types lt on lr.leave_type_id=lt.leave_type_id group by lt.leave_type_id,lt.leave_type_name having count(lr.leave_type_id)>5;
# Manager-wise approved leave count.
select m.manager_id,m.manager_name,count(lr.leave_id) as approved_leave_count from managers m join leave_requests lr on m.manager_id=lr.manager_id where lr.now_status='Approved' group by m.manager_id,m.manager_name;

#Employees whose leave exceeds department average.
select e.employee_name,lr.total_days from leave_requests lr join employees e on lr.employee_id=e.employee_id where lr.total_days>(select avg(lr2.total_days) from leave_requests lr2 join employees e2 on lr2.employee_id=e2.employee_id where e2.department_id=e.department_id);

#22. Show monthly leave statistics.
select month(start_date) as month_number,count(leave_id) as leave_request_count,sum(total_days) as total_leave_days from leave_requests group by month(start_date);
#23. Longest leave taken.
select e.employee_name,lr.total_days from leave_requests lr join employees e on lr.employee_id=e.employee_id where lr.total_days=(select max(total_days) from leave_requests);
#24. Remaining leave balance.

#25. Open leave requests.
select * from leave_requests where now_status='Pending';
#26. Rejected leave requests.
select * from leave_requests where now_status='Rejected';
#27. Create a view for approved leaves.
create view approved_leaves as select * from leave_requests where now_status='Approved';
#28. Create a view for pending leaves.
create view pending_leaves as select * from leave_requests where now_status='Pending';
#29. Transaction to approve leave request.
start transaction; update leave_requests set now_status='Approved' where leave_id=1002; commit;
#30. Transaction to cancel leave request and restore balance.

#31. Create a stored procedure to display leave requests handled by a particular manager.
call employee_leave_system.employee_leave_days(1employee_leave_days);
drop procedure manager_leave_requests;
#32Create a stored procedure to calculate the total number of leave days taken by an employee
#Input: employee_id
#Consider only leave requests with status Approved

call employee_total_leave_days(101);
select employee_id, total_days, now_status from leave_requests where now_status = 'Approved';#just for checking

#33.Create a trigger on the Leave_Requests table.
#Whenever a new leave request is inserted, automatically store the leave_id, employee_id, leave_type_id, and status in a Leave_Request_Log table.
#The log table should also store the date on which the request was created.
create table leave_request_log (
    leave_id int,
    employee_id int,
    leave_type_id int,
    now_status varchar(50),
    created_date date
);
use project;
select * from leave_request_log;
select max(leave_id) from leave_requests;
insert into leave_requests
(leave_id, employee_id, manager_id, leave_type_id, start_date, end_date, total_days, now_status, reason)
values
(1014, 101, 1, 1, '2026-09-15', '2026-09-17', 3, 'Pending', 'test trigger');
select * from leave_request_log;

#34. Create a trigger on Leave_Requests.
# Whenever a leave request's status changes, store the leave_id, employee ID, old status, new status, and change date in a Leave_Status_History table.
create table leave_status_history (
    leave_id int,
    employee_id int,
    old_status varchar(50),
    new_status varchar(50),
    change_date date
);
update leave_requests
set now_status = 'Approved'
where leave_id = 1014;
select * from leave_status_history;