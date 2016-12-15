https = require('https')

InterfaceExecutor = require('./interface_executor.js')

class HttpsExecutor extends InterfaceExecutor

  buffer: new Buffer(0)

  constructor: (@host) ->

  execute: (@request, @callback, @error) ->
    try
      if typeof @error != 'function'
        @error = new Function()

      req = https.get(@url(), @createConnectionCallback.bind(@), @error)
      req.on('close', @closeConnectionCallback.bind(@))
      req.on('error', @errorConnectionCallback.bind(@))
      req.setTimeout(5000, @setTimeoutCallback.bind(@))
    catch e
      @error(e)

  url: =>
    return new String(@host) + new String(@request)

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

module.exports = HttpsExecutor