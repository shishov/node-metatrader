InterfaceCreator = require('./interface_creator.js')
HttpClient = require('./http_client.js')
HttpExecutor = require('./http_executor.js')

module.exports = class HttpCreator extends InterfaceCreator

  createClient: (executor) ->
    if !executor
      throw new Exception('HttpCreator method createClient require executor')

    return new HttpClient(executor)

  createExecutor: (options) ->
    return new HttpExecutor(options.host, options.port)
