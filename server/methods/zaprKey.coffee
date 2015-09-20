Meteor.methods
  'getZaprKey': ->
    if not process.env.ZAPR_API_KEY
      throw new Meteor.Error 'NO_ZAPR_API_KEY', 'No Zapr API key was specified in environment'

    process.env.ZAPR_API_KEY