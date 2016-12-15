assert = require('chai').assert
sinon = require('sinon')
should = require('chai').should()
klass = require('../../../lib/metatrader').NetClient

describe 'NetClient', ->
  object = undefined 
  executor = 
    execute: sinon.stub().returns('execute')
  command = 
    generateRequest: sinon.stub().returns('generateRequest')
    stopReadCallback: sinon.stub().returns('stopReadCallback')
    processResponse: sinon.stub().returns('processResponse')

  before ->
    object = new klass(executor)

  describe '#constructor', ->

    it 'exists method', ->
      object.constructor.should.be.a 'function'
    it 'set this.executor is success', ->
      assert.equal(object.executor, executor)

  describe '#send', ->

    callback = sinon.spy()
    error = sinon.spy()

    before ->
      object.send(command, callback, error)

    it 'exists method', ->
      object.send.should.be.a 'function'
    it 'set this.callback is success', ->
      assert.equal(object.callback, callback)
    it 'returns it valid', ->
      assert.equal(object.send(command), 'execute')
    it 'called command.generateRequest', ->
      assert.equal(command.generateRequest.called, true)
    it 'called executor.execute with request and callbacks', ->
      assert.equal(executor.execute.called, true)
      assert.equal(executor.execute.calledWith('generateRequest', command.stopReadCallback, object.success, error), true)

  describe '#success', ->

    response = sinon.stub()

    before ->
      object.callback = sinon.stub()
      object.success(response)

    it 'exists method', ->
      object.success.should.be.a 'function'
    it 'called command.processResponse with response', ->
      assert.equal(command.processResponse.called, true)
      assert.equal(command.processResponse.calledWith(response), true)
      