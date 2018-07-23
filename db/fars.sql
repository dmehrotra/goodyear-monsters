ALTER TABLE vehicle
	add "DR_CF1" float;
ALTER TABLE vehicle
	add "DR_CF2" float;
ALTER TABLE vehicle
	add "DR_CF3" float;
ALTER TABLE vehicle
	add "DR_CF4" float;

CREATE TABLE location
(
"State Name",
"State Code"int,
"City Code"int,
"City Name"text,
"County Code"int,
"County Name"text
);

CREATE TABLE body_typ
(
"Code" int,
"Desc" text
);
CREATE TABLE claim
(
"Name" text,
"City" text,
"State" text,
"Loss Date" date,
"Report Date" date,
"Model Year" int,
"Make" text,
"Model" text,

);
ALTER TABLE claim
	add "checked" boolean default false;

ALTER TABLE claim
   ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE claim
   ADD COLUMN "matches" integer;

CREATE TABLE match
(
id SERIAL PRIMARY KEY,
"claim_index" int,
"accident_index" text,
"ST_CASE" int,
"CITY" text,
"FATALS" int,
"MAKE" int,
"MODEL" int,
"BODY_TYP" text,
"MOD_YEAR" int,
"VIN" text,
"date" date
    
)
CREATE TABLE vin
(
id SERIAL PRIMARY KEY,
"vehicle_index" int,
"ACC_YEAR" text,
"MAKE" text,
"MODEL" text,
"YEAR" text,
"VIN" text,
"VEHICLE_TYPE" text
    
)
    
CREATE TABLE vin_match
(
id SERIAL PRIMARY KEY,
"claim_index" int,
"accident_index" int,
"vehicle_index" int,
"ACC_YEAR" text,
"VIN_ID" int,
"STATE" int,
"ST_CASE" int

)
CREATE TABLE f_r_match
(
id SERIAL PRIMARY KEY,
"claim_index" int,
"accident_index" int,
"vehicle_index" int,
"ACC_YEAR" text,
"VIN_ID" int,
"STATE" int,
"ST_CASE" int

)
CREATE TABLE vin_make_match_no_date
(
id SERIAL PRIMARY KEY,
"claim_index" int,
"accident_index" int,
"vehicle_index" int,
"ACC_YEAR" text,
"STATE" int,
"ST_CASE" int

)