----------PROCEDURE 1------------------------------------------------------

create or replace PROCEDURE remove_objects (
    name_of_object VARCHAR2,
    type_of_object VARCHAR2
) IS
    cnt NUMBER := 0;
BEGIN
    IF upper(type_of_object) = 'TABLE' THEN
        SELECT
            COUNT(*)
        INTO cnt
        FROM
            user_tables
        WHERE
            upper(table_name) = upper(TRIM(name_of_object));

        IF cnt > 0 THEN
            EXECUTE IMMEDIATE 'drop table ' || name_of_object || ' cascade constraints';
        END IF;
    END IF;
    IF upper(type_of_object) = 'VIEW' THEN
        SELECT COUNT(*) INTO cnt FROM user_views WHERE upper(view_name) = upper(TRIM(name_of_object));
        IF cnt > 0 THEN
            EXECUTE IMMEDIATE 'drop view ' || name_of_object || ' cascade constraints';
        END IF;
    END IF;

    IF upper(type_of_object) = 'USER' then
        select count(*) into cnt from all_users where username = upper(name_of_object);
    IF cnt > 0 then          
        execute immediate 'DROP USER '|| name_of_object;        
    END IF; 
    END IF;
END;


---------PROCEDURE 2 ------------------------------------------------------


create or replace PROCEDURE FIND_AFFORDABLE_APARTMENTS AS 
BEGIN
    begin
      execute immediate 'select * from APARTMENT_LISTINGS al
    JOIN APARTMENT_FEATURES af ON af.a_id = al.a_id
    where (A_DISTANCE_FROM_UNI < 3.5)
    ORDER BY al.a_name;';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
END FIND_AFFORDABLE_APARTMENTS;



---------PROCEDURE 3 ------------------------------------------------------

create or replace PROCEDURE CREATE_ALL_TABLES AS 
BEGIN
    begin
      execute immediate 'drop table USER_LOGIN';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table ROLE_MASTER';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table LISTING_TYPE_MASTER';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table UNIVERSITY_RESOURCE_TYPE';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table UNIVERSITY';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table BROKERS';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table LANDLORDS';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table MANAGEMENTS';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table NEIGHBOURS';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table APARTMENT_FEATURES';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
 begin
      execute immediate 'drop table APARTMENT_LISTINGS';
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
    end;
    dbms_output.put_line('All tables (if existing) dropped successfully.');
    begin
        execute immediate 'create table ROLE_MASTER(
            r_id number(10) primary key,
            role_name varchar2(50) not null,
            role_creationdate date default SYSDATE
        )';
        end;
        dbms_output.put_line('ROLE_MASTER table created.');
    begin
        execute immediate 'create table UNIVERSITY_RESOURCE_TYPE(
            u_type_id number(10) primary key,
            u_type_name varchar2(50) not null,
            u_creationdate date default SYSDATE
        )';
        end;
        dbms_output.put_line('UNIVERSITY_RESOURCE_TYPE table created.');
 begin
        execute immediate 'create table LISTING_TYPE_MASTER(
            l_type_id number(10) primary key,
            listing_type varchar2(50) not null,
            no_of_beds number(10) not null,
            no_of_baths number(10) not null,
            u_creationdate date default SYSDATE
        )';
        end;
        dbms_output.put_line('LISTING_TYPE_MASTER table created.');
 begin
        execute immediate 'create table USER_LOGIN(
            user_name varchar2(50) unique,
            user_id number(10) primary key,
            user_pwd varchar2(20) not null unique,
            u_creationdate date default SYSDATE
        )';
        end;
        dbms_output.put_line('USER_LOGIN table created.');
 begin
        execute immediate 'create table UNIVERSITY(
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
        )';
      
        dbms_output.put_line('UNIVERSITY table created.');

        execute immediate 'create table LANDLORDS(
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
        )';
        
        dbms_output.put_line('LANDLORDS table created.');

        execute immediate 'create table NEIGHBOURS(
           n_id number(10) primary key,
           n_name varchar2(30) not null,
           n_contactnumber number(10) not null,
           n_emailID varchar2(50),
           n_apartmentname varchar2(50),
           n_creationdate date default SYSDATE
        )';
      
        dbms_output.put_line('NEIGHBOURS table created.');

        execute immediate 'create table APARTMENT_FEATURES(
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
        )';
    
        dbms_output.put_line('APARTMENT_FEATURES table created.');
 
        execute immediate 'create table BROKERS(
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
        )';
    
        dbms_output.put_line('BROKERS table created.');

        execute immediate 'create table MANAGEMENTS(
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
        )';
      
        dbms_output.put_line('MANAGEMENTS table created.');
        

        execute immediate 'create table APARTMENT_LISTINGS(
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
        )';
  
        dbms_output.put_line('APARTMENT_LISTINGS table created.');
        end;
END CREATE_ALL_TABLES;

