CREATE OR REPLACE PROCEDURE GENERATE_BILL (Customer_Id IN CUSTOMER.Customer_Id%TYPE)
IS
Game_Id GAME.Game_Id%TYPE;
Customer_Lname CUSTOMER.LNAME%TYPE;
Customer_Fname CUSTOMER.FNAME%TYPE;
Game_Bill NUMBER(10,2);
Bill NUMBER(10,2);
Price_per_hr GAME.Price_Hr%TYPE;
Membership MEMBERSHIP_DETAILS.MEMBERSHIP_TYPE%TYPE;
Discount_Amt MEMBERSHIP_DETAILS.DISCOUNT%TYPE;
Game_Name GAME.Game_Name%TYPE;
CURSOR REGISTER_DETAILS IS
	SELECT R.game_id, R.total_amount FROM REGISTERS R WHERE R.CUSTOMER_ID = Customer_Id AND R.BILL_DATE = trunc(SYSDATE);
BEGIN
	SELECT LNAME, FNAME into Customer_Lname, Customer_Fname FROM CUSTOMER C WHERE C.Customer_Id = Customer_Id;
	SELECT DISCOUNT, MEMBERSHIP_TYPE INTO Discount_Amt, Membership FROM MEMBERSHIP_DETAILS WHERE MEMBERSHIP_ID = (SELECT MEMBERSHIP_ID FROM CUSTOMER C WHERE C.CUSTOMER_ID = Customer_Id); 
	DBMS_OUTPUT.PUT_LINE('Customer Name: '||Customer_Lname||', '||Customer_Fname);
	DBMS_OUTPUT.PUT_LINE('Game Id'||' '||'Game Name'||' '||'Hrs Played'||' '||'Bill by Game');
	OPEN REGISTER_DETAILS;
	LOOP
		FETCH REGISTER_DETAILS INTO Game_Id, Game_Bill;
		EXIT WHEN REGISTER_DETAILS%NOTFOUND;
		SELECT G.Game_Name, G.Price_Hr into Game_Name, Price_per_hr FROM GAME G WHERE G.Game_Id = Game_Id;
		DBMS_OUTPUT.PUT_LINE(Game_Id||' '||Game_Name||' '||(Game_Bill/Price_per_Hr)||' '||Game_Bill);
		Bill := Bill + Game_Bill;
	END LOOP;
	CLOSE REGISTER_DETAILS;
	DBMS_OUTPUT.PUT_LINE('Total Amount: '||Bill);
	DBMS_OUTPUT.PUT_LINE('Membership: '||Membership);
	Bill := Bill - (Bill * (Discount_Amt/100));
	DBMS_OUTPUT.PUT_LINE('Discount %'||Discount_Amt);
	DBMS_OUTPUT.PUT_LINE('Final Bill'||Bill);
	Bill := 0;		
END GENERATE_BILL;
/