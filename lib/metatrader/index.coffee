module.exports = MetaTrader = {}

MetaTrader.InterfaceClient = require('./src/interface_client.js')
MetaTrader.InterfaceCreator = require('./src/interface_creator.js')
MetaTrader.InterfaceExecutor = require('./src/interface_executor.js')
MetaTrader.InterfaceCommand = require('./src/interface_command.js')

MetaTrader.NetClient = require('./src/net_client.js')
MetaTrader.NetCreator = require('./src/net_creator.js')
MetaTrader.NetExecutor = require('./src/net_executor.js')

MetaTrader.HttpClient = require('./src/http_client.js')
MetaTrader.HttpCreator = require('./src/http_creator.js')
MetaTrader.HttpExecutor = require('./src/http_executor.js')

MetaTrader.HttpsClient = require('./src/https_client.js')
MetaTrader.HttpsCreator = require('./src/https_creator.js')
MetaTrader.HttpsExecutor = require('./src/https_executor.js')

MetaTrader.QuotesCommand = require('./src/quotes_command.js')
MetaTrader.CandlesCommand = require('./src/candles_command.js')
MetaTrader.HttpCandlesCommand = require('./src/http_candles_command.js')
MetaTrader.TradingSymbolCommand = require('./src/trading_symbol_command.js')