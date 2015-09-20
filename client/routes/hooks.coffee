Router.onBeforeAction ->
  Session.set 'pageTitle', this.route.options.title
  Session.set 'pageSubtitle', this.route.options.subtitle
  this.next()

Router.onAfterAction ->
  if ga?
    ga 'send', 'pageview', this.route._path