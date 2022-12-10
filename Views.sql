--REPORT 1-- To fetch the details of students and their usernames

CREATE VIEW STUDENT_DETAILS AS
select U.s_firstname,U.s_lastname,U.s_contact,U.s_email,UL.user_name FROM UNIVERSITY U 
JOIN user_login UL ON U.user_id = UL.user_id;

--REPORT 2--To fetch the details of students along with their roles

CREATE VIEW STUDENT_ROLES AS
select U.s_firstname,U.s_lastname,U.s_contact,U.s_email,UL.user_name,RM.role_name FROM UNIVERSITY U 
JOIN user_login UL ON U.user_id = UL.user_id
JOIN role_master RM ON U.r_id = RM.r_id;

--REPORT 3--To get the list of various apartments with the respective broker fee

CREATE VIEW APARTMENT_LIST AS
select AF.a_name, AF.a_rent, AF.a_address, AF.a_bedrooms, AF.a_bathrooms, mgmt.m_name, br.b_name, br.b_contactnumber, br.b_brokerfee, lr.l_name, lr.l_contact_no from APARTMENT_FEATURES AF
JOIN managements mgmt ON AF.a_id = mgmt.a_id
JOIN brokers br ON mgmt.b_licenseno = br.b_licenseno
JOIN landlords lr ON lr.l_id = AF.l_id
ORDER BY br.b_brokerfee ASC;


--REPORT 4-- To fetch the list of apartments with rent less than $3000

CREATE VIEW AFFORDABLE_APARTMENTS AS
SELECT AF.a_rent, AF.a_name, AF.a_id
FROM APARTMENT_FEATURES AF
WHERE AF.a_rent < '3000'
ORDER BY AF.a_rent ASC;


--REPORT 5-- To fetch the all the necessary details of apartments along with their listing type and availability status

CREATE VIEW APARTMENT_DETAILS AS
select AF.a_name, AF.a_address, AF.a_rent, mgmt.m_name, ne.n_apartmentname, lr.l_name, br.b_name, ltm.listing_type, al.a_status FROM APARTMENT_LISTINGS AL
JOIN APARTMENT_FEATURES AF ON AL.a_id = AF.a_id
JOIN MANAGEMENTS mgmt ON mgmt.a_id = AF.a_id
JOIN NEIGHBOURS ne ON mgmt.n_id = ne.n_id
JOIN LANDLORDS lr ON lr.l_id = AF.l_id
JOIN BROKERS br ON AF.l_id = br.l_id
JOIN APARTMENT_LISTINGS al ON al.m_id = mgmt.m_id
JOIN LISTING_TYPE_MASTER ltm ON AF.l_type_id = ltm.l_type_id
ORDER BY AF.a_rent ASC;

--REPORT 6-- To find the list of apartments available from March 2023 with broker fee less than 

CREATE VIEW AVAILABILITY_FROM_MARCH AS
select AL.a_name, AL.a_status, AL.a_startdate, AL.a_enddate, AF.a_address, AF.a_bedrooms, AF.a_bathrooms, AL.a_distance_from_uni FROM APARTMENT_LISTINGS AL
JOIN APARTMENT_FEATURES AF ON AL.a_id = AF.a_id
WHERE AL.a_startdate >= '01-03-2023'
ORDER BY AL.a_distance_from_uni ASC;


--REPORT 7-- To find the list of apartments that are furnished and within a 2 mile radius from the university

CREATE VIEW AVAILABLE_APARTMENTS_IN_PROXIMITY AS
select AL.a_name, AL.a_status, AL.a_startdate, AL.a_enddate, AF.a_address, AF.a_bedrooms, AF.a_bathrooms, AL.a_distance_from_uni FROM APARTMENT_LISTINGS AL
JOIN APARTMENT_FEATURES AF ON AL.a_id = AF.a_id
WHERE AL.a_distance_from_uni < '3.5'
ORDER BY AL.a_distance_from_uni ASC;

--REPORT 8-- To find the list of apartments offered by the broker with the lowest broker fee

CREATE VIEW AFFORABLE_BROKERS AS
select AL.m_name, br.b_name, br.b_licenseno, br.b_brokerfee, AL.a_name, AL.a_distance_from_uni FROM APARTMENT_LISTINGS AL
JOIN BROKERS br ON br.b_licenseno = AL.b_licenseno	
JOIN APARTMENT_FEATURES AF ON AL.a_id = AF.a_id
WHERE br.b_brokerfee < 1800
ORDER BY AL.a_distance_from_uni ASC;