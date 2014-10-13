# --------------------
# Require
# --------------------
Sample   = require '../coffee/sample.coffee'
chai  = require 'chai'

# --------------------
# Setup
# --------------------
expect  = chai.expect
chai.should()



# ----------
# BBD
# ----------
describe 'BDD', ->
  describe 'Sample', ->

    # ----------
    # Should
    # ----------
    describe 'should', ->
      it 'should have a name', ->
        sample = new Sample()
        sample.name.should.equal 'Sample'

    # ----------
    # Expect
    # ----------
    describe 'expect', ->
      beforeEach ->
        @sample = new Sample()

      afterEach ->
        @sample = null

      describe '#name', ->
        it 'should have a value', ->
          expect(@sample.name).to.equal('Sample')

      describe '#method()', ->
        it 'should have exist', ->
          expect(@sample.method).to.be.a('function')
        it 'should return "execute"', ->
          expect(@sample.method()).to.equal('execute')

      describe '#sample()', ->
        it 'should exist', ->
          expect(@sample.save).to.be.a('function')

      describe '#promise()', ->
        it 'should exist', ->
          expect(@sample.promise).to.be.a('function')
