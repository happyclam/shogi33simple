exports.mochaHooks =
  beforeAll: ->
    global.__mochaStart = Date.now()

  afterAll: ->
    duration = Date.now() - global.__mochaStart
    console.log "\nTotal duration: #{(duration/1000).toFixed(2)} sec"
