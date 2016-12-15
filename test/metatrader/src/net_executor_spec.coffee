net = require('net')
assert = require('chai').assert
sinon = require('sinon')
should = require('chai').should()
klass = require('../../../lib/metatrader').NetExecutor

describe 'NetExecutor', ->

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
    stopReadCallback = sinon.spy()
    callback = sinon.spy()
    error = sinon.spy()
    connection = 
      setTimeout: sinon.spy()
      on: sinon.spy()

    before ->
      sinon.stub(net, 'createConnection', -> connection)
      sinon.stub(object.createConnectionCallback, 'bind', -> object.createConnectionCallback)
      sinon.stub(object.setTimeoutCallback, 'bind', -> object.setTimeoutCallback)
      sinon.stub(object.onCloseCallback, 'bind', -> object.onCloseCallback)
      sinon.stub(object.onErrorCallback, 'bind', -> object.onErrorCallback)
      sinon.stub(object.readConnectionCallback, 'bind', -> object.readConnectionCallback)
      object.execute(request, stopReadCallback, callback, error)

    it 'exists method', ->
      object.execute.should.be.a 'function'
    it 'set this.request is success', -> 
      assert.equal(object.request, request)
    it 'set this.stop_read_callback is success', ->
      assert.equal(object.stop_read_callback, stopReadCallback)
    it 'set this.callback is success', ->
      assert.equal(object.callback, callback)
    it 'set this.error is success', ->
      assert.equal(object.error, error)
    it 'called net.createConnection with port, host and callback', ->
      assert.equal(net.createConnection.calledWith(port, host, object.createConnectionCallback), true)
    it 'called connection.setTimeout with timeout and callback', ->
      assert.equal(connection.setTimeout.calledWith(5000, object.setTimeoutCallback), true)
    it 'called connection.on with close and callback', ->
      assert.equal(connection.on.calledWith('close', object.onCloseCallback), true)
    it 'called connection.on with error and callback', ->
      assert.equal(connection.on.calledWith('error', object.onErrorCallback), true)
    it 'called connection.on with data and callback', ->
      assert.equal(connection.on.calledWith('data', object.readConnectionCallback), true)

  describe '#buildRequest', ->

    it 'exists method', ->
      object.buildRequest.should.be.a 'function'
    it 'returns is valid', ->
      assert.equal(object.buildRequest('request'), "Wrequest\nQUIT\n")

  describe '#closeConnection', ->

    result = sinon.spy()
    connection = 
      destroy: sinon.stub().returns(result)

    before ->
      object.connection = connection
      object.closeConnection()

    it 'exists method', ->
      object.closeConnection.should.be.a 'function'
    it 'returns is valid', -> 
      assert.equal(object.closeConnection(), result)
    it 'called connection.destroy', ->
      assert.equal(connection.destroy.called, true)

  describe '#createConnectionCallback', ->

    request = sinon.spy()
    buildRequest = sinon.spy()
    result = sinon.spy()
    connection = 
      write: sinon.stub().returns(result)

    before ->
      sinon.stub(object, 'buildRequest', -> buildRequest)
      object.connection = connection
      object.request = request
      object.createConnectionCallback()

    it 'exists method', ->
      object.createConnectionCallback.should.be.a 'function'
    it 'returns is valid', ->
      assert.equal(object.createConnectionCallback(), result)
    it 'called this.buildRequest with request', ->
      assert.equal(object.buildRequest.calledWith(request), true)
    it 'called connection.write with buildRequest', ->
      assert.equal(connection.write.calledWith(buildRequest), true)

  describe '#setTimeoutCallback', ->

    before ->
      object.error = sinon.spy()
      object.setTimeoutCallback()

    it 'exists method', ->
      object.setTimeoutCallback.should.be.a 'function'
    it 'called this.error with error', ->
      assert.equal(object.error.calledWith('Connection timeout!'), true)

  describe '#onCloseCallback', ->

    buffer = sinon.spy()

    it 'exists method', ->
      object.onCloseCallback.should.be.a 'function'

    describe 'if this.stop_read_callback returns false', ->

      before ->
        object.buffer = buffer
        object.error = sinon.stub()
        object.stop_read_callback = sinon.stub().returns(false)
        object.onCloseCallback()

      it 'called this.stop_read_callback with buffer', ->
        assert.equal(object.stop_read_callback.calledWith(buffer), true)
      it 'called this.error with error', ->
        assert.equal(object.error.calledWith('Connection timeout!'), true)

    describe 'if this.stop_read_callback returns true', ->

      before ->
        object.buffer = buffer
        object.error = sinon.stub()
        object.stop_read_callback = sinon.stub().returns(true)
        object.onCloseCallback()

      it 'called this.stop_read_callback with buffer', ->
        assert.equal(object.stop_read_callback.calledWith(buffer), true)
      it 'not called this.error', ->
        assert.equal(object.error.called, false)

  describe '#onErrorCallback', ->

    error = sinon.spy()

    before ->
      object.error = sinon.stub()
      object.onErrorCallback(error)

    it 'exists method', ->
      object.onErrorCallback.should.be.a 'function'
    it 'called this.error with error', ->
      assert.equal(object.error.calledWith(error), true)

  describe '#readConnectionCallback', ->

    data = sinon.spy()
    buffer = sinon.spy()
    new_buffer = sinon.spy()

    before -> 
      object.buffer = buffer
      sinon.stub(Buffer, 'concat', -> new_buffer)
      object.stop_read_callback = sinon.stub()
      object.callback = sinon.stub()
      object.readConnectionCallback(data)

    it 'exists method', ->
      object.readConnectionCallback.should.be.a 'function'
    it 'called Buffer.concat with [buffer, data]', ->
      assert.equal(Buffer.concat.calledWith([buffer, data]), true)
    it 'called this.stop_read_callback with new_buffer', ->
      assert.equal(object.stop_read_callback.calledWith(new_buffer), true)

    describe 'if this.stop_read_callback returns true', ->

      before ->
        object.closeConnection = sinon.stub()
        object.stop_read_callback = sinon.stub().returns(true)
        object.callback = sinon.stub()
        object.readConnectionCallback(data)

      it 'called this.closeConnection', ->
        assert.equal(object.closeConnection.called, true)
      it 'called this.callback with new_buffer', ->
        assert.equal(object.callback.calledWith(new_buffer), true)

    describe 'if this.stop_read_callback returns false', ->

      before ->
        object.closeConnection = sinon.stub()
        object.stop_read_callback = sinon.stub().returns(false)
        object.callback = sinon.stub()
        object.readConnectionCallback(data)

      it 'not called this.closeConnection', ->
        assert.equal(object.closeConnection.called, false)
      it 'not called this.callback with new_buffer', ->
        assert.equal(object.callback.called, false)      

    after ->
      Buffer.concat.restore()
