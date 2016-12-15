assert = require('chai').assert
sinon = require('sinon')
should = require('chai').should()
NetClient = require('../../../lib/metatrader').NetClient
klass = require('../../../lib/metatrader').NetCreator

describe 'NetCreator', ->

  object = undefined

  before ->
    object = new klass()

  describe 'createClient', ->

    executor = sinon.stub()

    before ->
      object.createClient(executor)

    it 'exists method', ->
      object.createClient.should.be.a 'function'

  describe 'createExecutor', ->

    options = 
      host: sinon.stub()
      port: sinon.stub()

    before ->
      object.createExecutor(options)

    it 'exists method', ->
      object.createExecutor.should.be.a 'function'