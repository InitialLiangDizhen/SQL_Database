--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-json.sql

--Student ID: 31240291
--Student Name: Dizhen Liang
--Unit Code: FIT3171
--Applied Class No: 

/* Comments for your marker:




*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
DESC mns.appointment;
DESC mns.provider;
DESC mns.appt_serv;
SELECT
    JSON_OBJECT(
        '_id' VALUE a.appt_no,
        'datetime' VALUE to_char(appt_datetime, 'dd/mm/yyyy hh24:mi'),
        'provider_code' VALUE p.provider_code,
        'provider_name' VALUE provider_title || ' ' || provider_fname || ' ' || provider_lname,
        'item_totalcost' VALUE sum(asv.apptserv_fee + asv.apptserv_itemcost),
        'no_of_items' VALUE  sum(asi.as_item_quantity),
        'items'  VALUE JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE i.item_id,
                    'desc' VALUE item_desc,
                    'standardcost' VALUE item_stdcost,
                    'quantity' VALUE item_stock))
        
    FORMAT JSON)
    || ','
FROM  --inner join to select the appointment at least used one item
    mns.appointment a
    JOIN 
        mns.provider p ON a.provider_code = p.provider_code
    JOIN 
        mns.appt_serv asv ON a.appt_no = asv.appt_no
    JOIN 
        mns.apptservice_item asi ON asv.appt_no = asi.appt_no
        AND asv.service_code = asi.service_code
    JOIN 
        mns.item i ON asi.item_id = i.item_id
    
GROUP BY
    a.appt_no, appt_datetime, p.provider_code, 
    provider_title, provider_fname, provider_lname
ORDER BY
    a.appt_no;
    
    
    
    
