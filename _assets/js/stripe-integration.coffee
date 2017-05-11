module.exports = class StripeIntegration
  constructor: () ->
    ###*
     * The handler which will be used for stripe payments
     *
     * @return {StripeCheckout}
    ###
    @handler = StripeCheckout.configure(
      key: 'pk_test_fZNtS22aT2X6jad46EVjCLDC'
      image: '/img/vixen-icon-plum-bg.png'
      locale: 'auto'
      token: (token) ->
        # You can access the token ID with `token.id`.
        # Get the token ID to your server-side code for use.
    )

    @buyButtons = document.querySelectorAll '.button--buy'

    window.addEventListener 'popstate', @handler.close

    @registerBuyButtonListeners()

  registerBuyButtonListeners: () =>
    for button in @buyButtons
      do (button) =>
        button.addEventListener 'click', @handlePurchase

  handlePurchase: (evt) =>
    evt = evt or window.event
    evt.preventDefault()
    button = evt.currentTarget

    @handler.open(
      name: button.dataset.name
      description: button.dataset.description
      zipCode: false
      currency: 'gbp'
      amount: button.dataset.amount
    )
