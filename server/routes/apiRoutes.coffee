Router.route '/api', ->
  # URL is required.
  if not @request.query.url?
    @response.writeHead 400, 'Content-Type': 'text/plain'
    @response.end 'Parameter \'url\' is required'
    return

  if not @request.query.zapr_key?
    @response.writeHead 400, 'Content-Type': 'text/plain'
    @response.end 'Parameter \'zapr_key\' is required'
    return

  zaprUrl = 'http://zapr.appeine.com/api?key=' + @request.query.zapr_key + '&url=' + @request.query.url
  options =
    followRedirects: false
    responseType: 'buffer'

  # Make requests to fetch the image. If 200 is returned the image is included with the initial request, otherwise
  # we'll redirect to the CloudFront URL and fetch it from there.
  # We don't redirect automatically so that we can capture the location header
  HTTP.call 'GET', zaprUrl, options, (err, data) =>
    if err
      @response.writeHead 500
      @response.end 'An internal error occurred'

    imageUrl = data.headers.location

    if data.statusCode == 302
      options =
        responseType: 'buffer'

      HTTP.call 'GET', imageUrl, options, (err, data) =>
        if err
          @response.writeHead 500, {}
          @response.end 'An internal error occurred'

        processImage @response, imageUrl, data.content
    else
      @response.writeHead 500
      @response.end 'An internal error occurred'
,
  where: 'server'

processImage = (response, imageUrl, buffer) =>
  Vibrant = Meteor.npmRequire('node-vibrant')

  v = new Vibrant buffer, {}
  v.getSwatches (err, rawPalette) =>
    palette = {}

    for key,value of rawPalette
      newKey = key.charAt(0).toLowerCase() + key.slice(1)
      palette[newKey] = value

    responseData =
      sourceUrl: imageUrl
      palette: palette

    response.writeHead 200,
      'Content-Type': 'application/json'
    response.end JSON.stringify(responseData)