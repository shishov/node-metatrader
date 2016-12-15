InterfaceCommand = require('./interface_command.js')

class HttpTradingSymbolCommand

  constructor: (@locale = 'ru') ->

  generateRequest: ->
    "/dealing/Analysis/ContractSpecificationsJson?locale=#{@locale}"

  processResponse: (data) ->
    messageObject = undefined

    try 
      messageObject = JSON.parse(data.toString())
    catch e
      console.log e

    return messageObject

module.exports = HttpTradingSymbolCommand