Router.configure
  layoutTemplate: 'default'

Router.route '/', ->
  @render 'welcome'
,
  title: 'Paletron'
  subtitle: 'Create beautiful palettes from websites and images through Zapr.'

Router.route '/dashboard/keys', ->
  this.subscribe('keys').wait()  ;

  if this.ready()
    @render 'keys'
  else
    @render 'loading'
,
  name: 'dashboard.keys'
  title: 'Keys'

Router.route '/dashboard/usage', ->
  @render 'usage'
,
  name: 'dashboard.usage'
  title: 'Usage'