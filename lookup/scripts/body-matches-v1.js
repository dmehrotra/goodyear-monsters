var promise = require('bluebird');
require('dotenv').load();
var _ = require('underscore');
var options = {
    promiseLib: promise
};

var pgp = require('pg-promise')(options);
var connectionString = process.env.connectionString;
util = require('./util.js')
var db = pgp(connectionString);
var _ = require('underscore')

function getClaim(){
    return new Promise(function(resolve,reject){
      db.one('select * from claim where checked=false and "Loss Date" >= \'2001-01-01\'::date limit 1;').then(function(data){

          resolve(data)
      }).catch(function(err){console.log(err); resolve([])}); 
  
  })
}

function getMatches(v){
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
                 query = 'select * from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" where accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."STATE"='+code+' and accident."DAY"='+day+' and vehicle."MOD_YEAR" ='+model_year+' and vehicle."BODY_TYP" > 14 and vehicle."BODY_TYP" <> 30 and vehicle."BODY_TYP" <> 17 and vehicle."BODY_TYP" <> 66 and vehicle."BODY_TYP" <> 20 and vehicle."BODY_TYP" <> 31 and vehicle."BODY_TYP" not between 80 and 97;'
                
                console.log("-----------Query---------------")
                console.log(query)
                console.log("-------------------------------")
                db.any(query).then(function (data) { 
                  formatCity(data).then(function(v){
                    formatBody(data).then(function(r){
                        resolve([formatResponse(r),original])
     
                    })
                  })
                }).catch(function (err) { console.log(err);});
            })
        }else{
            updateClaim([{"claim_index":v['id']}]).then(function(l){
            
                console.log("------------updated claim because it was bad-----------------")
                console.log(v)
                console.log(l)
                console.log("------------------------------------------------")

                process.exit()  
            })
        }
    })
 
}

function getCode(state){
  state = state.toUpperCase()
  return new Promise(function(resolve,reject){
    db.one('select "State Name", "State Code" from location where "State Name"= \''+state+'\' LIMIT 1;').then(function(data){
        resolve(data)
    });
  })
}


function formatBody(data){
  var promises = _.map(data, function(item) {
      return new Promise(function(resolve,reject){
        _.each(data,function(d){
          db.one('select * from body_typ where "Code"= \''+d.BODY_TYP+'\' LIMIT 1;').then(function(data){
              d.BODY_TYP=data["Desc"]
              resolve(d)
          }).catch(function(err){resolve(d)}); 
        })
      })
  });
  return Promise.all(promises);
}
function formatResponse(data){
  p =[]
     
  _.each(data,function(d){
    d.date = d["MONTH"] + '/' + d["DAY"] + '/' + d["YEAR"];
    d = _.omit(d,['COUNTY','DAY','MONTH','HOUR','MINUTE','NHS','ROUTE','LATITUDE','LONGITUD','VEH_NO','REG_STAT','TRAV_SP','DEATHS','DR_SF',"DR_SF1","DR_SF2","DR_SF3","DR_SF4","P_CRASH2","ACC_YEAR","DR_CF1","DR_CF2","DR_CF3","DR_CF4","MAK_MOD"])
    p.push(d)
  })
  return p


 
}
function formatCity(data){
  var promises = _.map(data, function(item) {
      return new Promise(function(resolve,reject){
        _.each(data,function(d){
          db.one('select "State Name", "State Code","City Name","City Code" from location where "State Code"= \''+d.STATE+'\' and "City Code"=\''+d.CITY+'\' LIMIT 1;').then(function(data){
              d.CITY=data["City Name"]
              resolve(d)
          }).catch(function(err){resolve(d)}); 
        })
      })
  });
  return Promise.all(promises);
}
function addMatches(d){
    if (d[0]){
        var promises = _.map(d[0], function(item) {
            return new Promise(function(resolve,reject){
                
                insertion =[d[1]["id"],item["index"],item["ST_CASE"],item["CITY"],item["FATALS"],item["MAKE"],item["MODEL"],item["BODY_TYP"],item["MOD_YEAR"],item["VIN"],d[1]["Loss Date"]]
                db.one('insert into match("claim_index","accident_index","ST_CASE","CITY","FATALS","MAKE","MODEL","BODY_TYP","MOD_YEAR","VIN","date")' + 'values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) RETURNING id,claim_index', insertion).then(function(data){
                    resolve(data)
                })       
            })
        })
      
      return Promise.all(promises);
    }


}
function updateClaim(m){
    return new Promise(function(resolve,reject){
        db.one('UPDATE claim SET "checked" = true, "matches" ='+m.length+' where id = '+m[0]['claim_index']+' RETURNING id,checked,matches').then(function(v){
            resolve(v)
        })
     
    })
    
}
getClaim().then(function(v){
    if (v["State"]){
        getMatches(v).then(function(d){
            if (d[0].length < 1 ){
                console.log("no matches")
                updateClaim([{"claim_index":d[1]['id']}]).then(function(l){
                        console.log("------------updated claim-----------------")
                        console.log(l)
                        console.log("------------------------------------------------")

                        process.exit()  
                    })
            }else{
                console.log("------------Matches-----------------")
                console.log("matches", d)
                console.log("------------------")
                addMatches(d).then(function(p){
                    
                    console.log("------------Added Matches to DB-----------------")
                    console.log(p)
                    console.log("------------------------------------------------")

                    updateClaim(p).then(function(l){
                        console.log("------------updated claim-----------------")
                        console.log(l)
                        console.log("------------------------------------------------")
                        process.exit()
                        
                    })
                })
            }
        })
    }else{
        updateClaim([{"claim_index":v['id']}]).then(function(l){
            
            console.log("------------updated claim because it was bad-----------------")
            console.log(v)
            console.log(l)
            console.log("------------------------------------------------")

            process.exit()  
        })
    }

})