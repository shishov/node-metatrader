net = require('net')

InterfaceExecutor = require('./interface_executor.js')

module.exports = class NetExecutor extends InterfaceExecutor

  connection: undefined
  host: undefined
  port: undefined
  callback: undefined
  buffer: new Buffer(0)

  constructor: (@host, @port) ->

  execute: (@request, @stop_read_callback, @callback, @error) ->
    try
      if typeof @error != 'function'
        @error = ->
      @connection = net.createConnection @port, @host, @createConnectionCallback.bind(@)
      @connection.setTimeout 5000, @setTimeoutCallback.bind(@)
      @connection.on 'close', @onCloseCallback.bind(@)
      @connection.on 'error', @onErrorCallback.bind(@)
      @connection.on 'data', @readConnectionCallback.bind(@)
    catch e
      @error(e)

  buildRequest: (request) ->
    "W#{request}\nQUIT\n"

  closeConnection: ->
    try
      @connection.destroy()
    catch e
      @error(e)

  createConnectionCallback: =>
    @connection.write(@buildRequest(@request))

  setTimeoutCallback: =>
    @error('Connection timeout!')

  onCloseCallback: =>
    if !@stop_read_callback(@buffer)
      @error('Connection timeout!')

  onErrorCallback: (error) =>
    @error(error)

  readConnectionCallback: (data) =>
    try
      @buffer = Buffer.concat([@buffer, data])
      if @stop_read_callback(@buffer)
        @closeConnection()
        @callback(@buffer)
    catch e
      @error(e)
