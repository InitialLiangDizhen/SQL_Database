--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-dm.sql

--Student ID: 31240291
--Student Name: LIANG DIZHEN
--Unit Code: FIT3171
--Applied Class No: 

/* Comments for your marker:




*/
--3(a)
DROP SEQUENCE emergency_contact_seq;
CREATE SEQUENCE emergency_contact_seq START WITH 100 INCREMENT BY 5;
--DROP error can be ignored;
DROP SEQUENCE patient_seq;
CREATE SEQUENCE patient_seq START WITH 100 INCREMENT BY 5;

DROP SEQUENCE appointment_seq;
CREATE SEQUENCE appointment_seq START WITH 100 INCREMENT BY 5;

--3(b)
--Need to INSERT INTO emergency contact first
--Since patient would need to refers to emergency contact
--patient is the child table

INSERT INTO emergency_contact VALUES (
    emergency_contact_seq.NEXTVAL,
    'Jonathan', 
    'Robey',
    '0412523122'
);

--Then insert patient will be required by appointment
--Laura
INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Laura',
    'Robey',
    NULL,
    NULL,
    NULL,
    NULL, --to_date('01-Jan-2003','dd-Mon-yyyy')
    to_date('03-Sep-2001', 'dd-Mon-yyyy'),
    '0412523122',
    NULL,
    (
    SELECT 
        ec_id
    FROM
        emergency_contact
    WHERE 
        upper(ec_fname) = upper('Jonathan')
        AND upper(ec_lname) = upper('Robey')
    )
);
COMMIT;
SELECT * FROM patient;

--Lachlan
INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Lachlan',
    'Robey',
    NULL,
    NULL,
    NULL,
    NULL, --to_date('01-Jan-2003','dd-Mon-yyyy')
    to_date('04-Sep-2001', 'dd-Mon-yyyy'),
    '0412523122',
    NULL,
    (
    SELECT 
        ec_id
    FROM
        emergency_contact
    WHERE 
        upper(ec_fname) = upper('Jonathan')
        AND upper(ec_lname) = upper('Robey')
    )
);
COMMIT;

SELECT * FROM patient;

--INSERT INTO APPOINTMENT VALUES (1, '2023-05-01 09:00:00', 
--101, 'S', 1, 'END001', 1, NULL); 

--SELECT * FROM provider;
--Laura
INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    to_date('04-Sep-2023 15:30:00', 'DD-Mon-YYYY HH24:MI:SS'),
    NULL,
    'S',
    (
    SELECT
        patient_no
    FROM
        patient
    WHERE 
        lower(patient_fname) = lower('Laura')
        AND lower(patient_lname) = lower('Robey')
    ),
    (
    SELECT
        provider_code 
    FROM
        provider 
    WHERE 
        upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('STRIPLIN')
    ),
    6,
    NULL
);
--COMMIT before SELECT;
COMMIT;

--Lachlan
INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    to_date('04-Sep-2023 16:00:00', 'DD-Mon-YYYY HH24:MI:SS'),
    --'4th September 2023 4:00 PM',
    NULL,
    'S',
    (
    SELECT
        patient_no
    FROM
        patient
    WHERE 
        lower(patient_fname) = lower('Lachlan')
        AND lower(patient_lname) = lower('Robey')
    ),
    (
    SELECT
        provider_code 
    FROM
        provider 
    WHERE 
        upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('STRIPLIN')
    ),
    6,
    NULL
);
--COMMIT before SELECT;
COMMIT;
SELECT * FROM appointment;

--3(c)
--Follow-up appoitment
--Lachlan
--rename appointment as a and patient a p
--declare lan_patient_number to be used for appointment since it is unique and unchanged
--DECLARE lan_patient_no NUMBER; BEGIN SELECT patient_no INTO lan_patient_no 
--    FROM patient
--    WHERE lower(patient_fname) = lower('Lachlan') 
--    AND lower(patient_lname) = lower('Robey'); 
--    END;
--SELECT TO_CHAR(appt_datetime, 'YYYY-MM-DD HH24:MI:SS') AS appt_datetime 
--FROM appointment 
--WHERE appt_no = 125;
INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL, --sequence to naturally increment
    ( --SELECT MAX(appt_datetime) MAX for latest date if multiple rows selected
        SELECT appt_datetime 
        FROM appointment a --join table to make columns from tables to be all visible
        JOIN patient p on a.patient_no = p.patient_no
        WHERE lower(patient_fname) = lower('Lachlan')
        AND lower(patient_lname) = lower('Robey')
    )+INTERVAL '10' DAY, 
    NULL, -- +INTERVAL 'How Many' to increment day, time or any
    'S',
    (
    SELECT
        patient_no
    FROM
        patient
    WHERE 
        lower(patient_fname) = lower('Lachlan')
        AND lower(patient_lname) = lower('Robey')
    ),
    (
    SELECT
        provider_code 
    FROM
        provider 
    WHERE 
        upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('STRIPLIN')
    ),
    14,
    NULL
);
COMMIT;


----to_char to convert date into string, then as to display in a column of appt_datetime
SELECT TO_CHAR(appt_datetime, 'YYYY-MM-DD HH24:MI:SS') AS appt_datetime 
FROM appointment;

SELECT * FROM patient;

--3(d)
--Lachlan
UPDATE appointment 
SET appt_datetime = appt_datetime + INTERVAL '4' DAY 
WHERE patient_no = 
    (
    SELECT patient_no
    FROM patient
    WHERE lower(patient_fname) = lower('Lachlan') 
    AND lower(patient_lname) = lower('Robey')
    )
AND nurse_no = 14;

COMMIT;
SELECT * FROM appointment;


--3(e)
DELETE FROM appointment
WHERE 
    provider_code = 
    (
    SELECT
        provider_code 
    FROM
        provider 
    WHERE 
        upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('STRIPLIN')
    )
    AND appointment.appt_datetime 
    BETWEEN to_date('15-Sep-2023', 'dd-Mon-yyyy')
    AND to_date('22-Sep-2023', 'dd-Mon-yyyy');
    
