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