http = require('http')

InterfaceExecutor = require('./interface_executor.js')

module.exports = class HttpExecutor extends InterfaceExecutor

  buffer: new Buffer(0)

  constructor: (@host, @port) ->

  execute: (@request, @callback, @error) ->
    try
      if typeof @error != 'function'
        @error = ->
        
      req = http.get(@options(), @createConnectionCallback.bind(@), @error)
      req.on('close', @closeConnectionCallback.bind(@))
      req.on('error', @errorConnectionCallback.bind(@))
      req.setTimeout(5000, @setTimeoutCallback.bind(@))
    catch e
      @error(e)

  options: =>
    hostname: @host
    port: @port
    path: "/?#{@request}"

  closeConnectionCallback: =>
    if @res? && @buffer.length >= @res.headers['content-length']
      @callback(@buffer)
    else 
      @error('Error connection')

  errorConnectionCallback: (error) =>
    @error(error)

  createConnectionCallback: (@res) =>
    @res.on('data', @readConnectionCallback.bind(@))

  readConnectionCallback: (data) =>
    @buffer = Buffer.concat([@buffer, data])
    if @buffer.length >= @res.headers['content-length']
      @callback(@buffer)

  setTimeoutCallback: =>
    @error('Connection timeout!')