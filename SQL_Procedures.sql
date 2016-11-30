-- 1)  Procedure to generate bill to each customer for the day
DROP PROCEDURE GENERATE_BILL; COMMIT;
CREATE OR REPLACE PROCEDURE GENERATE_BILL (Customer_Id IN CUSTOMER.Customer_Id%TYPE)
IS
Gid GAME.Game_Id%TYPE;
Customer_Lname CUSTOMER.LNAME%TYPE;
Customer_Fname CUSTOMER.FNAME%TYPE;
Game_Bill NUMBER(10,2);
Bill NUMBER(10,2);
Price_per_hr GAME.Price_Hr%TYPE;
Membership MEMBERSHIP_DETAILS.MEMBERSHIP_TYPE%TYPE;
Discount_Amt MEMBERSHIP_DETAILS.DISCOUNT%TYPE;
GameName GAME.Game_Name%TYPE;
CURSOR REGISTER_DETAILS IS
	SELECT R.game_id, R.total_amount FROM REGISTERS R WHERE R.CUSTOMER_ID = Customer_Id AND R.BILL_DATE = trunc(SYSDATE);
BEGIN
	DBMS_OUTPUT.PUT_LINE('Bill');
	DBMS_OUTPUT.PUT_LINE('==========================');
	Bill := 0;
	SELECT LNAME, FNAME into Customer_Lname, Customer_Fname FROM CUSTOMER C WHERE C.Customer_Id = Customer_Id;
	SELECT DISCOUNT, MEMBERSHIP_TYPE INTO Discount_Amt, Membership FROM MEMBERSHIP_DETAILS WHERE MEMBERSHIP_ID = (SELECT MEMBERSHIP_ID FROM CUSTOMER C WHERE C.CUSTOMER_ID = Customer_Id); 
	DBMS_OUTPUT.PUT_LINE('Customer Name: '||Customer_Lname||', '||Customer_Fname);
	DBMS_OUTPUT.PUT_LINE('Game_Id'||chr(9)||'Game_Name'||chr(9)||'Hrs_Played'||chr(9)||'Bill_by_Game');
	DBMS_OUTPUT.PUT_LINE('=================================================================');
	OPEN REGISTER_DETAILS;
	LOOP
		FETCH REGISTER_DETAILS INTO Gid, Game_Bill;
		EXIT WHEN REGISTER_DETAILS%NOTFOUND;
		SELECT G.Game_Name, G.Price_Hr into GameName, Price_per_hr FROM GAME G WHERE G.Game_Id = Gid;
		DBMS_OUTPUT.PUT_LINE(Gid||chr(9)||GameName||chr(9)||(Game_Bill/Price_per_Hr)||chr(9)||Game_Bill);
		-- DBMS_OUTPUT.PUT_LINE(Game_Id||' '||Game_Bill);
		Bill := Bill + Game_Bill;
	END LOOP;
	CLOSE REGISTER_DETAILS;
	DBMS_OUTPUT.PUT_LINE('=================================================================');
	DBMS_OUTPUT.PUT_LINE('Total Amount: '||'$'||Bill);
	DBMS_OUTPUT.PUT_LINE('Membership: '||Membership);
	Bill := Bill - (Bill * (Discount_Amt/100));
	DBMS_OUTPUT.PUT_LINE('Discount %: '||Discount_Amt);
	DBMS_OUTPUT.PUT_LINE('Final Bill: '||'$'||Bill);
	
END GENERATE_BILL;
/
-- CALL GENERATE_BILL(1);