--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-mns-alter.sql

--Student ID:
--Student Name:
--Unit Code:
--Applied Class No:

/* Comments for your marker:




*/

--4(a)
ALTER TABLE patient ADD patient_total_appt NUMBER(6,0);
COMMENT ON COLUMN patient.patient_total_appt 
    IS 'total number of appointment for each patient';
COMMIT;  

UPDATE patient
--initialise new columne with current total appointments for each person 
SET --count (*) to count all the rows regard
    patient_total_appt = 
    (
    SELECT  COUNT(*) --count all the rows even there is null
    FROM appointment
    WHERE appointment.patient_no = patient.patient_no
    );
--Show table structure
DESC patient
SELECT * FROM patient;
COMMIT;  


--4(b)


--need to drop the table to switch from one-to-many relationship
-- to many-to-many relationship by including junction table
-- otherwise uniqueness or the foreign constraint
ALTER TABLE patient 
    DROP CONSTRAINT emergencycontact_patient;
COMMIT;  
--apply cascade constrain during deleting the table
DROP TABLE patient_emer_cont CASCADE CONSTRAINTS PURGE;
--Need to create a junction table to refer to the emengercy_contact 
-- and patient table by having two foreign key columns
CREATE TABLE patient_emer_cont(
    patient_no  NUMBER(8) NOT NULL,
    ec_id       NUMBER(8) NOT NULL
    --PRIMARY KEY(patient_no, ec_id),
    --FOREIGN KEY(patient_no) REFERENCES patient (patient_no);
    --FOREIGN KEY(ec_id) REFERENCES emergency_contact (ec_id);
    );
   
ALTER TABLE patient_emer_cont
    ADD CONSTRAINT patient_patient_emer_cont FOREIGN KEY (patient_no)
    REFERENCES patient (patient_no);
 
ALTER TABLE patient_emer_cont
    ADD CONSTRAINT emergencycontact_patient_emer_cont FOREIGN KEY (ec_id)
    REFERENCES emergency_contact (ec_id);
COMMIT;    
--Populate junction table with exisiting emergency_contact rows
--insert mutiple rows from corresponding column to the into the foreign key columns
--the same patient_no can exist in multiple rows in patient_emer_cont table
--with different emergency_contact id
INSERT INTO patient_emer_cont --(patient_no, ec_id)
SELECT patient_no, ec_id 
FROM patient;

DESC patient_emer_cont;
SELECT * FROM patient_emer_cont;


--4(c)
DROP TABLE training CASCADE CONSTRAINTS PURGE;
CREATE TABLE training (
    trainee_no NUMBER(8) NOT NULL,
    trainee_fname VARCHAR2(30),
    trainee_lname VARCHAR2(30),
    trainer_no NUMBER(8) NOT NULL,
    trainer_fname VARCHAR2(30),
    trainer_lname VARCHAR2(30),
    train_start_date DATE,
    train_end_date DATE,
    train_desc VARCHAR2(200)
);
COMMIT;  
--Populate the training table
INSERT INTO training VALUES (
    1,
    'Seth',
    'Raws',
     2,
    'Spencer',
    'Cazaly',
    to_date('04-Sep-2023 16:00:00', 'DD-Mon-YYYY HH24:MI:SS'),
    to_date('04-Sep-2023 22:00:00', 'DD-Mon-YYYY HH24:MI:SS'),
    'first training'
);
COMMIT;  
INSERT INTO training VALUES (
    1,
    'Seth',
    'Raws',
     3,
    'Anna',
    'Treloar',
    to_date('05-Sep-2023 16:00:00', 'DD-Mon-YYYY HH24:MI:SS'),
    to_date('05-Sep-2023 22:00:00', 'DD-Mon-YYYY HH24:MI:SS'),
    'second training'
);
COMMIT;  
INSERT INTO training VALUES (
    3,
    'Anna',
    'Treloar',
     2,
    'Spencer',
    'Cazaly',
    to_date('06-Sep-2023 16:00:00', 'DD-Mon-YYYY HH24:MI:SS'),
    to_date('06-Sep-2023 22:00:00', 'DD-Mon-YYYY HH24:MI:SS'),
    'thrid training'
);
COMMIT;                                                     --temporarily
DESC training;                                         --change the name of column that show in query
SELECT * FROM training;                                  --just an alias valid for current query
SELECT to_char(train_start_date, 'DD-Mon-YYYY HH24:MI:SS') AS train_start_date 
FROM training;
SELECT TO_CHAR(train_end_date, 'DD-Mon-YYYY HH24:MI:SS') AS train_end_date 
FROM training;
COMMIT;  