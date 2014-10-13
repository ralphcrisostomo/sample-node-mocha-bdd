# --------------------
# Require
# --------------------
Sample          = require '../coffee/sample.coffee'
chai            = require 'chai'
chaiAsPromised  = require "chai-as-promised"

# ----------
# Setup
# ----------
chai.use(chaiAsPromised)
expect = chai.expect


# ----------
# Async
# ----------
describe 'Async', ->
  describe 'Sample', ->
    beforeEach ->
      @sample = new Sample()

    afterEach ->
      @sample = null

    describe '#save()', ->
      it 'should save', (done) ->
        @sample.save(done)

    describe '#promise()', ->
      it 'should return correct value', ->
        expect(@sample.promise()).to.eventually.equal('done')

      it 'should return resolve when given "true"', ->
        expect(@sample.promise(true)).to.eventually.fulfilled

      it 'should return error when given "false"', ->
        expect(@sample.promise(false)).to.eventually.rejected