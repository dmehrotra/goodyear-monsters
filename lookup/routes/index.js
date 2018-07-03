var express = require('express');
var router = express.Router();
var db = require('../queries');

router.get('/:state/:year/:month/:day',db.lookup);



module.exports = router;
