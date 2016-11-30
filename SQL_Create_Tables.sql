-- Creation of Tables

-- 1.
CREATE TABLE GAME (
  Game_Id INT NOT NULL,
  Game_Name VARCHAR(20) NOT NULL,
  Type VARCHAR(20),
  Age_Limit INT,
  Price_Hr DECIMAL(5,2),
  PRIMARY KEY (Game_Id)
);

-- 2.
CREATE TABLE MEMBERSHIP_DETAILS(
  Membership_Id INT NOT NULL,
  Membership_Type VARCHAR(20) NOT NULL,
  Validity INT,
  Price DECIMAL(5,2),
  Discount INT,
  PRIMARY KEY (Membership_Id)
);

-- 3.
CREATE TABLE CITY_STATE (
  City VARCHAR (20),
  State VARCHAR (20),
  PRIMARY KEY (City)
);

-- 4.
CREATE TABLE MGR_BRANCH(
  Mgr_Ssn VARCHAR(9) NOT NULL,
  Branch_Name VARCHAR(20) NOT NULL,
  PRIMARY KEY (Mgr_Ssn)
);

-- 5.
CREATE TABLE PLAYGROUND_BRANCH
(
  Branch_Id INT NOT NULL,
  Mgr_Ssn VARCHAR(9) NOT NULL,
  Opening_Time TIMESTAMP,
  Closing_Time TIMESTAMP,
  Size_Sq_Ft VARCHAR(20),
  Ground_Type VARCHAR(20),
  Bldg_No VARCHAR(20),
  Street VARCHAR(20),
  City VARCHAR(20),
  Pincode INT,
  PRIMARY KEY (Branch_Id),
  FOREIGN KEY (City) REFERENCES CITY_STATE (City) ON DELETE SET NULL,
  FOREIGN KEY (Mgr_Ssn) REFERENCES MGR_BRANCH (Mgr_Ssn) ON DELETE SET NULL
);


-- 6.
CREATE TABLE HOSTS(
  Branch_Id INT NOT NULL,
  Game_Id INT NOT NULL,
  PRIMARY KEY (Branch_Id, Game_Id),
  FOREIGN KEY (Branch_Id) REFERENCES PLAYGROUND_BRANCH (Branch_Id) ON DELETE CASCADE,
  FOREIGN KEY (Game_Id) REFERENCES GAME (Game_Id) ON DELETE CASCADE
);


-- 7.
CREATE TABLE CUSTOMER
(
  Customer_Id INT NOT NULL,
  Lname VARCHAR(20) NOT NULL,
  Fname VARCHAR(20) NOT NULL,
  Age INT,
  Phone VARCHAR(15),
  Membership_Id INT,
  Membership_Begin_Dt DATE,
  -- Membership_Status VARCHAR(20),
  -- Membership_End_Dt Date,
  Card_No VARCHAR(20),
  Apt_No VARCHAR(20),
  Street VARCHAR(20),
  City VARCHAR(20),
  Pincode INT,
  PRIMARY KEY (Customer_Id),
  FOREIGN KEY (Membership_Id) REFERENCES MEMBERSHIP_DETAILS(Membership_Id) ON DELETE SET NULL,
  FOREIGN KEY (City) REFERENCES CITY_STATE (City) ON DELETE SET NULL
);

-- 8.
CREATE TABLE TOY(
  Toy_Id INT NOT NULL,
  Toy_Name VARCHAR(20),
  Customer_Id INT,
  PRIMARY KEY (Toy_Id),
  FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER(Customer_Id) ON DELETE SET NULL
);

-- 9.
CREATE TABLE EQUIP_GAME (
  Equipment_Name VARCHAR(20) NOT NULL,
  Game_Id INT NOT NULL,
  PRIMARY KEY (Equipment_Name),
  FOREIGN KEY (Game_Id) REFERENCES GAME (Game_Id) ON DELETE CASCADE
);


-- 10.
CREATE TABLE GAME_EQUIPMENT (
  Equipment_Id INT NOT NULL,
  Equipment_Name VARCHAR(20),
  Branch_Id INT,
  Available_Units INT,
  PRIMARY KEY (Equipment_Id),
  FOREIGN KEY (Equipment_Name) REFERENCES EQUIP_GAME (Equipment_Name) ON DELETE CASCADE,
  FOREIGN KEY (Branch_Id) REFERENCES PLAYGROUND_BRANCH (Branch_Id) ON DELETE SET NULL
);

-- 11.
CREATE TABLE REGISTERS(
  Customer_Id INT,
  Game_Id INT,
  Bill_Id INT,
  Bill_Date DATE,
  Payment_Type VARCHAR(20),
  Total_Amount DECIMAL(10,2),
  PRIMARY KEY (Customer_Id, Game_Id),
  FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER (Customer_Id) ON DELETE SET NULL,
  FOREIGN KEY (Game_Id) REFERENCES GAME (Game_Id) ON DELETE SET NULL
);

-- 12.
CREATE TABLE EMPLOYEE (
  SSN VARCHAR(9) NOT NULL,
  Lname VARCHAR(20) NOT NULL,
  Mname VARCHAR(20) NOT NULL,
  FName VARCHAR(20) NOT NULL,
  Mgr_Ssn VARCHAR(9),
  Salary DECIMAL(10,2),
  Sex VARCHAR(20),
  Apt_No VARCHAR(20),
  Street VARCHAR(20),
  City VARCHAR(20),
  Pincode VARCHAR(5),
  PRIMARY KEY (SSN),
  FOREIGN KEY (City) REFERENCES CITY_STATE (City) ON DELETE SET NULL,
  FOREIGN KEY (Mgr_Ssn) REFERENCES MGR_BRANCH (Mgr_Ssn) ON DELETE SET NULL
);

-- 13
CREATE TABLE CUSTOMER_MEMBERSHIP (
  Customer_Id INT NOT NULL,
  Membership_End_Dt DATE,
  PRIMARY KEY (Customer_Id),
  FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER (Customer_Id)
);