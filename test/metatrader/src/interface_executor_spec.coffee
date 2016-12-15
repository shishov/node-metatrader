should = require('chai').should()
klass = new (require('../../../lib/metatrader').InterfaceExecutor)

describe 'InterfaceExecutor', ->
  it 'implmenets execute method', ->
    klass.execute.should.be.a 'function'