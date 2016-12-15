InterfaceClient = require('./interface_client.js')

module.exports = class HttpClient extends InterfaceClient

  constructor: (@executor) ->

  send: (@command, @callback, @error) ->
    request = @command.generateRequest()
    @executor.execute request, @success, @error

  success: (response) =>
    @callback(@command.processResponse(response))