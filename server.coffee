metatrader = require('./index.js')
config = require('./config.js')

creator = new metatrader.HttpsCreator()

_loop = ->
  console.log('loop start')
  executor = creator.createExecutor(config)
  client = creator.createClient(executor)
  console.log(client)
  command = new metatrader.TradingSymbolCommand()
  client.send command, (data) =>
    trader_symbol = data
    console.log('Result', data)
  , (error) ->
    console.log('Handler %s', error)
  console.log('loop end')

express = require('express')
app = express()

app.get '/trader_symbol', (req, res) ->
  res.send(JSON.stringify(trader_symbol))

server = app.listen 4000, ->
  host = server.address().address
  port = server.address().port

  console.log('MetaTrader Proxy app listening at http://%s:%s', host, port)

_loop()