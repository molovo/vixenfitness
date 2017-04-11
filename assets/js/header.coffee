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

    @logo = document.querySelector '.main-nav__logo'

    @registerOnScrollListeners()

  registerOnScrollListeners: () =>
    window.addEventListener 'scroll', @toggleScrolledStatus

  toggleScrolledStatus: () =>
    if window.pageYOffset > 140
      @header.style.backgroundColor = null
      @logo.style.height = null
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
