# --------------------
# Require
# --------------------
Sample          = require '../coffee/sample.coffee'
chai            = require 'chai'
chaiAsPromised  = require 'chai-as-promised'
sinon           = require 'sinon'
fs              = require 'fs'
sinonPromise    = require 'sinon-promise'



# ----------
# Setup
# ----------
chai.use(chaiAsPromised)
expect = chai.expect
sinonPromise(sinon)


# ----------
# Async
# ----------
describe 'Sinon', ->
  describe 'Sample', ->
    beforeEach ->
      @sample = new Sample()

    afterEach ->
      @sample = null

    describe '#delay()', ->
      it 'should exist', ->
        expect(@sample.delay).to.be.a('function')

    describe '#one()', ->
      it 'should exist', ->
        expect(@sample.one).to.be.a('function')

    describe '#two()', ->
      it 'should exist', ->
        expect(@sample.two).to.be.a('function')

    describe '#three()', ->
      it 'should exist', ->
        expect(@sample.three).to.be.a('function')

    describe '#all()', ->
      beforeEach ->
        sinon.spy(@sample, 'one')
        sinon.spy(@sample, 'two')
        sinon.spy(@sample, 'three')
        sinon.spy(@sample, '_complete')
        sinon.spy(@sample, '_error')

        # ----------
        # This is very important
        # ----------
        sinon.stub(process, 'nextTick').yields();



      afterEach ->
        @sample.one.restore()
#        @sample.two.restore()
        @sample.three.restore()
        @sample._complete.restore()
        @sample._error.restore()

        process.nextTick.restore();

      it 'should exist', ->
        expect(@sample.all).to.be.a('function')


      it 'should call #one(), #two() and #three()', ->

        callback = sinon.spy()

        # ----------
        # Add sinon spy
        # ----------
#        @sample.one       = sinon.spy()
        @sample.two       = sinon.spy(callback)
#        @sample.three     = sinon.spy()
#        @sample._complete = sinon.spy()
#        @sample._error    = sinon.spy()



        # ----------
        # Action
        # ----------
        @sample.all(callback)

        # ----------
        # Test
        # ----------
        expect(callback.callCount).to.equal(1)
        expect(@sample.one.callCount).to.equal(1)
        expect(@sample.two.callCount).to.equal(1)
        expect(@sample.three.callCount).to.equal(1)
        expect(@sample._complete.callCount).to.equal(1)
        expect(@sample._error.callCount).to.equal(0)

    describe '#complete', ->
      it 'should exist', ->
        expect(@sample._complete).to.be.a('function')

    describe '#mock()', ->
      it 'should exist', ->
        expect(@sample.mock).to.be.a('function')


      it 'should return async data', ->

        # ----------
        # Fixtures
        # ----------
        sample_fixtures = require './fixtures/sample.json'

        # ----------
        # Mock - fake the return response of a callback
        # index - index position of the callback
        #
        # stub.callsArgOnWith(index, context, arg1, arg2, ...);
        # Like above but with an additional parameter to pass the this context.
        #
        # Same as this:
        #  @sample.delay = (a, b, c, callback) ->
        #  callback(500, sample_fixtures)
        # ----------
        @sample.delay = sinon.mock().callsArgWith(3, 500, sample_fixtures).once()


        # ----------
        # Test
        # ----------
        expect(@sample.mock()).to.eventually.deep.equal
          num: 500
          obj: sample_fixtures
