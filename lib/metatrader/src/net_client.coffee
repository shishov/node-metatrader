InterfaceClient = require('./interface_client.js')

module.exports = class NetClient extends InterfaceClient

  constructor: (@executor) ->

  send: (@command, @callback, error) ->
    request = @command.generateRequest()
    @executor.execute request, @command.stopReadCallback, @success, error

  success: (response) => 
    @callback(@command.processResponse(response))