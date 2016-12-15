assert = require('chai').assert
sinon = require('sinon')
should = require('chai').should()
klass = require('../../../lib/metatrader').QuotesCommand

describe 'QuotesCommand', ->

  object = undefined
  symbols = [1,2,3]

  before -> 
    object = new klass(symbols)

  describe '#constructor', ->
    it 'exists method', ->
      object.constructor.should.be.a 'function'
    it 'set this.symbols is success', ->
      assert.equal(object.symbols, symbols)

  describe '#generateRequest', ->
    it 'exists method', ->
      object.generateRequest.should.be.a 'function'
    it 'returns is valid', ->
      assert.equal(object.generateRequest(), 'QUOTES-1,2,3,')

  describe '#stopReadCallback', ->

    valid_buffer = "2014.01.01 00:00:00"
    not_valid_buffer01 = "2014.01.0100:00:00"
    not_valid_buffer02 = " 2014.01.01 00:00:00"
    not_valid_buffer03 = "2014.01.01 00:00:00 "
    empty_buffer = ""

    it 'returns true when buffer valid', ->
      assert.equal(object.stopReadCallback(valid_buffer), true)
    it 'returns false when buffer not valid', ->
      assert.equal(object.stopReadCallback(not_valid_buffer01), false)
      assert.equal(object.stopReadCallback(not_valid_buffer02), false)
      assert.equal(object.stopReadCallback(not_valid_buffer03), false)
    it 'returns false when buffer is empty', ->
      assert.equal(object.stopReadCallback(empty_buffer), false)

  describe '#processResponse', ->

    it 'exists method', ->
      object.processResponse.should.be.a 'function'
    it 'returns is valid', ->
      response = 
        "direction01 symbol01 bid01 ask01 date01 time01\n" +
        "direction02 symbol02 bid02 ask02 date02 time02\n" + 
        "2014.01.01 00:00:00"
      result = 
        [ { direction: 'direction01', symbol: 'symbol01', bid: 'bid01', ask: 'ask01', date: 'date01', time: 'time01' },
          { direction: 'direction02', symbol: 'symbol02', bid: 'bid02', ask: 'ask02', date: 'date02', time: 'time02' } ]
      assert.deepEqual(object.processResponse(response), result)
