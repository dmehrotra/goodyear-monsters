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
      db.one('select * from claim where "vin-check"=false and "Loss Date" >= \'2001-01-01\'::date limit 1;').then(function(data){

          resolve(data)
      }).catch(function(err){console.log(err); resolve([])}); 
  
  })
}
function getVehicles(v){
    return new Promise(function(resolve,reject){ 
        original = v;
        year = v["Loss Date"].getFullYear()
        month = v["Loss Date"].getMonth() + 1
        day = v["Loss Date"].getDate()
        state = util.abbrState(v["State"],"name")
        model_year = v["Model Year"]

        console.log("-----------verifying data ---------------")
        console.log(v)
        console.log(year,month,day,state)
        console.log("-----------------------------------------")

        if (state){
            getCode(state).then(function(v){
                code = v['State Code']
                query = 'select vehicle.index,"VIN","ACC_YEAR" from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" where  (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=80) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=28) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=17) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_SF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF1"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF2"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF3"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."DR_CF4"=58) or (accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."DAY"='+day+' and checked=false and vehicle."P_CRASH2"=1) limit 30'
                
                console.log("-----------Query---------------")
                console.log(query)
                console.log("-------------------------------")
                db.any(query).then(function (data) { 
                    console.log(data)
                    resolve([data,original]) 
                }).catch(function (err) { console.log(err);});
            })
        }
    })
 
}
function getVinDetails(data){
  var promises = _.map(data, function(item) {
      if (item['VIN'] !=''){
        return new Promise(function(resolve,reject){
      
          request('https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVin/'+item['VIN']+'?format=json', { json: true }, (err, res, body) => {
      		          
      		  if (err) { 

              console.log(err);
              reject(err)


            }
      		  if (body['Message']=='Results returned successfully'){
              if (typeof body["Results"] === "undefined") {
                console.log('no results')
                reject(body)
              }else{
                resolve({"results":body['Results'],original:item})

              }
      		  }else{
      		  	console.log(body)
      		  	reject(body)
      		  }
      		});
          
        })
      }

  });
  return Promise.all(promises);
}

function formatVin(data){

  var promises = _.map(data, function(item) {
      if (typeof item !=='undefined'){
        return new Promise(function(resolve,reject){
          	
            vin = formatDetails(item.results)
              insertion = [item.original['index'],item.original['ACC_YEAR'],vin["MAKE"],vin["MODEL"],vin["MY"],item.original["VIN"],vin["Vehicle Type"]]
             
              db.one('insert into vin("vehicle_index","ACC_YEAR","MAKE","MODEL","YEAR","VIN","VEHICLE_TYPE")' + 'values($1,$2,$3,$4,$5,$6,$7) RETURNING "vehicle_index","ACC_YEAR","MAKE","MODEL"', insertion).then(function(data){
                  resolve(data)
         
        		})
        	})
      }
  });
  return Promise.all(promises);
}
function formatDetails(d){

  a={
		"MAKE": _.find(d, function(data){ return data["Variable"]=="Make" })['Value'],
		"MODEL":  _.find(d, function(data){ return data["Variable"]=="Model" })['Value'],
		"MY":_.find(d, function(data){ return data["Variable"]=="Model Year" })['Value'],
		"Vehicle Type":_.find(d, function(data){ return data["Variable"]=="Vehicle Type" })['Value'] 
	}
	return a

	
}
function updateVehicles(data){
  var promises = _.map(data, function(item) {
     if (typeof item !=='undefined'){ 
      return new Promise(function(resolve,reject){
  	   
        db.any('UPDATE vehicle SET "checked" = true where index = '+item["vehicle_index"]+' and "ACC_YEAR"='+item["ACC_YEAR"]+'RETURNING index,"ACC_YEAR"').then(function(v){
            console.log("updated vehicle")
            console.log(v)
            resolve(v)
        })

      })
    }
  });
  return Promise.all(promises);
}
function updateClaim(m){
    return new Promise(function(resolve,reject){
        db.one('UPDATE claim SET "vin-check"=true where id= '+m["id"]+' RETURNING id,"vin-check"').then(function(v){
            resolve(v)
        })
     
    })
    
}

getClaim().then(function(v){
	console.log("----got a claim----")
	console.log(v)
	if (v["State"]){
        getVehicles(v).then(function(d){
        	console.log('----got vehicles that were involved in crashes this month----')
        	getVinDetails(d[0]).then(function(a){
        		console.log('----got vin details for each vehicle----')

        		formatVin(a).then(function(r){
        			updateVehicles(r).then(function(a){
        				console.log('---- updated the vehicles----')

        				updateClaim(v).then(function(x){
        				
        					process.exit() 
        				})
        			})
        		})
        	})
        })
    }else{
    	updateClaim(v).then(function(x){
    		process.exit()
    	})
    }

})