#/*Question 1:
#Consider the following relational schema:

#	Staff		(staffNo, name, dept, skillCode)
#	Skill		(skillCode, description, chargeOutRate)
#	Project		(projectNo, startDate, endDate, budget, projectManagerStaffNo)
#	Booking	(staffNo, projectNo, dateWorkedOn, timeWorkedOn)
	
#	where:	Staff	contains staff details and staffNo is the key.
#	Skill 		contains descriptions of skill codes (e.g. Programmer, Analyst, 
#	Manager, etc.) and the charge out rate per hour for that skill; 
#       the key is skillCode. 
#	Project contains project details and projectNo is the key. 
#	Booking	contains details of the date and the number of hours that a member of staff worked on a project and the key is staffNo/projectNo.*/

#Answer: 1
#Formulate the following queries using SQL (1 & 2)
#1.	For all projects that were active in July 1995, list the staff name, project number and the date and number of hours worked on the project, ordered by staff name, within staff name by the project number and within project number by date.

Select name, P. projectNo, dateWorkedOn, timeWorkedOn 
From Staff S, Booking B, Project P WHERE 
P. projectNo= B. projectNo 
and S. staffNo =B. staffNo
and P. endDate > = 01-Jul-1995 
Order by name, projectNo, dateWorkedOn;

#Question 2: Create a view of staff details giving the staff number, staff name, skill description, and department, but excluding the skill number and charge out rate.

#Answer 2: 
Create view Staff_vw as
Select S. staffNo, S. name, SL. description, S. Dept
From Staff S, Skill SL
Where S. skillCode = SL. SkillCode;

The following tables form part of a database held in a Relational Database Management System. Use this schema to answer queries 3, 4, 5, & 6.

	Employee	(empID, fName, lName, address, DOB, sex, position, deptNo)
	Department	(deptNo, deptName, mgrEmpID)
	Project		(projNo, projName, deptNo)
	WorksOn	(empID, projNo, hoursWorked)

	where	Employee contains employee details and empID is the key.
	Department 	contains department details and deptNo is the key. mgrEmpID identifies the employee who is the manager of the department. There is only one manager for each department.
	Project	 contains details of the projects in each department and the key is projNo (no two departments can run the same project) and WorksOn contains details of the hours worked by employees on each project, and empID/projNo form the key.

#Question 3: Produce a complete list of all managers who are due to retire this year, in alphabetical order of surname.
Suppose retirement age is 60:

Select lName From Department D, Employee E 
Where 
D. mgrEmpID=E. EmpID
And ((Sysdate-DOB)/365.25)>=60
Order by lName;

#Question 4: Find out how many employees are managed by ‘James Adams’.

Select COUNT(*) From Employee E , Department D
Where 
D. deptNo = E. deptNo
And D.mgrEmpID = E.empID
And fName =’James’ and lName = ‘Adams’;

#Question 5:	Produce a report of the total hours worked by each employee, arranged in order of department number and within department, alphabetically by employee surname.

Select  Sum(hoursWorked), D.deptNo, E. lName  
From WorksOn W, Employee E , Department D
Where 
W. empID = E. empID
Group By D.deptNo, E. lName  
Order by D.deptNo, E.lName;

#Question 6:	For each project on which more than two employees worked, list the project number, project name and the number of employees who work on that project.

Select P.projNo, P.projName, count(E.empID) 
From Project P, WorksOn W
Where
P. projNo = W. projNo
Group By P.projNo, P.projName
Having count(E.empID) >2;

#-------------------------------
The relational schema shown below is part of a hospital database. The primary keys are highlighted in bold.

	Patient (patientNo, patName, patAddr, DOB)
	Ward (wardNo, wardName, wardType, noOfBeds)
	Contains (patientNo, wardNo, admissionDate)
	Drug (drugNo, drugName, costPerUnit)
  Prescribed (patientNo, drugNo, unitsPerDay, startDate, finishDate)
				         		
	Formulate the following SQL statements using the above schema (7, 8, & 9)


#Question 7: What is the total cost of Morphine supplied to a patient called ‘John Smith’ ?

Select SUM(D.costPerUnit) 
From Drug D , Prescribed P , Patient Pat
Where
P. drugNo = D. drugNo
And P. patientNo=Pat. patientNo
And Pat. patName = ‘John Smith’
And D. drugName = ‘Morphine’;

#Question 8:	For each ward that admitted more than 10 patients today, list the ward number, ward type and number of beds in each ward.

Select W. wardNo, W. wardType, W. noOfBeds 
From Ward W , Contains C , Patient Pat
Where
W. wardNo = C. wardNo
And Pat. patientNo = C. patientNo
And C.admissionDate =Sysdate
Having count(C. patientNo) > 10;


#Question 9:	List the numbers and names of all patients and the drugNo and number of units of their medication. The list should also include the details of patients that are not prescribed medication.

Select Pat.patientNo, Pat.patName, P. drugNo , P.unitsPerDay 
From  
Patient Pat 
Left Join Prescribed P
On P. patientNo=Pat. patientNo;

#-----------------------------------------------------
A relational database contains details about journeys from Paisley to a variety of destinations and contains the following relations:

		Operator (opCode, opName)
		Journey (opCode, destinationCode, price)
		Destination (destinationCode, destinationName, distance)

	Each operator is assigned a unique code (opCode) and the relation operator records the association between this code and the operator’s name (opName). Each destination has a unique code (destinationCode) and the relation destination records the association between this code and the destination name (destinationName), and the distance of the destination from Paisley. The relation Journey records the price of an adult fare from Paisley to the given destination by as specified operator, several operators may operate over the same route.

Formulate the following queries using SQL (10, 11, & 12)

#Question 10:	List the names of all operators with at least one journey priced at under £5.

Select opName 
From Operator O, Journey J
Where 
J. opCode=O. opCode
And J. price<5;


#Question 11:	List the names of all operators and prices of journeys to ‘Ayr’.

Select O. opName, J. price 
From Operator O, Journey J, Destination D
Where 
J. destinationCode=D. destinationCode
And J. opCode=O. opCode
And D. destinationName = ’Ayr’


#Question 12:	List the names of all destinations that do not have any operators.

Select destinationName 
From Destination D, Operator O, Journey J
Where 
J. destinationCode=D. destinationCode
And J. opCode <> O. opCode

The following tables form part of a database held in a Relational Database Management System:

	Employee	(empNo, eName, salary, position)
	Aircraft	(aircraftNo, aName, aModel, flyingRange)
	Flight		(flightNo, from, to, flightDistance, departTime, arriveTime)
	Certified	(empNo, aircraftNo)

	where	Employee contains details of all employees (pilots and non-pilots) and empNo is the key. 
  AirCraft contains details of aircraft and aircraftNo is the key. 
  Flight contains details of the flights and flightNo is the key.
	and Certified contains details of the staff who are certified to fly an aircraft, and     
  empNo/aircraftNo form the key.

Formulate the following queries in SQL (13, 14, 15, & 16)

#Question 13:	List the employee numbers of employees who have the highest salary.

Select empNo 
From Employee E1
Where 
E1. Salary In (Select max(E2.Salary) from Employee E2);


#Question 14:	List the employee numbers of employees who have the second highest salary.

Select empNo From Employee E1 
Where E1.Salary In 
(Select max(E2.Salary) from Employee E2 
Where Salary Not In 
(Select max(E3.Salary) from Employee E3);


#Question 15: List the employee numbers of employees who are certified for exactly three aircraft.

Select E.empNo From Certified C, Employee E
Where E.empNo = C.empNo
Group By E.empNo
Having count(aircraftNo) = 3;

#Question 16:	Assume that the following tables are part of a Company database schema
    Customer(custNo, custName, address, sex, DOB, creditLimit) 
    HighCredit(hcCustNo, hcCustName, hcCreditLimit)

Create a PL/SQL procedure object in your schema. Using a prompt variable to retrieve record of a customers and check his/her credit limit. If a customer credit limit is greater than 100000 the procedure should insert a record in the table HighCredits.

#Answer 16:

SET SERVEROUTPUT ON

DECLARE 

I_custNo Customer.custNo%TYPE;

I_custName Customer.custName%TYPE;

I_creditLimit Customer.creditLimit %TYPE;

BEGIN 

DBMS_OUTPUT.ENABLE;

If (Customer. creditLimit > 100000) 
Then

Insert into HighCredit values (‘&I_custNo’, ‘&I_custName’, ‘&I_creditLimit’);

END IF;

END;

#Question 17:	Assume the following tables:

Order(orderNo, statusCode, customerNo,…)
Item(itemNo, orderNo, price, amount,…)

which capture, among others, the items that are ordered by customers. Explain what the following code is and explain how it works by writing comments against each line of the code: 

#Answer 17:
SET SERVEROUTPUT ON

statusCode_int order.statusCode%TYPE;
customerNo_in order.customerNo%TYPE;
Total_Order DECIMAL(6,2);

BEGIN

  	SELECT SUM (price*amount) INTO Total_ORDER
	FROM item
	WHERE EXISTS (select ‘x’ FROM Order
	WHERE order.orderNo = item.orderNo 	
             AND customerNo = &customerNo_in 
	 AND statusCode = &statusCode_in;

IF Total_Order > 500
DBMS_OUTPUT.PUTLINE(‘High Value Customer: ’);
DBMS_OUTPUT.PUTLINE(CustomerNo_in);

END;

Explanation : 
Step 1 : First line : Turns on serveroutput then 
Define variable StatusCode_int  datatype same as Order.statusCode, 
Define variable customerNo_in datatype same as Order.customerNo_in
Define new variable Total_Order datatype as DECIMAL(6,2)

Step 2: 
Begin the query : Calculating Total Order from table item by summing up the product of price and amount and store it in variable Total_Order. 

Condition of query : EXISTS condition is true if subquery return some data from table Order if all three conditions inside sub query get true like orderNo of item and order, given customer and statusCode_in returns some data.

Step 3: 
Checking the output of above query whether Total_Order is greater than 500.If greater than 500 then Display output as High Value Customer  else CustomerNo_in and END the query.

####----------------------------------------------------
Consider the relational model for Bearcat Incorporated. 
EMPLOYEE (Emp_fname, Emp_minit, Emp_lname, Emp_nametag, Emp_emp_e#a, Emp_emp_e#n, Emp_address, Emp_salary, Emp_pl_name, Emp_gender, Emp_datehired, Emp_e#a, Emp_e#n) 
PLANT (Pl_p#, Pl_budget, Pl_name, Pl_emp_e#a, Pl_emp_e#n, Pl_mgrstdte) 
BUILDING (Bld_building, Bld_pl_p#) 
PROJECT (Prj_name, Prj_location, Prj_p#, Prj_pl_p#) 
ASSIGNMENT (Asg_prj_p#, Asg_emp_e#a, Asg_emp_e#n, Asg_hrs) 
DEPENDENT (Dep_sex, Dep_brthdte, Dep_name, Dep_relhow, Dep_emp_e#a, Dep_emp_e#n) 
BCU_ACCOUNT (Bcu_dep_name, Bcu_dep_relhow, Bcu_dep_emp_e#a, Bcu_dep_emp_e#n, Bcu_acct_type, Bcu_acct#, Bcu-balance, Bk_emp_e#a, Bcu_emp_e#n) 
PARTICIPATION (Par_dep_name, Par_dep_relhow, Par_dep_emp_e#a, Par_dep_emp_e#n, Par_hob_name, Par_anncost, Par_hrsweek) 
HOBBY (Hob_name, Hob_Ioact, Hob_giact) 
In addition to the primary key constraints shown in the figure, these tables contain the following constraints (i.e., business rules).
PLANT Table
• No two plants can have the same name.
• Plant numbers are allowed to range between 10 and 20 inclusive.
EMPLOYEE Table
• Each employee must have a first name and a last name.
• Employee salaries can range between $35,000 and $90,000 inclusive.
• Valid genders are ‘M’ and ‘F’.
• Each employee must work in an existing plant.
• The supervisor of an employee must be an existing employee.
• No two employees can have the same first name, middle initial, last name, and nametag combination.
BUILDING Table
• Each building must be part of an existing plant.
PROJECT Table
• Projects are located in the following cities (Bellaire, Blue Ash, Mason, Stafford, and Sugarland).
• Each project must be associated with an existing plant.
• Project numbers range from 1 to 40 inclusive.
ASSIGNMENT Table
• Each assignment must be associated with an existing employee and an existing project.
DEPENDENT Table
•	The sex of a dependent can be (‘M’, ‘F’, ‘m’, or ‘f’).
•	A dependent must be a dependent of an existing employee.
•	A dependent can be related to an employee in the following ways:
o	A dependent can be the employee’s spouse.
o	A dependent who is a mother or daughter must be a female.
o	A dependent who is a father or son must be a male.
BCU_ACCOUNT Table
• A bcu_account can belong to either an employee, a dependent, or (an employee and a dependent).
• Valid account types are ‘C’, ‘S’, or ‘I’.
HOBBY Table
• Valid values for the indoor/outdoor attribute are ‘I’ or ‘O’.
• Valid values for the group/individual attribute are ‘G’ or ‘I’.
PARTICIPATION Table
• A participation must involve an existing hobby and an existing dependent. 

18, 19, 20. Write SQL code to create Employee, Dependent, and Hobby tables.


#Answer 18 :
Create table EMPLOYEE  (
Emp_fname  CHAR(25)    NOT NULL, 
Emp_minit   CHAR(5), 
Emp_lname  CHAR(25)    NOT NULL, 
Emp_nametag CHAR(25), 
Emp_emp_e#a VARCHAR(10)  NOT NULL, 
Emp_emp_e#n VARCHAR(10)  NOT NULL, 
Emp_address  VARCHAR(100), 
Emp_salary INT, 
Emp_pl_name CHAR(25), 
Emp_gender CHAR(10), 
Emp_datehired  DATE, 
Emp_e#a VARCHAR(10), 
Emp_e#n VARCHAR(10),
Emp_super_e#a  VARCHAR(10),
Emp_super_e#n  VARCHAR(10),
Emp_Pl_p# VARCHAR(10),
CONSTRAINT 	Emp_salaryRange   CHECK (( Emp_salary >=35000) AND (Emp_salary <=90000)),
CONSTRAINT 	Emp_genderCheck  CHECK (Emp_gender IN (‘M’,’F’)),
CONSTRAINT 	Emp_emp_e#aPK	  PRIMARY KEY(Emp_emp_e#a),
CONSTRAINT 	Emp_emp_e#nPK	  PRIMARY KEY(Emp_emp_e#n), 
CONSTRAINT 	EMPNAMEAK     UNIQUE(Emp_fname , Emp_minit, Emp_lname, Emp_nametag),
CONSTRAINT 	Emp_super_e#aFK	  FOREIGN KEY(Emp_super_e#a) REFERENCES Employee(Emp_emp_e#a),
CONSTRAINT 	Emp_super_e#nFK	  FOREIGN KEY(Emp_super_e#n) REFERENCES Employee(Emp_emp_e#n) , 
CONSTRAINT Emp_Pl_p#FK	  FOREIGN KEY(Emp_Pl_p#) REFERENCES PLANT (Pl_p#)
 );

#Answer 19:

Create table DEPENDENT (
Dep_sex CHAR(10)    , 
Dep_brthdte DATE, 
Dep_name CHAR(25) ,    
Dep_relhow CHAR(15),
Dep_emp_e#a VARCHAR(10), 
Dep_emp_e#n VARCHAR(10),
CONSTRAINT 	Dep_sexCheck  CHECK (Dep_sex IN (‘M’,’F’,’m’,’f’)),
CONSTRAINT 	Dep_emp_e#aFK	  FOREIGN KEY(Dep_emp_e#a) REFERENCES Employee(Emp_emp_e#a),
CONSTRAINT 	Dep_emp_e#nFK	  FOREIGN KEY(Dep_emp_e#n) REFERENCES Employee(Emp_emp_e#n) , 
CONSTRAINT 	DEPENDENTPK	  PRIMARY KEY(Dep_name, Dep_relhow, Dep_emp_e#a, Dep_emp_e#n),
CONSTRAINT Dep_relhowCheck
CHECK ((Dep_sex = 'F' AND Dep_relhow IN ('Daughter', 'Spouse',’Mother’)) OR (Dep_sex = 'M' AND Dep_relhow IN ('Son', 'Spouse',’Father’)));
);

#Answer 20:

Create table HOBBY (
Hob_name VARCHAR(50)    , 
Hob_Ioact CHAR(1), 
Hob_giact CHAR(1),
CONSTRAINT 	Hob_namePK       PRIMARY KEY(Hob_name),
CONSTRAINT 	Hob_IoactCheck  CHECK (Hob_Ioact IN (‘I’,’O’)),
CONSTRAINT 	Hob_giactCheck   CHECK (Hob_giact IN (‘G’,’I’))
) ;

