Template.welcome.onCreated ->
  template = @

  template.Urls = new Mongo.Collection(null)
  template.Urls.insert
    url: 'http://aws.amazon.com/'
    created_at: new Date()
  template.Urls.insert
    url: 'http://www.docker.com/'
    created_at: new Date()
  template.Urls.insert
    url: 'https://www.tutum.co/'
    created_at: new Date()

Template.welcome.helpers
  urls: ->
    template = Template.instance()
    template.Urls.find({}, sort: created_at: -1)

Template.welcome.events
  'submit .input-field form': (event) ->
    event.preventDefault()
    template = Template.instance()

    urlField = $('#url');

    template.Urls.insert
      url: urlField.val()
      created_at: new Date()

    urlField.val('')