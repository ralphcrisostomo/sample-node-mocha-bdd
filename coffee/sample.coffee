'use strict'

# --------------------
# Require
# --------------------
__Q = require 'q'
_   = require 'underscore'

module.exports = class Sample

  constructor: ->
    @name = 'Sample'

  method: ->

    'execute'

  save: (callback) ->
    setTimeout ->
      callback() if callback
    , 100

  promise: (bool = true) ->
    deferred = __Q.defer()

    setTimeout ->
      if bool
        deferred.resolve('done')
      else
        deferred.reject new Error 'error'
    , 100

    deferred.promise


  one: (callback) ->

    deferred = __Q.defer()

    deferred.resolve callback

    deferred.promise


  two: (callback) ->

    deferred = __Q.defer()

    deferred.resolve callback

    deferred.promise

  three: (callback) ->

    deferred = __Q.defer()

    deferred.resolve callback

    deferred.promise

  all: (callback) ->
    @one(callback)
    .then _.bind(@two, @)
    .then _.bind(@three, @)
    .then _.bind(@_complete , @), _.bind(@_error, @)

  delay: (a, b, c, callback) ->
    setTimeout ->
      callback(100, {})
    , 500


  mock: () ->

    deferred = __Q.defer()

    @delay null, null, null, (num, response) ->
      deferred.resolve
        num: num
        obj: response


    deferred.promise

  _complete: (callback) ->
    callback() if callback
    console.log 'callback: ============'


  _error: ->
    console.log '_error'


