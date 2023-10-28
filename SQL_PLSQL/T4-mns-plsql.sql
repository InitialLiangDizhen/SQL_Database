    --*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-mns-plsql.sql

--Student ID: 31240291
--Student Name: DizhenLiang
--Unit Code: FIT3171
--Applied Class No:

/* Comments for your marker:
Question 4(a) insufficient previlige to insert into appt_serv
change appt_serv into appt_serv to see the correct output
--change appt_serv to appt_serv to see the correct output for the last harresment
--due to insufficient previlige
*/

SET SERVEROUTPUT ON

--4(a) 
-- Complete the procedure below
CREATE OR REPLACE PROCEDURE prc_insert_appt_serv (
    p_appt_no      IN NUMBER,
    p_service_code IN CHAR,
    p_output       OUT VARCHAR2
) AS
    var_appt_found NUMBER;
    var_serv_found NUMBER;
    var_as_found NUMBER;
BEGIN
    SELECT count(*)
    INTO var_appt_found
    FROM appointment
    WHERE appt_no = p_appt_no;
    
    IF var_appt_found = 0 THEN
        p_output := 'Invalid appointment number';
        RETURN;
    END IF;
    
    SELECT count(*)
    INTO var_serv_found
    FROM service
    WHERE service_code = p_service_code;
    
    IF var_serv_found = 0 THEN
        p_output:= 'Invalid service code';
        RETURN;
    END IF;


--Check if the provider assigned to the appointment table can provide the service
--by checking if it is in the inner joined table between appointment and provider_service
    SELECT count(*)
    INTO var_as_found
    FROM 
        appointment a
        JOIN provider_service ps on a.provider_code = ps.provider_code
    WHERE
        a.appt_no = p_appt_no
        AND ps.service_code = p_service_code;
    
    --the provider is providing a service for an appointment already
    IF var_as_found <> 0 THEN
        p_output:= 'The provider assigned to the appointment is not able to provide the service.';
        RETURN;
    END IF;
    
    -- Insert a new appointment service
    -- if all conditions are valid
    -- insert into appt_serc=v not appt_serv
    INSERT INTO appt_serv (appt_no, service_code)
    VALUES (p_appt_no, p_service_code);
    
    p_output := 'Inserted a new appointment service successfully';
END;
/
        
    
-- Write Test Harness for 4(a)
--change appt_serv to appt_serv to see the correct output for the last harresment
--due to insufficient previlige
-- Initial Data
SELECT *
FROM appointment;

SELECT *
FROM appt_serv;

--Invalid appointment number
DECLARE 
    output VARCHAR2(100);
BEGIN 
  prc_insert_appt_serv(100,'D001', output); 
  dbms_output.put_line(output);
END;
/

--Invalid service code
select *
from service;

DECLARE 
    output VARCHAR2(100);
BEGIN 
  prc_insert_appt_serv(1,'DD01', output); 
  dbms_output.put_line(output);
END;
/

-- The provider assigned to the appointment is not able to provide the service.
--SELECT *
--FROM provider_service;

DECLARE 
    output VARCHAR2(100);
BEGIN 
  prc_insert_appt_serv(5,'P001', output); 
  dbms_output.put_line(output);
END;
/

-- Inserted a new appointment service successfully
--Prior state
--Inserted a new appointment service successfully
--by inserting the service code from the provider_service table
--that exist has the provider in the appointment table

SELECT *
FROM  appointment a
JOIN appt_serv asv on a.appt_no = asv.appt_no
WHERE a.appt_no = 1 AND asv.service_code = 'X001';

--SELECT *
--FROM service;
--
--SELECT *
--FROM appointment;


DECLARE 
    output VARCHAR2(100);
BEGIN 
  prc_insert_appt_serv(2,'EX02', output); 
  dbms_output.put_line(output);
END;
/

--Post State
SELECT *
FROM  appointment a
JOIN appt_serv asv on a.appt_no = asv.appt_no
WHERE a.appt_no = 2 AND asv.service_code = 'EX02';
--WHERE a.appt_no = 2 AND asv.service_code = 'X001';
ROLLBACK;




--4(b) -----------------------------------------
--Write your trigger statement, 
--finish it with a slash(/) followed by a blank line
-- Create a trigger called trg_update_itemcost

CREATE OR REPLACE TRIGGER update_item_and_apptserv
AFTER INSERT OR UPDATE OR DELETE ON apptservice_item
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE item
    SET item_stock = item_stock - :NEW.as_item_quantity
    WHERE item_id = :NEW.item_id;

    UPDATE appt_serv
    SET apptserv_itemcost = apptserv_itemcost + :NEW.as_item_quantity * (SELECT item_stdcost FROM item WHERE item_id = :NEW.item_id)
    WHERE appt_no = :NEW.appt_no AND service_code = :NEW.service_code;
  END IF;
  
  IF UPDATING THEN
    UPDATE item
    SET item_stock = item_stock - :NEW.as_item_quantity + :OLD.as_item_quantity
    WHERE item_id = :NEW.item_id;

    UPDATE appt_serv
    SET apptserv_itemcost = apptserv_itemcost + (:NEW.as_item_quantity - :OLD.as_item_quantity) 
    * (SELECT item_stdcost FROM item WHERE item_id = :NEW.item_id)
    WHERE appt_no = :NEW.appt_no AND service_code = :NEW.service_code;
  END IF;

  IF DELETING THEN
    UPDATE item
    SET item_stock = item_stock + :OLD.as_item_quantity 
    WHERE item_id = :OLD.item_id;

    UPDATE appt_serv
    SET apptserv_itemcost = apptserv_itemcost - :OLD.as_item_quantity * (SELECT item_stdcost FROM item WHERE item_id = :OLD.item_id)
    WHERE appt_no = :OLD.appt_no AND service_code = :OLD.service_code;
  END IF;
END;
/



-- Write Test Harness for 4(b)

-- Harness for Inserting
-- Prior state
SELECT * FROM item WHERE item_id = 1;
SELECT * FROM appt_serv WHERE appt_no = 1 AND service_code = 'P001';
SELECT * FROM apptservice_item WHERE appt_no = 1 AND service_code = 'P001';
--Need to insert a row into the appt_serv as there is no row in the table
--otherwise add row into apptservice_item would cause parent key error
--as it need to match with 
INSERT INTO appt_serv (appt_no, service_code, apptserv_itemcost)
VALUES (1, 'P001', 0);

INSERT INTO apptservice_item (as_id, appt_no, service_code, item_id, as_item_quantity) 
VALUES (1, 1, 'P001', 1, 10);

--Post state
SELECT * FROM item WHERE item_id = 1;
SELECT * FROM appt_serv WHERE appt_no = 1 AND service_code = 'P001';
SELECT * FROM apptservice_item WHERE appt_no = 1 AND service_code = 'P001';

-- Harness for updating
-- Prior state
SELECT * FROM item WHERE item_id = 1;
SELECT * FROM appt_serv WHERE appt_no = 1 AND service_code = 'P001';
SELECT * FROM apptservice_item WHERE appt_no = 1 AND service_code = 'P001';

UPDATE apptservice_item SET as_item_quantity = 20 WHERE as_id = 1;

--Post state
SELECT * FROM item WHERE item_id = 1;
SELECT * FROM appt_serv WHERE appt_no = 1 AND service_code = 'P001';
SELECT * FROM apptservice_item WHERE appt_no = 1 AND service_code = 'P001';

-- Delete a row from apptservice_item
DELETE FROM apptservice_item WHERE as_id = 1;

-- Check values again
SELECT * FROM item WHERE item_id = 1;
SELECT * FROM appt_serv WHERE appt_no = 1 AND service_code = 'P001';
SELECT * FROM apptservice_item WHERE appt_no = 1 AND service_code = 'P001';
ROLLBACK;
