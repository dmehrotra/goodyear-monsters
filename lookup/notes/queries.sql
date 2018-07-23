Copy (select *
  from claim 
  join f_r_match on(claim.id=f_r_match.claim_index) 
  join vehicle on (vehicle.index = f_r_match.vehicle_index and vehicle."ACC_YEAR"::int=f_r_match."ACC_YEAR"::int) 
  join accident on(vehicle."STATE"=accident."STATE" and vehicle."ST_CASE"=accident."ST_CASE" and vehicle."ACC_YEAR"=accident."YEAR") 
  join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int)
  left join location on (accident."STATE" = location."State Code" and accident."COUNTY" = location."County Code")
  INNER join person on (person."ST_CASE"=accident."ST_CASE" and person."ACC_YEAR"::int = vehicle."ACC_YEAR"::int)
  where (vehicle."VIN"="1FUYSDYB0YL6") or (vehicle."VIN"="1FUYDDYB7YLB") or (vehicle."VIN"="1RF12061X110") To '/tmp/test2.csv' With HEADER CSV DELIMITER ',';


  Copy (select *
  from vehicle 
  join accident on(vehicle."STATE"=accident."STATE" and vehicle."ST_CASE"=accident."ST_CASE" and vehicle."ACC_YEAR"=accident."YEAR")
  join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int)
  left join location on (accident."STATE" = location."State Code" and accident."COUNTY" = location."County Code")
  INNER join person on (person."ST_CASE"=accident."ST_CASE" and person."ACC_YEAR"::int = vehicle."ACC_YEAR"::int)
  where (vehicle."VIN"=upper('1RF135616710')) or (vehicle."VIN"=upper('1RF120412Y10')) or (vehicle."VIN"=upper('1RF12061X110'))) To '/tmp/test2.csv' With HEADER CSV DELIMITER ',';

Copy (select distinct person."AGE",person."SEX", accident."ST_CASE",vin_make_match."claim_index",vin_make_match."vehicle_index",claim."Name",claim."City",claim."State",claim."Loss Date",accident."YEAR",accident."MONTH",accident."DAY",claim."Model Year",vin."YEAR",claim."Make",vin."MAKE",claim."Model",vin."MODEL",vehicle."VIN", vin."VEHICLE_TYPE", accident."LATITUDE", accident."LONGITUD",location."State Name",location."County Name"
  from claim 
  join vin_make_match on(claim.id=vin_make_match.claim_index) 
  join vehicle on (vehicle.index = vin_make_match.vehicle_index and vehicle."ACC_YEAR"::int=vin_make_match."ACC_YEAR"::int) 
  join accident on(vehicle."STATE"=accident."STATE" and vehicle."ST_CASE"=accident."ST_CASE" and vehicle."ACC_YEAR"=accident."YEAR") 
  join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int)
  left join location on (accident."STATE" = location."State Code" and accident."COUNTY" = location."County Code")
  INNER join person on (person."ST_CASE"=accident."ST_CASE" and person."ACC_YEAR"::int = vehicle."ACC_YEAR"::int)
  where (accident."ROUTE" =1 or accident."ROUTE" = 2 or accident."ROUTE" = 2 or accident."ROUTE" = 9) and
  (vehicle."DR_SF1"=80 or vehicle."DR_SF1" =80 or vehicle."DR_SF2" =80 or vehicle."DR_SF3" =80 or vehicle."DR_SF4" =80 or vehicle."DR_CF1"=80 or vehicle."DR_CF1" =80 or vehicle."DR_CF2" =80 or vehicle."DR_CF3" =80 or vehicle."DR_CF4" =80) or
   (vehicle."DR_SF1"=28 or vehicle."DR_SF1" =28 or vehicle."DR_SF2" =28 or vehicle."DR_SF3" =28 or vehicle."DR_SF4" =28 or vehicle."DR_CF1"=28 or vehicle."DR_CF1" =28 or vehicle."DR_CF2" =28 or vehicle."DR_CF3" =28 or vehicle."DR_CF4" =28) or
   (vehicle."DR_SF1"=17 or vehicle."DR_SF1" =17 or vehicle."DR_SF2" =17 or vehicle."DR_SF3" =17 or vehicle."DR_SF4" =17 or vehicle."DR_CF1"=17 or vehicle."DR_CF1" =17 or vehicle."DR_CF2" =17 or vehicle."DR_CF3" =17 or vehicle."DR_CF4" =17) or
   (vehicle."DR_SF1"=58 or vehicle."DR_SF1" =58 or vehicle."DR_SF2" =58 or vehicle."DR_SF3" =58 or vehicle."DR_SF4"=58 or vehicle."DR_CF1"=58 or vehicle."DR_CF1" =58 or vehicle."DR_CF2" =58 or vehicle."DR_CF3" =58 or vehicle."DR_CF4"=58) or
  (vehicle."P_CRASH2" = 1)) To '/tmp/test2.csv' With HEADER CSV DELIMITER ',';



Copy (select accident."ST_CASE",vin_match."claim_index",vin_match."vehicle_index",claim."Name",claim."City",claim."State",claim."Loss Date",accident."YEAR",accident."MONTH",accident."DAY",claim."Model Year",vin."YEAR",claim."Make",vin."MAKE",claim."Model",vin."MODEL",vehicle."VIN", vin."VEHICLE_TYPE", accident."LATITUDE", accident."LONGITUD"
  from claim 
  join vin_match on(claim.id=vin_match.claim_index) 
  join vehicle on (vehicle.index = vin_match.vehicle_index and vehicle."ACC_YEAR"::int=vin_match."ACC_YEAR"::int) 
  join accident on(vehicle."STATE"=accident."STATE" and vehicle."ST_CASE"=accident."ST_CASE" and vehicle."ACC_YEAR"=accident."YEAR") 
  join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int)
  where (accident."ROUTE" =1 or accident."ROUTE" = 2 or accident."ROUTE" = 2 or accident."ROUTE" = 9)) To '/tmp/test2.csv' With HEADER CSV DELIMITER ',';



  select claim."Make",claim."Model",vin."MAKE",vin."MODEL"
  from claim 
  join vin_match on(claim.id=vin_match.claim_index) 
  join vehicle on (vehicle.index = vin_match.vehicle_index and vehicle."ACC_YEAR"::int=vin_match."ACC_YEAR"::int) 
  join accident on(vehicle."STATE"=accident."STATE" and vehicle."ST_CASE"=accident."ST_CASE" and vehicle."ACC_YEAR"=accident."YEAR") 
  join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int)
  where (accident."ROUTE" =1 or accident."ROUTE" = 2 or accident."ROUTE" = 2 or accident."ROUTE" = 9)


  /.kujyhgef'select * from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE"   join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int) where  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."P_CRASH2"=1)'

1FUYSDYB0YL6




where make = make
where model = model 
where make = model 
where model = make



Copy (select distinct person."AGE",person."SEX", accident."ST_CASE",vin_match."claim_index",vin_match."vehicle_index",claim."Name",claim."City",claim."State",claim."Loss Date",accident."YEAR",accident."MONTH",accident."DAY",claim."Model Year",vin."YEAR",claim."Make",vin."MAKE",claim."Model",vin."MODEL",vehicle."VIN", vin."VEHICLE_TYPE", accident."LATITUDE", accident."LONGITUD",location."State Name",location."County Name"  from claim 
  join vin_match on(claim.id=vin_match.claim_index) 
  join vehicle on (vehicle.index = vin_match.vehicle_index and vehicle."ACC_YEAR"::int=vin_match."ACC_YEAR"::int) 
  join accident on(vehicle."STATE"=accident."STATE" and vehicle."ST_CASE"=accident."ST_CASE" and vehicle."ACC_YEAR"=accident."YEAR") 
  join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int)
  left join location on (accident."STATE" = location."State Code" and accident."COUNTY" = location."County Code")
  INNER join person on (person."ST_CASE"=accident."ST_CASE" and person."ACC_YEAR"::int = vehicle."ACC_YEAR"::int)
  where (upper(vin."MODEL") like claim."Model") or
   (upper(vin."MAKE") like claim."Make") or
   (upper(vin."MAKE") like claim."Model") or
   (upper(vin."MODEL") like claim."Make") or
   (lower(vin."MODEL") like 'tourist coach') or
   (lower(vin."MODEL") like 'monaco') or
   (lower(vin."MODEL") like 'roadmaster') or
   (lower(vin."MODEL") like 'recreational vehicle') or
   (lower(vin."MAKE") like 'roadmaster') or
   (lower(vin."MAKE") like 'spartan motor chassis') or
   (lower(vin."MAKE") like 'workhorse')

   ) To '/tmp/test2.csv' With HEADER CSV DELIMITER ',';




astrovan
Tourist Coach
monaco
Roadmaster
Recreational Vehicle



'select * from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE"   join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int) where  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_SF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."DR_CF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+'  and vehicle."P_CRASH2"=1)'




where make = make
where model = model 
where make = model 
where model = make



Copy (select distinct accident."ST_CASE",f_r_match."claim_index",f_r_match."vehicle_index",claim."Name",claim."City",claim."State",claim."Loss Date",accident."YEAR",accident."MONTH",accident."DAY",claim."Model Year",vin."YEAR",claim."Make",vin."MAKE",claim."Model",vin."MODEL",vehicle."VIN", vin."VEHICLE_TYPE", accident."LATITUDE", accident."LONGITUD",location."State Name",location."County Name"  from claim 
  join f_r_match on(claim.id=f_r_match.claim_index) 
  join vehicle on (vehicle.index = f_r_match.vehicle_index and vehicle."ACC_YEAR"::int=f_r_match."ACC_YEAR"::int) 
  join accident on(vehicle."STATE"=accident."STATE" and vehicle."ST_CASE"=accident."ST_CASE" and vehicle."ACC_YEAR"=accident."YEAR") 
  join vin on (vehicle.index = vin.vehicle_index and vehicle."ACC_YEAR"::int=vin."ACC_YEAR"::int)
  left join location on (accident."STATE" = location."State Code" and accident."COUNTY" = location."County Code")

   ) To '/tmp/test2.csv' With HEADER CSV DELIMITER ',';




astrovan
Tourist Coach
monaco
Roadmaster
Recreational Vehicle

select vehicle.index,"VIN","ACC_YEAR" from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" where 
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."P_CRASH2"=1) limit 30






select vehicle.index,"VIN","ACC_YEAR" from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" join vin on(vin."vehicle_index"=vehicle."index" and vin."ACC_YEAR"::int=vehicle."ACC_YEAR"::int) where 
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."P_CRASH2"=1) or 
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."P_CRASH2"=1) 


select vehicle.index,"VIN","ACC_YEAR" from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" where 
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."P_CRASH2"=1) limit 30






select vehicle.index,"VIN","ACC_YEAR" from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" join vin on(vin."vehicle_index"=vehicle."index" and vin."ACC_YEAR"::int=vehicle."ACC_YEAR"::int) where 
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_SF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."DR_CF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Make"]+'%\' and vehicle."P_CRASH2"=1) or 
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=80) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=28) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=17) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=58) or
  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."P_CRASH2"=1) 





