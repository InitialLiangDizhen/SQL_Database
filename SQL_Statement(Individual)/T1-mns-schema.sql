--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-mns-schema.sql

--Student ID: 31240291
--Student Name: LIANG DIZHEN
--Unit Code: FIT3171
--Applied Class No: 

/* Comments for your marker:




*/

-- Task 1 Add Create table statements for the white TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- TABLE: APPOINTMENT
CREATE TABLE appointment (
    --need to tab the attribute type to align 
  appt_no           NUMBER(8) NOT NULL,
  appt_datetime     DATE,
  appt_roomno       NUMBER(8),
  appt_length       CHAR(1),
  patient_no        NUMBER(8),
  provider_code     CHAR(6) NOT NULL,
  nurse_no          NUMBER(3) NOT NULL,
  appt_prior_apptno NUMBER(8)
);

COMMENT ON COLUMN appointment.appt_no IS
    'Appointment number (identifier)';

COMMENT ON COLUMN appointment.appt_datetime IS
    'Date and time of the appointment';
    
COMMENT ON COLUMN appointment.appt_roomno IS
    'Room in which appointment is scheduled to take place';
    
COMMENT ON COLUMN appointment.appt_length IS
    'Length of appointment - Short, Standard or Long (S, T or L)';
    
COMMENT ON COLUMN appointment.patient_no IS
    'Patient who books the appointment';
    
COMMENT ON COLUMN appointment.provider_code IS 
    'Provider who is assigned to the appointment';
    
COMMENT ON COLUMN appointment.nurse_no IS 
    'Nurse who is assigned to the appointment';
    
COMMENT ON COLUMN appointment.appt_prior_apptno IS
    'Prior appointment number which leads to this 
    appointment (this is required to be unique)';


ALTER TABLE appointment ADD CONSTRAINT appintment_pk PRIMARY KEY (appt_no);

ALTER TABLE appointment
    ADD CONSTRAINT ck_apptlength CHECK (appt_length IN ('S', 'T', 'L'));

ALTER TABLE appointment 
    ADD CONSTRAINT appointment_nk UNIQUE(appt_prior_apptno);


-- TABLE: EMERGENCY_CONTACT
CREATE TABLE emergency_contact(
    --May AUTO_INCREMENT after NOT NULL
    ec_id       NUMBER(8) NOT NULL,
    ec_fname    VARCHAR2(50) NOT NULL,
    ec_lname    VARCHAR2(50) NOT NULL,
    ec_phone    VARCHAR(20) NOT NULL
    );
    
COMMENT ON COLUMN emergency_contact.ec_id IS
    'Emergency contact identifier';
COMMENT ON COLUMN emergency_contact.ec_fname IS
    'Emergency contact first name';
COMMENT ON COLUMN emergency_contact.ec_id IS
    'Emergency contact last name';
COMMENT ON COLUMN emergency_contact.ec_id IS
    'Emergency contact phone number';

ALTER TABLE emergency_contact 
    ADD CONSTRAINT emergency_contact_pk PRIMARY KEY (ec_id);


-- TABLE: PATIENT
CREATE TABLE patient(
    patient_no              NUMBER(8) NOT NULL,
    patient_fname           VARCHAR(50) NOT NULL,
    patient_lname           VARCHAR(50) NOT NULL,
    patient_street          VARCHAR(50),
    patient_city            VARCHAR(50),
    patient_state           VARCHAR(3),
    patient_postcode        CHAR(6),
    patient_dob             DATE NOT NULL,
    patient_contactmobile   VARCHAR(20) NOT NULL,
    patent_contactemail     VARCHAR(100),
    ec_id                   NUMBER(8) 
    );   

COMMENT ON COLUMN patient.patient_no IS
    'Patient number (unique for each patient)';
    
COMMENT ON COLUMN patient.patient_fname IS 
    'Patient first name';
--    
COMMENT ON COLUMN patient.patient_lname IS 
    'Patient last name';
COMMENT ON COLUMN patient.patient_street IS 
    'Patient residential street address';
COMMENT ON COLUMN patient.patient_city IS 
    'Patient residential city';
COMMENT ON COLUMN patient.patient_state IS 
    'Patient residential state - NT, QLD, NSW, ACT, VIC, TAS, SA, or WA';
COMMENT ON COLUMN patient.patient_postcode 
    IS 'Patient residential postcode';
COMMENT ON COLUMN patient.patient_dob IS 
    'Patient date of birth';
COMMENT ON COLUMN patient.patient_contactmobile  IS 
    'Patient contact mobile number';
COMMENT ON COLUMN patient.patent_contactemail  IS 
    'Patient contact email address';
COMMENT ON COLUMN patient.ec_id  IS 
    'Patient emergency contact identifier';

--ck name conversion in front
ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY (patient_no);

ALTER TABLE patient 
    ADD CONSTRAINT ck_patientstate CHECK (patient_state IN (
    'NT', 'QLD', 'NSW', 'ACT', 'VIC', 'TAS', 'SA', 'WA'));    

-- Add all missing FK Constraints below here
--by default no action
ALTER TABLE appointment 
    ADD CONSTRAINT nurse_appointment FOREIGN KEY (nurse_no)
    REFERENCES nurse (nurse_no);


ALTER TABLE appointment 
    ADD CONSTRAINT provider_appointment FOREIGN KEY (provider_code)
    REFERENCES provider (provider_code);

ALTER TABLE patient 
    ADD CONSTRAINT emergencycontact_patient FOREIGN KEY (ec_id)
    REFERENCES emergency_contact (ec_id);

COMMIT;

