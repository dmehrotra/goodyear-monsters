var promise = require('bluebird');
require('dotenv').load();
var _ = require('underscore');
var options = {
    promiseLib: promise
};
const request = require('request');
var pgp = require('pg-promise')(options);
var connectionString = process.env.connectionString;
util = require('./util.js')
var db = pgp(connectionString);
var _ = require('underscore')

function getCode(state){
  state = state.toUpperCase()
  return new Promise(function(resolve,reject){
    db.one('select "State Name", "State Code" from location where "State Name"= \''+state+'\' LIMIT 1;').then(function(data){
        resolve(data)
    });
  })
}
function getClaim(){
    return new Promise(function(resolve,reject){
      db.one('select * from claim where "checked"=false and "Loss Date" >= \'2001-01-01\'::date limit 1;').then(function(data){

          resolve(data)
      }).catch(function(err){console.log(err); resolve([])}); 
  
  })
}
function getVehicleMatches(v){
    return new Promise(function(resolve,reject){ 
        original = v;
        year = v["Loss Date"].getFullYear()
        month = v["Loss Date"].getMonth() + 1
        day = v["Loss Date"].getDate()
        state = util.abbrState(v["State"],"name")
        model_year = v["Model Year"]
        if (typeof original["Model"] === 'undefined' || original["Model"] == null) {
        }else{
          original["Model"]=original["Model"].replace("'",'').split(" ")[0];
        }
        
        console.log("-----------verifying data ---------------")
        console.log(v)
        console.log(year,month,day,state)

        console.log("-----------------------------------------")

        if (state){
            getCode(state).then(function(v){
                code = v['State Code']
                query = 'select * from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" join vin on(vin."vehicle_index"=vehicle."index" and vin."ACC_YEAR"::int=vehicle."ACC_YEAR"::int) where  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_SF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."DR_CF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vehicle."P_CRASH2"=1) or  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_SF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."DR_CF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and vin."MAKE" like \'%'+original["Model"]+'%\' and vehicle."P_CRASH2"=1)'
                
                console.log("-----------Query---------------")
                console.log(query)
                console.log("-------------------------------")
                console.log(original["Model"])
                db.any(query).then(function (data) { 
                    console.log(data)
                    resolve([data,original]) 
                }).catch(function (err) { console.log(err);});
            })
        }
    })
 
}


function updateVehicles(data){
  var promises = _.map(data, function(item) {
      return new Promise(function(resolve,reject){
    
        db.any('UPDATE vehicle SET "checked" = true where index = '+item["vehicle_index"]+' and "ACC_YEAR"='+item["ACC_YEAR"]+'RETURNING index,"ACC_YEAR"').then(function(v){
            console.log("updated vehicle")
            console.log(v)
            resolve(v)
        })

      })
  });
  return Promise.all(promises);
}
function updateClaim(m){
    return new Promise(function(resolve,reject){
        db.one('UPDATE claim SET "checked"=true where id= '+m["id"]+' RETURNING id,"checked"').then(function(v){
            resolve(v)
        })
     
    })
    
}
function addMatches(data){
    var promises = _.map(data[0], function(item) {
        return new Promise(function(resolve,reject){

            insertion =[data[1]["id"],item["index"],item["vehicle_index"],item["ACC_YEAR"],item["STATE"],item["ST_CASE"]]
            


            db.one('insert into vin_match("claim_index","accident_index","vehicle_index","ACC_YEAR","STATE","ST_CASE")' + 'values($1,$2,$3,$4,$5,$6) RETURNING id,claim_index', insertion).then(function(data){
                resolve(data)
            })       
        })
    })
    return Promise.all(promises);

}
getClaim().then(function(v){
  console.log("----got a claim----")
  console.log(v)
  if (v["State"]){
        getVehicleMatches(v).then(function(d){
          if(d[0].length > 0){
              addMatches(d).then(function(q){
                  console.log('matched '+q)
                  updateClaim(v).then(function(x){
                    process.exit()
                  })  
              })          
          }else{
            updateClaim(v).then(function(x){
              process.exit()
            })
          }
         
        })
    }else{
      updateClaim(v).then(function(x){
        process.exit()
      })
    }

})

