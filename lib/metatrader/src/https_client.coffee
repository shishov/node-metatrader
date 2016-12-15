InterfaceClient = require('./interface_client.js')

class HttpsClient extends InterfaceClient

  constructor: (@executor) ->

  send: (@command, @callback, @error) ->
    request = @command.generateRequest()
    @executor.execute(request, @success, @error)

  success: (response) =>
    @callback(@command.processResponse(response))

module.exports = HttpsClient