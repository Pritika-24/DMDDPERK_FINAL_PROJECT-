-----TRIGGER 1------------------------------------------------------

CREATE OR REPLACE TRIGGER Br_brokerfee_print
BEFORE UPDATE OF b_BROKERFEE
ON BROKERS
FOR EACH ROW
DECLARE BROKERFEE_DIFF number:= 0;
BEGIN
BROKERFEE_DIFF := :NEW.b_BROKERFEE - :OLD.b_BROKERFEE;
DBMS_OUTPUT.PUT_LINE ('The old Broker fee was: '||:OLD.b_BROKERFEE);
DBMS_OUTPUT.PUT_LINE ('The old Broker fee was: '||:NEW.b_BROKERFEE);
DBMS_OUTPUT.PUT_LINE ('The difference in Broker fee IS: '||BROKERFEE_DIFF);
END;

-------TRIGGER 2 ------------------------------------------------------------

CREATE OR REPLACE TRIGGER Af_a_rent
BEFORE UPDATE OF a_rent
ON APARTMENT_FEATURES
FOR EACH ROW
DECLARE RENT_DIFF number:= 0;
BEGIN
RENT_DIFF := :NEW.a_rent - :OLD.a_rent;
DBMS_OUTPUT.PUT_LINE ('The old Rent was: '||:OLD.a_rent);
DBMS_OUTPUT.PUT_LINE ('The old Rent fee was: '||:NEW.a_rent);
DBMS_OUTPUT.PUT_LINE ('The difference in Rent IS: '||RENT_DIFF);
END;
