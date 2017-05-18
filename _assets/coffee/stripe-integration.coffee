require('es6-promise').polyfill()
require 'isomorphic-fetch'
Hogan = require 'hogan.js'

module.exports = class StripeIntegration
  ###*
   * Create the StripeIntegration object
   *
   * @return {StripeIntegration}
  ###
  constructor: () ->
    ###*
     * A message template
     *
     * @type {string}
    ###
    @template = Hogan.compile """
      <div class="message message--{{ type }}">
        <div class="message__title"><h4>{{ title }}</h4></div>
        <div class="message__content">{{ content }}</div>
      </div>
    """

    ###*
     * The URL of the micro-service which handles payment
     *
     * @type {string}
    ###
    @url = if window.location.hostname is 'www.vixenfitness.co.uk'
      'https://payment.vixenfitness.co.uk'
    else
      'https://test.payment.vixenfitness.co.uk'

    ###*
     * The Stripe API key to use
     *
     * @type {string}
    ###
    @key = if window.location.hostname is 'www.vixenfitness.co.uk'
      'pk_live_v1Psh79ADxIvUhOzoyM2WfEC'
    else
      'pk_test_fZNtS22aT2X6jad46EVjCLDC'

    ###*
     * The handler which will be used for stripe payments
     *
     * @return {StripeCheckout}
    ###
    @handler = StripeCheckout.configure(
      key: @key
      image: '/img/vixen-icon-plum-bg.png'
      locale: 'auto'
      token: @createCharge
    )

    ###*
     * A HTMLElementCollection containing all the
     * buy buttons on the page
     *
     * @type {HTMLElementCollection}
    ###
    @buyButtons = document.querySelectorAll '.button--buy'

    # Close the checkout form on state changes
    window.addEventListener 'popstate', @handler.close

    # Register listeners
    @registerBuyButtonListeners()

  ###*
   * Register listeners on each of the buy buttons
   * to open the checkout form
  ###
  registerBuyButtonListeners: () =>
    for button in @buyButtons
      do (button) =>
        button.addEventListener 'click', @openCheckoutForm

  ###*
   * Display the checkout form to the user
   *
   * @param  {HTMLEvent} evt The click event
  ###
  openCheckoutForm: (evt) =>
    evt = evt or window.event
    evt.preventDefault()
    button = evt.currentTarget

    @amount = parseInt button.dataset.amount

    # Open the checkout form
    @handler.open(
      name: button.dataset.name
      description: button.dataset.description
      zipCode: false
      currency: 'gbp'
      amount: @amount
    )

  ###*
   * Post a request to the back end to create
   * the Stripe charge
   *
   * @param  {Token} token
  ###
  createCharge: (token) =>
    # Create the request data using the new stripe token
    opts = {
      method: 'POST'
      body: JSON.stringify(
        source: token.id
        amount: @amount
        currency: 'gbp'
        metadata:
          email: token.email
      )
    }

    # Send the request to the payment handler
    fetch @url, opts
      # Decode the JSON response
      .then (response) ->
        response.json()

      #
      .then (response) =>
        if response.error
          return @notify {
            type: 'error'
            title: 'Payment Failed'
            content: response.error
          }

        @notify {
          type: 'success'
          title: 'Payment Successful'
          content: 'Thanks for your payment. We\'ll be in touch soon'
        }
      .catch (response) =>
        return @notify {
          type: 'error'
          title: 'Payment Failed'
          content: response.error
        }

  notify: (opts) =>
    msg = @template.render opts

    div = document.createElement 'div'
    div.innerHTML = msg
    element = div.firstChild

    document.body.appendChild element
