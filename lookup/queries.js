  var promise = require('bluebird');
require('dotenv').load();
var _ = require('underscore');
var options = {
	promiseLib: promise
};

var pgp = require('pg-promise')(options);
var connectionString = process.env.connectionString;
var db = pgp(connectionString);
var _ = require('underscore')


function lookup(req, res,next){
  state = req.params.state
  year = req.params.year;
  month = req.params.month;
  day = req.params.day;

  getCode(state).then(function(v){
    code = v['State Code']
    query = 'select * from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" where accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."STATE"='+code+' and accident."DAY"='+day+';'
    db.any(query).then(function (data) { 
      formatCity(data).then(function(v){
        formatBody(data).then(function(r){
          res.json(formatResponse(r))
        })
      })
    }).catch(function (err) {return next(err);});
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
    d = _.omit(d,['COUNTY','DAY','MONTH','YEAR','HOUR','MINUTE','NHS','ROUTE','LATITUDE','LONGITUD','VEH_NO','REG_STAT','TRAV_SP','DEATHS','DR_SF',"DR_SF1","DR_SF2","DR_SF3","DR_SF4","P_CRASH2","ACC_YEAR","DR_CF1","DR_CF2","DR_CF3","DR_CF4","MAK_MOD","STATE"])
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

function getCode(state){
  state = state.toUpperCase()
  return new Promise(function(resolve,reject){
    db.one('select "State Name", "State Code" from location where "State Name"= \''+state+'\' LIMIT 1;').then(function(data){
        resolve(data)
    });
  })
}

module.exports = {
	lookup:lookup
};
  // query = 'select * from accident join vehicle ON accident."YEAR" = vehicle."ACC_YEAR" and vehicle."ST_CASE" = accident."ST_CASE" where accident."MONTH" ='+month+' and accident."YEAR"='+year+' and accident."STATE"='+state+' and accident."DAY"='+day+';'

  // db.any(query).then(function (data) {
   //        res.json(data)

  //    }).catch(function (err) {
    //   return next(err);
   //        });