// Generated by CoffeeScript 1.9.0
(function() {
  var HttpClient, assert, klass, should, sinon;

  assert = require('chai').assert;

  sinon = require('sinon');

  should = require('chai').should();

  HttpClient = require('../../../lib/metatrader').HttpClient;

  klass = require('../../../lib/metatrader').HttpCreator;

  describe('HttpCreator', function() {
    var object;
    object = void 0;
    before(function() {
      return object = new klass();
    });
    describe('createClient', function() {
      var executor;
      executor = sinon.stub();
      before(function() {
        return object.createClient(executor);
      });
      return it('exists method', function() {
        return object.createClient.should.be.a('function');
      });
    });
    return describe('createExecutor', function() {
      var options;
      options = {
        host: sinon.stub(),
        port: sinon.stub()
      };
      before(function() {
        return object.createExecutor(options);
      });
      return it('exists method', function() {
        return object.createExecutor.should.be.a('function');
      });
    });
  });

}).call(this);
