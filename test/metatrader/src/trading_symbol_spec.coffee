assert = require('chai').assert
sinon = require('sinon')
should = require('chai').should()
klass = require('../../../lib/metatrader').TradingSymbolCommand

describe 'TradingSymbolCommand', ->

  object = undefined

  before ->
    object = new klass()

  describe '#constructor', ->
    it 'exists method', ->
      object.constructor.should.be.a 'function'

  describe '#generateRequest', ->
    it 'exists method', ->
      object.generateRequest.should.be.a 'function'

  describe '#processResponse', ->
    response =
      ""
    result = { }

    it 'exists method', ->
      object.processResponse.should.be.a 'function'
    it 'returns is valid', ->
      assert.deepEqual(object.processResponse(response), result)
