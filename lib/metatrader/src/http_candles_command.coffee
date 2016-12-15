querystring = require('querystring')

InterfaceCommand = require('./interface_command.js')

module.exports = class HttpCandlesCommand extends InterfaceCommand

  @header: /^[a-zA-Z0-9]+$/
  @schema: ['datetime', 'o', 'h', 'l', 'c']

  symbol: undefined
  timeframe: undefined
  count: undefined

  constructor: (@symbol, @timeframe, @count, @spread = 0) ->

  generateRequest: ->
    if @spread == 1
      return querystring.stringify({ symbol: @symbol.join('-'), timeframe: @timeframe, count: @count, spread: @spread })

    return querystring.stringify({ symbol: @symbol.join('-'), timeframe: @timeframe, count: @count })

  processResponse: (response) ->
    result = {}
    result[@timeframe] = mappingResponse(
      explodeResponse(response.toString()))
    return result

  explodeResponse = (response) =>
    response.split("\r\n")

  mappingResponse = (response) =>
    result = {}
    symbol = ''
    candles = []

    for row, index in response
      if row.search(@header) >= 0
        symbol = row
      else if row.length == 0
        result[symbol] ?= []
        result[symbol].push.apply(result[symbol], candles)
        candles = []
      else 
        candle = {}
        for item, index in row.split(";")
          candle[@schema[index]] = item
        candles.push(candle)

    return result