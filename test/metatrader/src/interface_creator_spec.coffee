should = require('chai').should()
klass = new (require('../../../lib/metatrader').InterfaceCreator)

describe 'InterfaceCreator', ->
  it 'implmenets createClient method', ->
    klass.createClient.should.be.a 'function'
  it 'implmenets createExecutor method', ->
    klass.createExecutor.should.be.a 'function'