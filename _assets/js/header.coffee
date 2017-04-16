module.exports = class Header
  ###*
   * Start your engines!
   *
   * @return {Header}
  ###
  constructor: () ->
    ###*
     * The body element
     *
     * @type {HTMLElement}
    ###
    @body = document.body

    @header = document.querySelector '.main-nav'

    @logo     = document.querySelector '.main-nav__logo'
    @menuLink = document.querySelector '.main-nav__menu'

    @contactLink    = document.querySelector '.main-nav__contact'
    @contactSection = document.querySelector '#contact'

    @backToTopLink = document.querySelector '.contact__back-to-top'

    @registerOnScrollListeners()
    @registerMenuListener()
    @registerBackToTopListener()

  registerBackToTopListener: () =>
    @backToTopLink.addEventListener 'click', (evt) =>
      evt = evt or window.event
      evt.preventDefault()

      @scrollToPosition 0

  scrollToPosition: (to, duration = 300) ->
    from = window.pageYOffset
    diff = to - from
    start = null

    # Bootstrap our animation - it will get called right before
    # the next frame is rendered.
    step = (timestamp) ->
      start ?= timestamp

      # Elapsed miliseconds since start of scrolling.
      time = timestamp - start

      # Get percent of completion in range [0, 1].
      percent = Math.min (time / duration), 1

      window.scrollTo 0, (from + diff * percent)

      # Proceed with animation as long as we wanted it to.
      if time < duration
        window.requestAnimationFrame step

    window.requestAnimationFrame step

  registerMenuListener: () =>
    @menuLink.addEventListener 'click', (evt) =>
      evt = evt or window.event
      evt.preventDefault()

      if @body.classList.contains 'menu-open'
        @body.classList.remove 'menu-open'
        @toggleScrolledStatus()
      else
        @body.classList.add 'menu-open'
        @toggleScrolledStatus()

  registerOnScrollListeners: () =>
    window.addEventListener 'scroll', @toggleScrolledStatus

  toggleScrolledStatus: () =>
    if window.pageYOffset > 140 or @body.classList.contains 'menu-open'
      @header.style.backgroundColor = null
      @header.style.paddingBottom   = null
      @header.style.paddingTop      = null
      @logo.style.height            = null
      @body.classList.add 'scrolled'
      return

    @body.classList.remove 'scrolled'
    base = parseInt window.getComputedStyle(document.body).fontSize.replace('px', '')
    percentage = window.pageYOffset / 140

    # alpha = percentage
    # @header.style.backgroundColor = "rgba(255, 255, 255, #{alpha})"

    heightUnit = 4.5 * base
    minHeight = 1
    maxHeight = 2

    height = maxHeight - percentage
    if height < minHeight
      height = minHeight

    @logo.style.height = "#{height * heightUnit}px"

    paddingUnit = 1.5 * base
    minPadding = 0
    maxPadding = 1

    padding = maxPadding - percentage
    if padding < minPadding
      padding = minPadding

    @header.style.paddingTop = "#{padding * paddingUnit}px"
    @header.style.paddingBottom = "#{padding * paddingUnit}px"
