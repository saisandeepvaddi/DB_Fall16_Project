DROP PROCEDURE Customers_Mem_Curr_Status;
CREATE or replace PROCEDURE  Customers_Mem_Curr_Status As
this_c_Id CUSTOMER.CUSTOMER_ID%TYPE;
this_c_FName CUSTOMER.FNAME%TYPE;
this_c_LName CUSTOMER.LNAME%TYPE;
CURSOR RES_SET IS
SELECT C.Customer_Id,C.Fname,C.Lname FROM CUSTOMER C WHERE C.MEMBERSHIP_END_DT <= trunc(SYSDATE) and C.MEMBERSHIP_ID IS NOT NULL
FOR UPDATE;
BEGIN
OPEN RES_SET;
LOOP
FETCH RES_SET INTO this_c_Id, this_c_FName ,this_c_LName;
EXIT WHEN(RES_SET%NOTFOUND);
dbms_output.put_line('Customer_ID = ' || this_c_Id ||
                               ', Customer_Name = ' || this_c_FName || ', First_Name = ' || this_c_LName );

 END LOOP;
 CLOSE RES_SET;
END;
.
RUN;

BEGIN
  Customers_Mem_Curr_Status();
END;
.
RUN;
