// Generated by CoffeeScript 1.9.0
(function() {
  var klass, should;

  should = require('chai').should();

  klass = new (require('../../../lib/metatrader').InterfaceExecutor);

  describe('InterfaceExecutor', function() {
    return it('implmenets execute method', function() {
      return klass.execute.should.be.a('function');
    });
  });

}).call(this);
