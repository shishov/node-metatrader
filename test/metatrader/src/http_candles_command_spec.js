// Generated by CoffeeScript 1.9.0
(function() {
  var assert, klass, should;

  assert = require('chai').assert;

  should = require('chai').should();

  klass = require('../../../lib/metatrader').HttpCandlesCommand;

  describe('HttpCandlesCommand', function() {
    var object;
    object = void 0;
    beforeEach(function() {
      return object = new klass(['EURCHF', 'EURUSD'], '1440', '100');
    });
    describe('#constructor', function() {
      it('exists method', function() {
        return object.constructor.should.be.a('function');
      });
      it('set this.symbol is success', function() {
        return assert.deepEqual(object.symbol, ['EURCHF', 'EURUSD']);
      });
      it('set this.timeframe is success', function() {
        return assert.equal(object.timeframe, '1440');
      });
      return it('set this.count is success', function() {
        return assert.equal(object.count, '100');
      });
    });
    describe('#generateRequest', function() {
      it('exists method', function() {
        return object.generateRequest.should.be.a('function');
      });
      return it('returns is valid', function() {
        return assert.equal(object.generateRequest(), 'symbol=EURCHF-EURUSD&timeframe=1440&count=100');
      });
    });
    return describe('#processResponse', function() {
      var response, result;
      response = "EURCHF\r\n" + "05.08.2014 00:00:00;1.21684;1.21755;1.21576;1.21578\r\n" + "06.08.2014 00:00:00;1.21578;1.21604;1.21387;1.21458\r\n" + "\r\n" + "EURUSD\r\n" + "05.07.2014 00:00:00;1.21684;1.21755;1.21576;1.21578\r\n" + "06.07.2014 00:00:00;1.21578;1.21604;1.21387;1.21458\r\n";
      result = {
        '1440': {
          EURCHF: [
            {
              c: "1.21578",
              datetime: "05.08.2014 00:00:00",
              h: "1.21755",
              l: "1.21576",
              o: "1.21684"
            }, {
              c: "1.21458",
              datetime: "06.08.2014 00:00:00",
              h: "1.21604",
              l: "1.21387",
              o: "1.21578"
            }
          ],
          EURUSD: [
            {
              c: "1.21578",
              datetime: "05.07.2014 00:00:00",
              h: "1.21755",
              l: "1.21576",
              o: "1.21684"
            }, {
              c: "1.21458",
              datetime: "06.07.2014 00:00:00",
              h: "1.21604",
              l: "1.21387",
              o: "1.21578"
            }
          ]
        }
      };
      it('exists method', function() {
        return object.processResponse.should.be.a('function');
      });
      return it('returns is valid', function() {
        return assert.deepEqual(object.processResponse(response), result);
      });
    });
  });

}).call(this);
