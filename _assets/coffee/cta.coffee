module.exports = class Cta
  constructor: () ->
    @content = document.querySelector '.main'

    @cta = document.querySelector '.cta'

    if @cta?
      @setupExpandToggle()

    if @cta? and @content?
      @setupScrollListener()

  setupExpandToggle: () =>
    button = @cta.querySelector '.cta__button'

    if not button?
      return

    button.addEventListener 'click', () =>
      @cta.classList.toggle 'cta--expanded'
      document.body.classList.toggle 'modal-open'
      window.header.toggleScrolledStatus()

  setupScrollListener: (cta) =>
    window.addEventListener 'scroll', @scrollEvent

  scrollEvent: (evt) =>
    top = (window.innerHeight + @content.clientHeight) / 2

    if window.pageYOffset > top
      window.removeEventListener 'scroll', @scrollEvent
      @cta.classList.remove 'cta--hidden'
