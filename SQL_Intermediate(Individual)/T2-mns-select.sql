--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-select.sql

--Student ID: 31240291
--Student Name: Dizhen Liang
--Unit Code: FIT3171
--Applied Class No: 

/* Comments for your marker:




*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
select * from mns.provider;

SELECT
    item_id, item_desc, item_stdcost, item_stock
FROM
    mns.ITEM
WHERE
    item_stock >= 50
    AND lower(item_desc) LIKE '%composite%'
ORDER BY
item_stock DESC, item_id;


/*2(b)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT p.provider_code,  p.provider_fname || ' ' || p.provider_lname
FROM mns.provider p 
    JOIN mns.specialisation s ON p.spec_id = s.spec_id
WHERE upper(s.spec_name) = 'PAEDIATRIC DENTISTRY'
ORDER BY
    p.provider_lname, p.provider_fname, p.provider_code;



/*2(c)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    service_code, service_desc, 
    lpad(to_char(service_stdfee, '$990,00'), 14, ' ') AS expensive_fee
FROM
    mns.service
WHERE 
    service_stdfee > (
        SELECT AVG(service_stdfee)
            FROM mns.service
    )
ORDER BY
expensive_fee DESC, service_code;

/*2(d)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

DESC appointment;

SELECT 
    a.appt_no, a.appt_datetime, p.patient_no, 
    p.patient_fname || ' ' || p.patient_lname AS patient_full_name, 
    lpad(to_char(apptserv_fee + apptserv_itemcost, '$9990.00'), 15, ' ') AS appt_total_cost
--must write mns.appt_serv otherwise invalid identifier issue
FROM mns.appointment a
    JOIN mns.appt_serv s ON a.appt_no = s.appt_no
    JOIN mns.patient p ON a.patient_no = p.patient_no

WHERE apptserv_fee + apptserv_itemcost = (
    SELECT 
        MAX(apptserv_fee + apptserv_itemcost)
    FROM 
        mns.appt_serv
)
ORDER BY a.appt_no;
    


/*2(e)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    s.service_code, s.service_desc, s.service_stdfee,
    AVG(ap.apptserv_fee) - s.service_stdfee AS fee_differential
FROM  -- can not use as to be name which is a built-in function
    mns.appt_serv ap
    JOIN mns.appointment a ON ap.appt_no = a.appt_no
    JOIN mns.service s ON ap.service_code = s.service_code
GROUP BY -- group by for AVG function which group based on the following
    s.service_code, s.service_desc, s.service_stdfee
ORDER BY
    s.service_code;
    

/*2(f)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

-- get current date and change to string then number
--select to_number(to_char(SYSDATE, 'yyyy'))
--FROM DUAL;
--
--select to_number(to_char(patient_dob, 'yyyy'))
--FROM mns.patient

SELECT
    p.patient_no, 
    patient_fname || ' ' || patient_lname AS patientname,
    to_char(to_number(to_char(SYSDATE, 'yyyy')) - to_number(to_char(patient_dob, 'yyyy'))) AS currentage,
    --count(columnName) does not include null value
    --appt_prior_apptno = null is not precedented appointment number
    to_char(count(appt_no)) AS numappts,
    to_char(round((count(appt_prior_apptno)/count(appt_no)) * 100, 1)) AS followups

FROM 
    mns.appointment a
    JOIN mns.patient p ON a.patient_no = p.patient_no

GROUP BY
    p.patient_no,
    patient_fname || ' ' || patient_lname,
    to_char(to_number(to_char(SYSDATE, 'yyyy')) - to_number(to_char(patient_dob, 'yyyy')));


/*2(g)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer


--There are only values until 13-OCT-23
--select *
--FROM provider p
--LEFT JOIN appointment a ON p.provider_code = a.provider_code
--LEFT JOIN appt_serv asv ON a.appt_no = asv.appt_no
--LEFT JOIN apptservice_item asi ON asv.service_code = asi.service_code 
--            AND asv.appt_no = asi.appt_no
--WHERE
--    a.appt_datetime  --lower bound 10th 
--        BETWEEN to_date('9 AM 10 JAN 2023', 'HH AM dd mm yyyy')
--        --higher bound 14th must be in order
--        AND to_date('5 PM 14 OCT 2023', 'HH AM DD MM YYYY');
--        
--       

SELECT
    p.provider_code AS pcode,   
    --group for the count, distinict to avoid count the same appt_no for multiple times
    nvl(to_char(count(a.appt_no)), '-') AS numberappts,
    nvl(to_char(sum(asv.apptserv_fee + asv.apptserv_itemcost), '999,999.99'), '-') AS totalfees,
    nvl(to_char(sum(asi.as_item_quantity), '999'), '-') AS noitems

FROM 
    mns.provider p
LEFT JOIN 
    mns.appointment a ON p.provider_code = a.provider_code
LEFT JOIN 
    mns.appt_serv asv ON a.appt_no = asv.appt_no
LEFT JOIN 
    mns.apptservice_item asi ON asv.appt_no = asi.appt_no 
    AND asv.service_code = asi.service_code

WHERE
    a.appt_datetime  --lower bound 10th 
        BETWEEN to_date('9 AM 10 10 2023', 'HH AM dd mm yyyy')
        --higher bound 14th must be in order
        AND to_date('5 PM 14 SEP 2023', 'HH AM DD MM YYYY')
        
GROUP BY p.provider_code
ORDER BY p.provider_code;







        
        
    
    
    
    
    
    
    
