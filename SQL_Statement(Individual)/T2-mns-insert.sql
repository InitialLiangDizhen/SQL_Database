--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-insert.sql

--Student ID: 31240291
--Student Name: LIANG DIZHEN
--Unit Code: FIT3171
--Applied Class No: 

/* Comments for your marker:




*/

--------------------------------------
--INSERT INTO emergency_contact
--------------------------------------
INSERT INTO emergency_contact VALUES (1, 'Ally', 'Smith', '6012345678'); 
INSERT INTO emergency_contact VALUES (2, 'Zafri', 'Jones', '6023456789'); 
INSERT INTO emergency_contact VALUES (3, 'Akif', 'Brown', '6034567890'); 
INSERT INTO emergency_contact VALUES (4, 'David', 'Lee', '6045678901'); 
INSERT INTO emergency_contact VALUES (5, 'Jurven', 'Wang', '6056789012');

COMMIT;
--------------------------------------
--INSERT INTO patient
--------------------------------------
INSERT INTO PATIENT VALUES (1, 'Ally', 'Smith', 'Main Street', 'Melbourne', 'VIC', 
    '528300', to_date('01-Jan-2001','dd-Mon-yyyy'), '6012345678', 'ally.smith@gmail.com', 1); 
/* The ORA-00947 error: number of values in the VALUES 
clause does not match the number of columns specified in the INSERT statement
*/
INSERT INTO PATIENT VALUES (2, 'Zafri', 'Jone', 'High Street', 'Sydney', 'NSW',
    '528301',to_date('02-Feb-2001','dd-Mon-yyyy'), '6023456789', 'zafri.jones@gmail.com', 2); 
    
INSERT INTO PATIENT VALUES (3, 'Akif', 'Brown', 'King Street', 'Brisbane', 'QLD',
    '528302', to_date('03-Mar-2002','dd-Mon-yyyy'), '6034567890', 'akif.brown@gmail.com', 3); 

INSERT INTO PATIENT VALUES (4, 'David', 'Lee', 'Queen Street', 'Perth', 'WA', 
    '528303', to_date('04-04-2003','dd-mm-yyyy'), '6045678901', 'david.lee@gmail.com', 4); 
    
INSERT INTO PATIENT VALUES (5, 'Jurven', 'Wang', 'Prince Street', 'Adelaide', 
    'SA', '528304', to_date('05-05-2004','dd-mm-yyyy'), '6056789012', NULL ,5); 
    
INSERT INTO PATIENT (patient_no, patient_fname, patient_lname, patient_street, patient_city,
    patient_state, patient_postcode, patient_dob, patient_contactmobile) VALUES (
    6, 'Ali', 'Smith' ,'Princess Street','Hobart','TAS',
    '528305' ,to_date('06-06-2010','dd-mm-yyyy') ,'6067890123'); 
    
INSERT INTO PATIENT VALUES (7, 'Curry','Jones', 'Park Street','Darwin','NT',
    '528306' ,to_date('07-07-2011','dd-mm-yyyy') ,'6078901234',NULL,NULL);  

INSERT INTO PATIENT VALUES (8, 'Helena' ,'Brown' ,'Hill Street','Canberra','ACT',
    '528307' ,to_date('08-08-2012','dd-mm-yyyy') ,'6089012345', NULL,NULL);  

INSERT INTO PATIENT VALUES (9, 'Catherine' ,'Lee','Lake Street','Gold Coast','QLD',
    '528308' ,to_date('09-09-2013','dd-mm-yyyy') ,'6089123456',NULL ,NULL);

INSERT INTO PATIENT VALUES (10, 'Qihao','Wang','River Street','Newcastle','NSW',
    '528309',to_date('10-10-2014','dd-mm-yyyy'),'6090123456', NULL, NULL);

COMMIT;
--------------------------------------
--INSERT INTO appointment
--------------------------------------
--SELECT * FROM provider;
--SELECT * FROM nurse;

--TO_DATE(¡®2021-09-28 06:44:04¡¯, ¡®YYYY-MM-DD HH24:MI:SS¡¯) 
--The ORA-12899 error: amount of parameters to insert > amount of arguments

INSERT INTO APPOINTMENT VALUES (1, to_date('2023-05-01 09:00:00', 'yyyy-mm-dd HH24:MI:SS'), 101, 'S', 1, 'END001', 1, NULL);
INSERT INTO APPOINTMENT VALUES (2, to_date('2023-05-01 09:30:00', 'yyyy-mm-dd HH24:MI:SS'), 102, 'T', 2, 'GEN001', 2, NULL);
INSERT INTO APPOINTMENT VALUES (3, to_date('2023-05-01 10:00:00', 'yyyy-mm-dd HH24:MI:SS'), 103, 'L', 3, 'GEN002', 3, NULL); 
INSERT INTO APPOINTMENT VALUES (4, to_date('2023-06-02 09:00:00', 'yyyy-mm-dd HH24:MI:SS'), 104, 'S', 4, 'GEN003', 4, NULL); 
INSERT INTO APPOINTMENT VALUES (5, to_date('2023-06-02 09:30:00', 'yyyy-mm-dd HH24:MI:SS'), 105, 'T', 5, 'ORS001', 5, NULL); 
INSERT INTO APPOINTMENT VALUES (6, to_date('2023-06-02 10:00:00', 'yyyy-mm-dd HH24:MI:SS'), 106, 'S', 6, 'PED001', 6, NULL); 
INSERT INTO APPOINTMENT VALUES (7, to_date('2023-07-03 09:00:00', 'yyyy-mm-dd HH24:MI:SS'), 107, 'T', 7, 'PED002', 7, NULL);
INSERT INTO APPOINTMENT VALUES (8, to_date('2023-07-03 10:00:00', 'yyyy-mm-dd HH24:MI:SS'), 108, 'L', 8, 'ORT001', 8, NULL);
INSERT INTO APPOINTMENT VALUES (9, to_date('2023-08-04 09:00:00','yyyy-mm-dd HH24:MI:SS'),  109,'S',9 ,'AST001',9 ,NULL); 
INSERT INTO APPOINTMENT VALUES (10,to_date('2023-08-04 09:00:00','yyyy-mm-dd HH24:MI:SS'),  110,'S',10,'AST002',10,NULL); 
INSERT INTO APPOINTMENT VALUES (11,to_date('2023-08-04 09:30:00','yyyy-mm-dd HH24:MI:SS'),  111,'S',1 ,'PER001',11,NULL); 
INSERT INTO APPOINTMENT VALUES (12,to_date('2023-08-05 10:00:00','yyyy-mm-dd HH24:MI:SS'),  112,'S',2 ,'PER002',12,NULL); 
INSERT INTO APPOINTMENT VALUES (13,to_date('2023-08-05 09:00:00','yyyy-mm-dd HH24:MI:SS'),  113,'S',3 ,'AST002',13,NULL); 
INSERT INTO APPOINTMENT VALUES (14,to_date('2023-08-05 09:30:00','yyyy-mm-dd HH24:MI:SS'),  114,'S',4 ,'PER001',14,NULL); 
INSERT INTO APPOINTMENT VALUES (15,to_date('2023-08-06 10:00:00','yyyy-mm-dd HH24:MI:SS'),  115,'S',5 ,'PER002',15,NULL);

COMMIT;

SELECT * FROM appointment
