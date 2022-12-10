create table ROLE_MASTER(
   r_id number(10) primary key,
   role_name varchar2(50) not null,
   role_creationdate date default SYSDATE
);

create table UNIVERSITY_RESOURCE_TYPE(
   u_type_id number(10) primary key,
   u_type_name varchar2(50) not null,
   u_creationdate date default SYSDATE
);

create table LISTING_TYPE_MASTER(
   l_type_id number(10) primary key,
   listing_type varchar2(50) not null,
   no_of_beds number(10) not null,
   no_of_baths number(10) not null,
   u_creationdate date default SYSDATE
);

create table USER_LOGIN(
   user_name varchar2(50) unique,
   user_id number(10) primary key,
   user_pwd varchar2(20) not null unique,
   u_creationdate date default SYSDATE
);

create table UNIVERSITY (
    s_id number(10) primary key,
    s_firstname varchar2(20) not null,
    s_lastname varchar2(20) not null,
    s_email varchar2(20) not null unique,
    s_contact number(20) not null unique,
    s_passportnumber varchar2(20) not null unique,
    r_id number(10) not null,
    u_type_id number(10) not null,
    user_id number(10) not null,
    FOREIGN KEY (r_id)
    REFERENCES ROLE_MASTER (r_id),
    FOREIGN KEY (u_type_id)
    REFERENCES UNIVERSITY_RESOURCE_TYPE (u_type_id),
    FOREIGN KEY (user_id)
    REFERENCES USER_LOGIN (user_id),
    s_creationdate date default SYSDATE
);

create table LANDLORDS (
    l_id number(10) primary key,
    l_name varchar2(30) not null,
    l_address varchar2(40) not null,
    l_emailID varchar2(50),
    l_contact_no number(10),
    r_id number(10) not null,
    user_id number(10) not null,
    FOREIGN KEY (r_id)
    REFERENCES ROLE_MASTER (r_id),
    FOREIGN KEY (user_id)
    REFERENCES USER_LOGIN (user_id),
    l_creationdate date default SYSDATE
);

create table NEIGHBOURS (
    n_id number(10) primary key,
    n_name varchar2(30) not null,
    n_contactnumber number(10) not null,
    n_emailID varchar2(50),
    n_apartmentname varchar2(50),
    n_creationdate date default SYSDATE
);

create table APARTMENT_FEATURES (
    a_id number(10) primary key,
    a_name varchar2(40) not null,
    l_id number(10) not null,
    l_type_id number(10) not null,
    a_landlordname varchar2(30) not null,
    a_address varchar2(30) not null unique,
    a_rent number(10) not null,
    a_utilitiesprovided varchar2(40) not null,
    a_bedrooms number(10) not null,
    a_bathrooms number(10) not null,
    n_id number(10) not null,
    a_grocerystoresnearby varchar2(30) not null,
    a_hospitalnearby varchar2(50) not null,
    a_mbtastation varchar2(30) not null,
    FOREIGN KEY (l_type_id)
    REFERENCES LISTING_TYPE_MASTER (l_type_id),
    FOREIGN KEY (n_id)
    REFERENCES NEIGHBOURS (n_id),
    FOREIGN KEY (l_id)
    REFERENCES LANDLORDS (l_id),
    a_creationdate date default SYSDATE
);


create table BROKERS (
    b_licenseno number(10) primary key,
    b_name varchar2(30) not null,
    b_contactnumber number(10) not null,
    b_apartmentname varchar2(50),
    b_brokerfee number(10) not null,
    l_id number(10) not null,
    r_id number(10) not null,
    user_id number(10) not null,
    FOREIGN KEY (r_id)
    REFERENCES ROLE_MASTER (r_id), 
    FOREIGN KEY (l_id)
    REFERENCES LANDLORDS (l_id),
    FOREIGN KEY (user_id)
    REFERENCES USER_LOGIN (user_id),
    b_creationdate date default SYSDATE
);


create table MANAGEMENTS (
    m_id number(10) primary key,
    m_name varchar2(30) not null,
    b_licenseno number(10) not null,
    m_brokername varchar2(30) not null,
    a_id number(10) not null,
    n_id number(10) not null,
    FOREIGN KEY (b_licenseno)
    REFERENCES BROKERS (b_licenseno),
    FOREIGN KEY (a_id)
    REFERENCES APARTMENT_FEATURES (a_id),
    FOREIGN KEY (n_id)
    REFERENCES NEIGHBOURS (n_id),
    m_creationdate date default SYSDATE
);




create table APARTMENT_LISTINGS (
    s_id number(10) not null,
    b_licenseno number(10) not null,
    m_id number(10) not null,
    m_name varchar2(50) not null,
    a_id number(10) not null,
    a_name varchar2(50) not null,
    a_distance_from_uni varchar2(20) not null,
    a_startdate date,
    a_enddate date,
    a_furnished varchar2(10) not null,
    a_status varchar2(10) not null,
    FOREIGN KEY (s_id)
    REFERENCES UNIVERSITY (s_id),
    FOREIGN KEY (a_id)
    REFERENCES APARTMENT_FEATURES (a_id),
    FOREIGN KEY (b_licenseno)
    REFERENCES BROKERS (b_licenseno),
    FOREIGN KEY (m_id)
    REFERENCES MANAGEMENTS (m_id),
    al_creationdate date default SYSDATE
);




INSERT INTO ROLE_MASTER (r_id,role_name) VALUES(1,'Admin');
INSERT INTO ROLE_MASTER (r_id,role_name) VALUES(2,'Read Only');
INSERT INTO ROLE_MASTER (r_id,role_name) VALUES(3,'Report user');
commit;


INSERT INTO UNIVERSITY_RESOURCE_TYPE (u_type_id,u_type_name) VALUES(11,'Student');
INSERT INTO UNIVERSITY_RESOURCE_TYPE (u_type_id,u_type_name) VALUES(22,'Faculty');
INSERT INTO UNIVERSITY_RESOURCE_TYPE (u_type_id,u_type_name) VALUES(33,'Office Admin');
commit;


INSERT INTO LISTING_TYPE_MASTER (l_type_id,listing_type,no_of_beds,no_of_baths) VALUES(1111,'Studio Apartment',1,1);
INSERT INTO LISTING_TYPE_MASTER(l_type_id,listing_type,no_of_beds,no_of_baths) VALUES(2222,'Individual house',3,2);
INSERT INTO LISTING_TYPE_MASTER (l_type_id,listing_type,no_of_beds,no_of_baths) VALUES(3333,'Pent house',4,3);
INSERT INTO LISTING_TYPE_MASTER (l_type_id,listing_type,no_of_beds,no_of_baths) VALUES(4444,'Duplex Apartment',6,4);
INSERT INTO LISTING_TYPE_MASTER (l_type_id,listing_type,no_of_beds,no_of_baths) VALUES(5555,'Sky Villa Apartment',8,6);
commit;

INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('mark_cuban',501,'mark_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('alex_kumar',502,'alex_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('rooney_powell',503,'rooney_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('shelly_mcdaniel',504,'shelly_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('joyce_hector',505,'joyce_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('cairo_kim',506,'cairo_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('petra_powell',507,'petra_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('quamar_kolala',508,'quamar_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('daria_savage',509,'daria_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('gergory_hall',510,'gregory_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('vance_joy',511,'vance_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('elizabeth_david',512,'elizabeth_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('khloe_k',513,'khloe_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('finn',514,'finn_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('susan',515,'susan_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('phil',516,'phil_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('sarah',517,'sarah_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('damien',518,'damien_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('kimmy',519,'kimmy_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('frank',520,'frank_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('hank',521,'hank_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('joel',522,'joel_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('clark',523,'clark_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('liam',524,'liam_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('noah',525,'noah_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('olive',526,'olive_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('elijah',527,'elijah_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('james',528,'james_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('olivia',529,'olivia_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('emma',530,'emma_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('amelia',531,'amelia_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('sophia',532,'sophia_123');
INSERT INTO USER_LOGIN (user_name,user_id,user_pwd) VALUES('mia',533,'mia_123');
commit;


INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2100,'Mark','Cuban','cuban@univ.edu','8769876547','123456780',2,11,501);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2101,'Alex','Kumar','alex@univ.edu','8778676547','123456781',2,11,502);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2102,'Rooney','Powell','rooney@univ.edu','3786333131','123456782',2,11,503);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2103,'Shelly','Mcdaniel','cshelly@univ.edu','5723733047','123456783',2,11,504);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2104,'Joyce','Hector','shelby@univ.edu','5251887926','123456784',2,11,505);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2105,'Cairo','Kim','cairo@univ.edu','7711982880','123456785',2,11,506);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2106,'Petra','Powell','petra@univ.edu','6426770867','123456786',2,11,507);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2107,'Quamar','Kolala','quamar@univ.edu','1218626186','123456787',2,11,508);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2108,'Daria','Savage','daria@univ.edu','3217172671','123456788',2,11,509);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2109,'Gregory','Hall','gregory@univ.edu','5460597124','123456789',2,11,510);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2200,'Vance','Joy','vanvce@univ.edu','8573859590','123456333',2,22,511);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2201,'Elizabeth','David','elizabeth@univ.edu','8573859561','123456111',2,22,512);
INSERT INTO UNIVERSITY (s_id,s_firstname,s_lastname,s_email,s_contact,s_passportnumber,r_id,u_type_id,user_id) VALUES(2202,'Khloe','K','khloe@univ.edu','8573859570','1234562222',2,33,513);
commit;

INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3001,'Liam','189 Grampian Way #1','liam11@gmail.com','8675674321',1,524);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3002,'Noah','1 Claymont Terrace #SF','noah78@gmail.com','8675600329',1,525);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3003,'Oliver','791 East Third St #2','oliver555@gmail.com','8215550300',1,526);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3004,'Elijah','4343 Washington Street','elijah045@gmail.com','8135600377',1,527);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3005,'James','285 Columbus Ave #503','james431@gmail.com','8675600329',1,528);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3006,'Olivia','27 Marcella St #27A','olivia88@gmail.com','8676674777',1,529);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3007,'Emma','72 Sanford Street #72','emma24@gmail.com','8175690666',1,530);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3008,'Amelia','45 Hooker St #2','ameliaj97@gmail.com','8794562310',1,531);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3009,'Sophia','1179 Boylston Street','sophia215@gmail.com','8877654790',1,532);
INSERT INTO LANDLORDS (l_id,l_name,l_address,l_emailID,l_contact_no,r_id,user_id) VALUES(3010,'Mia','27 Mission Hill St #22B','miahun@gmail.com','8675600329',1,533);

commit;



INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1010,'Renae','7358429955','renaerivz@gmail.com','JVUE Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1011,'Ria','7397364251','roblox8@gmail.com','Longwood Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1012,'Roopak','7358510297','roopnae8003@gmail.com','Mission Hill Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1013,'Pritika','7358455667','pritika@gmail.com','Mission Park Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1014,'Evita','8654567245','evita@gmail.com','West Square Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1015,'Harshan','8345765012','harshan@gmail.com','Park Way Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1016,'Darshita','3451678530','darshita@gmail.com','Westland Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1017,'Ope','8756452709','ope@gmail.com','Vero Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1018,'Abdul','8855340980','abdul@gmail.com','Church Park Apartments');
INSERT INTO NEIGHBOURS (n_id,n_name,n_contactnumber,n_emailID,n_apartmentname) VALUES(1019,'Fabian','9890457134','fabian@gmail.com','Green House Apartments');
commit;

INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(101,'JVUE Apartments',3001,2222,'Liam','Boylston',2100,'Laundry, Water',3,2,1010,'Stop and shop','Mission hill hopital','Brigham Circle');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(102,'Longwood Apartments',3002,4444,'Noah','Roxbury',3300,'Water,Electricity,Heater',6,4,1011,'Punjabi Mini Mart','Tufts Medical Center','Longwood Station');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(103,'Mission Hill Apartments',3003,1111,'Oliver','Longwood',2500,'Laundry,Heater,Water',1,1,1012,'Wollastons','Massachusetts General Hospital','Riverway Station');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(104,'Mission Park Apartments',3004,2222,'Elijah','Mission Hill',2700,'Electricity,Heater,Water',3,2,1013,'CVS Pharmacy','Brigham and Womens Hospital','Mission Park Station');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(105,'West Square Apartments',3005,5555,'James','Mission Park',4500,'Gas,Electricity,Heater,Water',8,6,1014,'Target','Lahey Hospital and Medical Center, B','Park Street');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(106,'Parkway Apartments',3006,2222,'Olivia','Jackson Square',3300,'Gas,Electricity',3,2,1015,'Shell','Southcoast Hospitals Group','Kendal');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(107,'Westland Apartments',3007,3333,'Emma','Tremont Street',3000,'Water,Heater',4,3,1016,'Wallgreens','Newton-Wellesley Hospital','Quincy Center');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(108,'Vero Apartments',3008,1111,'Amelia','Jamaica Plain',2200,'Gas,Electricity,Water',1,1,1017,'Dollar Tree','Beth Israel Deaconess Medical Center','Broadway');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(109,'Church Park Apartments',3009,2222,'Sophia','Dorchester',2885,'Water,Heater',3,2,1018,'Star Market','St. Vincent Hospital','South Station');
INSERT INTO APARTMENT_FEATURES (a_id,a_name,l_id,l_type_id,a_landlordname,a_address,a_rent,a_utilitiesprovided,a_bedrooms,a_bathrooms,n_id,a_grocerystoresnearby,a_hospitalnearby,a_mbtastation) VALUES(110,'Greenhouse Apartments',3010,4444,'Mia','Huntington Avenue',3100,'Electricity,Gas,Laundry,Water',6,4,1019,'Walmart','Southcoast Hospitals','Downtown Crossing');
commit;



INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (12345,'Finn',8786954320,'JVUE Apartments,Longwood Apartments',2000,3001,1,514);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (56735,'Susan',8567652341,'Mission Hill Apartments,West Square Apartments',1500,3002,1,515);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (78375,'Phil',834564897,'Mission Park Apartments,Park Way Apartments',1500,3003,1,516);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (65678,'Sarah',8646788831,'Mission Hill Apartments,Church Park Apartments',2500,3004,1,517);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (85378,'Damian',8573452890,'Vero Apartments,JVUE Apartments',3000,3005,1,518);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (36542,'Kimmy',8754534562,'Green House Apartments,Longwood Apartments',2000,3006,1,519);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (98635,'Frank',8573452890,'Westland Apartments,West Square Apartments',3000,3007,1,520);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (23457,'Hank',8656745632,'Park Way Apartments,Mission Hill Apartments',1800,3008,1,521);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (83634,'Joel',8573452890,'Green House Apartments,Church Park Apartments',1400,3009,1,522);
INSERT INTO BROKERS (b_licenseno,b_name,b_contactnumber,b_apartmentname,b_brokerfee,l_id,r_id,user_id) VALUES (81546,'Clark',8656745632,'Park Way Apartments,Westland Apartments',1200,3010,1,523);
commit;


INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5999,'Delphi Management Co',12345,'Finn',101,1010);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5666,'Charles Management Co',56735,'Susan',102,1011);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5554,'Helvetica Management Co',78375,'Phil',103,1012);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5451,'Padmatch Management Co',65678,'Sarah',104,1013);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5440,'Finberg Management Co',85378,'Damian',105,1014);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5321,'Avery Management Co',36542,'Kimmy',106,1015);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5497,'Saveall Management Co',98635,'Frank',107,1016);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5665,'Real Property Management Co',23457,'Hank',108,1017);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5007,'Flurys Management Co',83634,'Joel',109,1018);
INSERT INTO MANAGEMENTS (m_id,m_name,b_licenseno,m_brokername,a_id,n_id) VALUES (5115,'Kenmore Property Management Co',81546,'Clark',110,1019);
commit;





INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2100,12345,5999,'Delphi Management Co',101,'JVUE Apartments',2.1,'01-JAN-2023','01-JAN-2024','Y','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2101,56735,5666,'Charles Management Co',102,'Longwood Apartments',1.5,'01-FEB-2023','01-FEB-2024','Y','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2102,78375,5554,'Helvetica Management Co',103,'Mission Hill Apartments',2,'01-JAN-2023','01-JAN-2024','N','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2103,65678,5451,'Padmatch Management Co',104,'Mission Park Apartments',4 ,'01-MAR-2023','01-MAR-2024','N','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2104,85378,5440,'Finberg Management Co',105,'West Square Apartments',0.5,'01-JAN-2023','01-JAN-2024','Y','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2105,36542,5321,'Avery Management Co',106,'Parkway Apartments',1,'01-SEP-2023','01-SEP-2024','Y','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2106,98635,5497,'Saveall Management Co',107,'Westland Apartments',3.5,'01-FEB-2023','01-FEB-2024','N','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2107,23457,5665,'Real Property Management Co',108,'Vero Apartments',5,'01-APR-2023','01-APR-2024','Y','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2108,83634,5007,'Flurys Management Co',109,'Church Park Apartments',3,'01-MAR-2023','01-MAR-2024','N','Y');
INSERT INTO APARTMENT_LISTINGS (s_id,b_licenseno,m_id,m_name,a_id,a_name,a_distance_from_uni,a_startdate,a_enddate,a_furnished,a_status) VALUES (2109,81546,5115,'Kenmore Property Management Co',110,'Greenhouse Apartments',1.2,'01-DEC-2022','01-DEC-2023','N','Y');

commit;







