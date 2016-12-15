should = require('chai').should()
klass = new (require('../../../lib/metatrader').InterfaceCommand)

describe 'InterfaceCommand', ->
  it 'implements generateRequest method', ->
    klass.generateRequest.should.be.a 'function'
  it 'implements stopReadCallback method', ->
    klass.stopReadCallback.should.be.a 'function'
  it 'implements processResponse method', ->
    klass.processResponse.should.be.a 'function'