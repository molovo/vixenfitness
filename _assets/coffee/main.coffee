Cta               = require './cta.coffee'
Header            = require './header.coffee'
StripeIntegration = require './stripe-integration.coffee'

if not ('matches' in Element.prototype)
  ###*
    * Polyfill for element.matches to provide IE support
    *
    * @param {HTMLElement} el
    * @param {string}      selector
  ###
  Element.prototype.matches = (el, selector) ->
    fn = el.matches or el.matchesSelector or el.msMatchesSelector or el.mozMatchesSelector or el.webkitMatchesSelector or el.oMatchesSelector

    fn.call el, selector

if not ('closest' in Element.prototype)
  ###*
    * Polyfill for element.closest to provide IE support
    *
    * @param {HTMLElement} el
    * @param {string}      selector
    * @param {string}      stopSelector
  ###
  Element.prototype.closest = (el, selector, stopSelector) ->
    while el
      if matches el, selector
        return el

      if stopSelector and matches el, stopSelector
        return

      el = el.parentElement

###*
 * Where it all begins
###
window.header = new Header
window.stripe = new StripeIntegration
window.cta    = new Cta
