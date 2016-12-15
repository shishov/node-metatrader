assert = require('chai').assert
should = require('chai').should()
klass = require('../../../lib/metatrader').CandlesCommand

describe 'CandlesCommand', ->
  object = undefined 

  beforeEach ->
    object = new klass('symbol', 'period', 'from', 'to')

  describe '#constructor', ->
    it 'exists method', ->
      object.constructor.should.be.a 'function'
    it 'set this.symbol is success', ->
      assert.equal(object.symbol, 'symbol')
    it 'set this.period is success', ->
      assert.equal(object.period, 'period')
    it 'set this.from is success', ->
      assert.equal(object.from, 'from')
    it 'set this.to is success', ->
      assert.equal(object.to, 'to')

  describe '#generateRequest', ->
    it 'exists method', ->
      object.generateRequest.should.be.a 'function'
    it 'returns is valid', ->
      assert.equal(object.generateRequest(), 'HISTORYNEW-symbol=symbol|period=period|from=from|to=to')

  describe '#stopReadCallback', ->
    it 'exists method', ->
      object.stopReadCallback.should.be.a 'function'
    it 'returns true if valid buffer', ->
      valid_buffer = new Buffer([
        # Header
        0x01,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        #Body
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00])
      assert.equal(object.stopReadCallback(valid_buffer), true)
    it 'returns false if not valit buffer', ->
      not_valid_buffer = new Buffer([
        #Header
        0x01,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00])
      assert.equal(object.stopReadCallback(not_valid_buffer), false)
    it 'returns false if empty buffer', ->
      empty_buffer = new Buffer([])
      assert.equal(object.stopReadCallback(empty_buffer), false)

  describe '#processResponse', ->
    it 'exists method', ->
      object.processResponse.should.be.a 'function'
    it 'returns result is valid', ->
      response = new Buffer([
        # Header
        0x01,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        #Body
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00])
      assert.deepEqual(object.processResponse(response), [{ bars: 1, digits: 0, timesign: 0 },{ ctm: 0, open: 0, high: 0, low: 0, close: 0, vol: 0 }])
