assert = require('chai').assert
metatrader = require('../../lib/metatrader')

describe 'Metatrader', ->
  it 'exists interface InterfaceClient', ->
    assert.typeOf(metatrader.InterfaceClient, 'function')
  it 'exists interface InterfaceCreator', ->
    assert.typeOf(metatrader.InterfaceCreator, 'function')
  it 'exists interface InterfaceExecutor', ->
    assert.typeOf(metatrader.InterfaceExecutor, 'function')
  it 'exists interface InterfaceCommand', ->
    assert.typeOf(metatrader.InterfaceCommand, 'function')
  it 'exists class NetClient', ->
    assert.typeOf(metatrader.NetClient, 'function')
  it 'exists class NetCreator', ->
    assert.typeOf(metatrader.NetCreator, 'function')
  it 'exists class NetExecutor', ->
    assert.typeOf(metatrader.NetExecutor, 'function')
  it 'exists class QuotesCommand', ->
    assert.typeOf(metatrader.QuotesCommand, 'function')
  it 'exists class CandlesCommand', ->
    assert.typeOf(metatrader.CandlesCommand, 'function')