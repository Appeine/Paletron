Template.welcomeScreenshotItem.onCreated ->
  @imageUrl = new ReactiveVar
  @palette = new ReactiveVar

  Meteor.call 'getZaprKey', (err, zaprKey) =>
    if err
      console.log err
      return

    $.get '/api?zapr_key=' + zaprKey + '&url=' + @data.url, (data) =>
      @imageUrl.set data.sourceUrl
      @palette.set data.palette

Template.welcomeScreenshotItem.helpers
  imageUrl: ->
    Template.instance().imageUrl.get()

  paletteItems: ->
    palette = Template.instance().palette.get()

    if not palette
      return

    items = Object.keys(palette).map (name) ->
      name: name
      rgb: palette[name].rgb.join(',')

    items

Template.welcomeScreenshotItem.events
  'load .welcomeScreenshotItem img': (event) ->
    imageElement = $(event.currentTarget)
    imageElement.addClass 'loaded'