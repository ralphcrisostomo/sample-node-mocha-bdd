# --------------------
# Require
# --------------------
Sample   = require '../coffee/sample.coffee'
chai  = require 'chai'

# --------------------
# Setup
# --------------------
assert = chai.assert


# ----------
# TDD
# ----------
describe 'TDD', ->
  describe 'Sample', ->
    describe 'assert', ->
      beforeEach ->
        @sample = new Sample()

      it 'should have correct types', ->
        assert.typeOf @sample.name, 'string'
        assert.typeOf @sample.method, 'function'

      it 'should have correct properties', ->
        assert.property @sample, 'name'
        assert.property @sample, 'method'