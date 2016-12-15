InterfaceCreator = require('./interface_creator.js')
HttpsClient = require('./https_client.js')
HttpsExecutor = require('./https_executor.js')

class HttpsCreator extends InterfaceCreator

  createClient: (executor) ->
    if !executor
      throw new Exception('HttpsCreator method createClient require executor')

    return new HttpsClient(executor)

  createExecutor: (options) ->
    return new HttpsExecutor(options.host, options.port)

module.exports = HttpsCreator