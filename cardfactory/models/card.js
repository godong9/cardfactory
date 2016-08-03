var _ = require('underscore');
var async = require('async');
var validator = require('validator');

var pool = require('../db/db').pool;

function Card() {

}

/**
 * Validate
 *
 * @param {Object} params
 * @param {Number} params.userId
 * @param {Number} params.cardTypeId
 * @param {Number} params.fontSize
 * @param {Number} params.brightness
 * @param {String} params.font
 * @param {String} params.img
 * @param {String} params.content
 * @param {String} params.source
 *
 * @returns {*}
 */
Card.validate = function(params) {
  if (!validator.isInt(params.userId)) {
    return 'userId error';
  }
  if (!validator.isInt(params.cardTypeId)) {
    return 'cardTypeId error';
  }
  if (!validator.isInt(params.fontSize)) {
    return 'fontSize error';
  }
  if (!validator.isInt(params.brightness)) {
    return 'brightness error';
  }
  if (!_.isString(params.font)) {
    return 'font error';
  }
  if (!_.isString(params.img)) {
    return 'img error';
  }
  if (!_.isString(params.content)) {
    return 'content error';
  }
  if (!_.isString(params.source)) {
    return 'source error';
  }
  return false;
};

// Get card
/*
 카드를 일정 수만 가져오도록 코딩할 것.
 params.pageNum = 1; 
 params.perPage = 20;
*/
Card.get = function(params, finalCallback) {
  var query = "SELECT * FROM card";

  pool.query(query, function (err, result) {
    finalCallback(err, result);
  });
};

// Get card by Id
Card.getById = function(params, finalCallback) {
  var query = "SELECT * FROM card WHERE Id = ?;";

  async.waterfall([
    function(callback){

      pool.getConnection(function(err, connection){
        if(err) callback(err);
        else    callback(null, connection);
      });
    },
    function(connection, callback){

      connection.query( query, [params.id], function(err, rows){
        if(err) callback(err);
        else    callback(null, rows[0]);
        connection.release();
      });
    }
    ], function(err, row){
      if(err) finalCallback(err, null);
      else    finalCallback(err, row);
    });
};

// Get card by Id Order by UpdatedDate
Card.getUserCard - function(params, finalCallback) {
  var query = "SELECT * FROM card WHERE userId = ? ORDER BY updatedDate";

  async.waterfall([
    function(callback){

      pool.getConnection(function(err, connection){
        if(err) callback(err);
        else    callback(null, connection);
      });
    },
    function(connection, callback){

      connection.query( query, [params.id], function(err, rows){    // params.id 가 유저의 id
        if(err) callback(err);
        else    callback(null, rows[0]);
        connection.release();
      });
    }
    ], function(err, row){
      if(err) finalCallback(err, null);
      else    finalCallback(err, row);
    });
};


// Create new card
Card.create = function(params, finalCallback) {
  var error = this.validate(params);
  if (error) {
    return finalCallback(error);
  }
  async.waterfall([
    function(callback) {
      var query = "INSERT INTO card (img, source, font, fontSize, brightness, content, userId, cardTypeId) VALUES (?,?,?,?,?,?,?,?);";
      var insertItem = [
        params.img,
        params.source,
        params.font,
        params.fontSize,
        params.brightness,
        params.content,
        params.userId,
        params.cardTypeId
      ];
      pool.query(query, insertItem, function(err, result) {
        callback(err, result);
      });
    },
    function(result, callback) {
      var insertId = result.insertId;
      var query = "SELECT * FROM card WHERE id = ?;";
      pool.query(query, [insertId], function(err, rows) {
        callback(err, rows[0]);
      });
    }
  ], function (err, result) {
    finalCallback(err, result);
  });
};

// Delete card
Card.deleteById = function(params, finalCallback) {
  var query = "DELETE from card where id=? AND userId=?";
  pool.query(query, [params.id, params.userId], function(err, result) {
    finalCallback(err, result);
  });
};

module.exports = Card;
