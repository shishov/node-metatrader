http = require('http')
assert = require('chai').assert
sinon = require('sinon')
should = require('chai').should()
klass = require('../../../lib/metatrader').HttpExecutor

describe 'HttpExecutor', ->

  object = undefined
  host = sinon.spy()
  port = sinon.spy()

  before ->
    object = new klass(host, port)

  describe '#constructor', ->
    it 'exists method', ->
      object.constructor.should.be.a 'function'
    it 'set this.host is success', ->
      assert.equal(object.host, host)
    it 'set this.port is success', ->
      assert.equal(object.port, port)

  describe '#execute', ->

    request = sinon.spy()
    callback = sinon.spy()
    error = sinon.spy()
    options = sinon.spy()
    req = 
      on: sinon.spy()
      setTimeout: sinon.spy()

    before ->
      sinon.stub(http, 'get', -> req)
      sinon.stub(object.createConnectionCallback, 'bind', -> object.createConnectionCallback)
      sinon.stub(object.setTimeoutCallback, 'bind', -> object.setTimeoutCallback)
      sinon.stub(object.closeConnectionCallback, 'bind', -> object.closeConnectionCallback)
      sinon.stub(object.errorConnectionCallback, 'bind', -> object.errorConnectionCallback)
      sinon.stub(object.readConnectionCallback, 'bind', -> object.readConnectionCallback)
      sinon.stub(object, 'options', -> options)
      object.execute(request, callback, error)

    it 'exists method', ->
      object.execute.should.be.a 'function'
    it 'set this.request is success', -> 
      assert.equal(object.request, request)
    it 'set this.callback is success', ->
      assert.equal(object.callback, callback)
    it 'set this.error is success', ->
      assert.equal(object.error, error)
    it 'called this.options', ->
      assert.equal(object.options.called, true)
    it 'called this.createConnectionCallback.bind with this', ->
      assert.equal(object.createConnectionCallback.bind.calledWith(object), true)
    it 'called http.get with options and callbacks', ->
      assert.equal(http.get.calledWith(options, object.createConnectionCallback, error), true)
    it 'called this.closeConnectionCallback.bind with this', ->
      assert.equal(object.closeConnectionCallback.bind.calledWith(object), true)
    it 'called req.on with error and callback', ->
      assert.equal(req.on.calledWith('close', object.closeConnectionCallback), true)
    it 'called this.errorConnectionCallback.bind with this', ->
      assert.equal(object.errorConnectionCallback.bind.calledWith(object), true)
    it 'called req.on with error and callback', ->
      assert.equal(req.on.calledWith('error', object.errorConnectionCallback), true)
    it 'called this.setTimeoutCallback.bind with this', ->
      assert.equal(object.setTimeoutCallback.bind.calledWith(object), true)
    it 'called req.setTimeout with timeout and callback', ->
      assert.equal(req.setTimeout.calledWith(5000, object.setTimeoutCallback), true)

    after ->
      object.options.restore()
      object.readConnectionCallback.bind.restore()

  describe '#options', ->

    it 'returns is object', ->
      object.options().should.be.a 'object'

  describe '#closeConnectionCallback', ->

    describe 'if error connect', ->
      
      before ->
        object.res = undefined
        object.error = sinon.spy()
        object.closeConnectionCallback()

      it 'called object.error', ->
        assert.ok(object.error.calledWith('Error connection'))

  describe '#errorConnectionCallback', ->

  describe '#createConnectionCallback', ->

    readConnectionCallback = sinon.spy()
    res = 
      on: sinon.stub()

    before ->
      sinon.stub(object.readConnectionCallback, 'bind', -> readConnectionCallback)
      object.createConnectionCallback(res)

    it 'exists method', ->
      object.createConnectionCallback.should.be.a 'function'
    it 'set this.res is success', ->
      assert.equal(object.res, res)
    it 'called this.readConnectionCallback.bind with object', ->
      assert.equal(object.readConnectionCallback.bind.calledWith(object), true)
    it 'called res.on with data and readConnectionCallback', ->
      assert.equal(res.on.calledWith('data', readConnectionCallback), true)

    after ->
      object.readConnectionCallback.bind.restore()

  describe '#readConnectionCallback', ->

    describe 'if done is true', ->

      data = new Buffer(1)
      res = 
        headers: 
          'content-length': 1
      buffer = sinon.spy()
      new_buffer = new Buffer(1)

      before ->
        object.closeConnection = sinon.stub()
        object.res = res
        object.buffer = buffer
        object.callback = sinon.stub()
        sinon.stub(Buffer, 'concat', -> new_buffer)
        object.readConnectionCallback(data)

      it 'exists method', ->
        object.readConnectionCallback.should.be.a 'function'
      it 'called Buffer.concat with [buffer, data]', ->
        assert.equal(Buffer.concat.calledWith([buffer, data]), true)
      it 'called this.callback with new_buffer', ->
        assert.equal(object.callback.calledWith(new_buffer), true)
      
      after ->
        Buffer.concat.restore()

    describe 'if done is false', ->

      data = new Buffer(0)
      res = 
        headers: 
          'content-length': 1
      buffer = sinon.spy()
      new_buffer = new Buffer(0)

      before ->
        object.closeConnection = sinon.stub()
        object.res = res
        object.callback = sinon.stub()
        sinon.stub(Buffer, 'concat', -> new_buffer)
        object.readConnectionCallback(data)

      it 'not called this.closeConnection', ->
        assert.equal(object.closeConnection.called, false)
      it 'not called this.callback with new_buffer', ->
        assert.equal(object.callback.called, false)      

      after ->
        Buffer.concat.restore()

  describe '#setTimeoutCallback', ->

    before ->
      object.error = sinon.spy()
      object.setTimeoutCallback()

    it 'exists method', ->
      object.setTimeoutCallback.should.be.a 'function'
    it 'called this.error with error', ->
      assert.equal(object.error.calledWith('Connection timeout!'), true)
