CREATE DATABASE Project;
USE Project;

CREATE TABLE EVENT(Enumber INT NOT NULL,Title VARCHAR (50) NOT NULL,START DATETIME,END DATETIME,
Location VARCHAR(60),Manager_Id INT NOT NULL,Bill_Id INT NOT NULL,Customer_CNIC VARCHAR(13) NOT NULL,PRIMARY KEY(Enumber));

CREATE TABLE Employee(E_Id INT NOT NULL,NAME VARCHAR (30) NOT NULL,
Age INT,No_of_Hours INT,joining DATE,DOB DATE, salary INT,Address VARCHAR(60),PRIMARY KEY(E_Id));

CREATE TABLE Customer(CNIC VARCHAR(13) NOT NULL,Cname VARCHAR(30) NOT NULL,
Gender ENUM('M','F'),Age INT,Address VARCHAR(60),Contact_No VARCHAR(16),PRIMARY KEY(CNIC));

CREATE TABLE Bill(B_Id INT NOT NULL,Balanced_Ammount INT,Total_Amount INT,
Ammount_Recieved INT,Payment_Mode ENUM('Cash','Card','Cheque'),PRIMARY KEY (B_Id));

CREATE TABLE Participants(P_no INT NOT NULL,Age INT,Gender ENUM('M','F'),Remarks VARCHAR (60),PRIMARY KEY(P_no));

CREATE TABLE Manager(M_Id INT NOT NULL, PRIMARY KEY(M_Id), FOREIGN KEY (M_Id) REFERENCES Employee (E_Id));

CREATE TABLE Attended_BY(Participant_No INT NOT NULL,Event_No INT NOT NULL,
PRIMARY KEY(Participant_No,Event_No),FOREIGN KEY(Participant_No) REFERENCES Participants(P_no),
FOREIGN KEY(Event_No) REFERENCES EVENT(Enumber));

ALTER TABLE EVENT ADD CONSTRAINT FK_Manager_ID FOREIGN KEY (Manager_Id) REFERENCES Employee(E_Id);

ALTER TABLE EVENT ADD CONSTRAINT FK_Bill_ID FOREIGN KEY (Bill_Id) REFERENCES Bill(B_Id);

ALTER TABLE EVENT ADD CONSTRAINT FK_Customer_CNIC FOREIGN KEY (Customer_CNIC) REFERENCES Customer(CNIC);

#DML_Statements
#Insertion in Event table

INSERT INTO EVENT VALUES(1,'Farhan Birthday Party','2017-12-28 06:00:00','2017-12-28 10:00:00','Roysl Palm Hotel Lahore',1,1,'3520117120134');

INSERT INTO EVENT VALUES(2,'New Year Celebration Party','2017-12-31 10:00:00','2018-01-01 00:30:30','GymKhana Golf Club',2,2,'3520133124638');

INSERT INTO EVENT VALUES(3,'Office Party','2018-01-28 06:00:00','2018-02-28','DHA Main Plaza Lahore',3,3,'3520133124638');

#Insertion in Employee Table

INSERT INTO Employee VALUES(1,'Azhar Naeem',20,8,'2017-12-18','1999-8-10',75000,'House#486 Shah-Faisal Karachi');

INSERT INTO Employee VALUES(2,'Khizar Najam',21,8,'2018-12-18','1998-11-21',60000,'House#75 Street#20 Shah-Faisal colony  Karachi');

#Insertion in Customer Table

INSERT INTO customer VALUES('3520117120134','Wahab ul Haq','M',22,'House # 41 Street # 14 Mall Road Lahore','0332-3298769');

INSERT INTO customer VALUES('3520133124638','Ahmed Hassan','M',20,'House # 51 Drigh Road Cantt Bazar Karachi','0348-2665639');

#Insertion in Bill Table

INSERT INTO bill VALUES(1,5000,25000,30000,'Cash');

INSERT INTO bill VALUES(2,10000,30000,40000,'Cheque');

INSERT INTO bill VALUES(3,10000,30000,40000,'Card');

#Insertion in Participants Table

INSERT INTO Participants VALUES(1,25,'M',NULL);

INSERT INTO Participants VALUES(2,18,'F',NULL);

#insertion in manager Table

INSERT INTO manager VALUES(1);

INSERT INTO manager VALUES(2);

#Insert in Attended_by Table

INSERT INTO attented_by VALUES(1,2);

INSERT INTO attented_by VALUES(2,1);

#DML Statements to get output

SELECT Enumber AS 'Event NO',Title AS 'Event Title', CNIC AS 'Customer CNIC',Cname AS 'Customer Name' FROM EVENT,Customer WHERE Customer_CNIC=CNIC;

SELECT Enumber AS 'Event NO',Title AS 'Event Title', Manager_Id ,NAME AS 'Manager Name' FROM EVENT,employee WHERE Manager_Id=E_Id;

SELECT Enumber AS 'Event No',Title,Total_Amount AS 'Event Bill' FROM EVENT,Bill WHERE Enumber=2 AND Bill_Id=B_Id;

SELECT E_Id AS 'Employee ID', NAME AS 'Employee Name',Enumber AS 'Event No', Title FROM employee,EVENT WHERE Manager_Id = E_Id AND Salary>65000;

SELECT CNIC,COUNT(*) AS 'NO of Events Booked  by this CNIC' FROM EVENT,Customer WHERE Customer_CNIC=CNIC GROUP BY CNIC;

SELECT P_no,Event_No,Gender,Remarks,Age FROM Participants,Attended_by WHERE Participant_No=P_no AND Age>18;

SELECT M_Id,Salary FROM Employee,Manager WHERE E_Id=M_Id;

SELECT Enumber,Title,START,END,Location,Manager_Id,B_Id,CNIC,Cname,Gender,Age,Address<Contact_No,Balanced_Ammount,Total_Amount,Ammount_Recieved,
Payment_Mode FROM EVENT,Customer,Bill WHERE Customer_CNIC=CNIC AND Bill_Id=B_Id;

SELECT M_Id AS 'Manager ID',NAME AS 'Manager Name',Salary FROM Employee,
Manager WHERE E_Id=M_Id AND Salary<75000;

SELECT Location,COUNT(*) AS 'Number of Event at this Location' FROM EVENT GROUP BY Location HAVING COUNT(*)<=2;

SELECT SUM(salary) AS 'Sum of Employees Salary' FROM employee;

SELECT SUM(Total_Amount) AS 'Total Earning' FROM Bill;