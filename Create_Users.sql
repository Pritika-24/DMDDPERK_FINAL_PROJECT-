----USER 1----------------------------------------------------------------------

call remove_objects('univadmin','USER');
CREATE USER univadmin IDENTIFIED BY "Flamingo@123";
grant create session to univadmin;
grant select on university to univadmin;
grant insert on university to univadmin;
grant update on university to univadmin;

----USER 2----------------------------------------------------------------------

call remove_objects('mgmtadmin','USER');
CREATE USER mgmtadmin IDENTIFIED BY "Flamingo@123";
grant create session to mgmtadmin;
grant select on managements to mgmtadmin;
grant insert on managements to mgmtadmin;
grant update on managements to mgmtadmin;

----USER 3----------------------------------------------------------------------

call remove_objects('brokeradmin','USER');
CREATE USER brokeradmin IDENTIFIED BY "Flamingo@123";
grant create session to brokeradmin;
grant select on apartment_listings to brokeradmin;
grant insert on apartment_listings to brokeradmin;
grant update on apartment_listings to brokeradmin;
grant select on apartment_features to brokeradmin;
grant insert on apartment_features to brokeradmin;
grant update on apartment_features to brokeradmin;
grant select on landlords to brokeradmin;
grant insert on landlords to brokeradmin;
grant update on landlords to brokeradmin;

