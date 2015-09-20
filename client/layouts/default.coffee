Template.default.onCreated ->

Template.default.onRendered ->
  @$(".button-collapse").sideNav()

Template.default.helpers
  useAnalytics: ->
    window.location.hostname == 'paletron.appeine.com' and Meteor.settings.public.ga.id