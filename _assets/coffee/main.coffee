Header = require './header.coffee'
StripeIntegration = require './stripe-integration.coffee'

###*
 * Where it all begins
###
window.addEventListener 'DOMContentLoaded', () ->
  new Header
  new StripeIntegration
