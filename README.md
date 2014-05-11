## maps.robertomurray.co.uk

Minisite of projects displaying data on maps. Displaying geolocated data using various mapping technologies.

[http://maps.robertomurray.co.uk](http://maps.robertomurray.co.uk).

## Dev environment 

`bundle install`

## New post aka map

Each map is a post with the Jekyll config mapping the URL to /map-title/

The date is hidden but still should reflect creation date.

## Build instructions

Can be run locally with Jekyll:

`jekyll serve -w`

Or built:

`jekyll build`

Change _config.yml **prod** param to false to turn off stuff like Google Analytics

## Deployment

Configuration file s3_website.yml points to S3 bucket and IAM user.

Rake tasks have deployment scripts:

`rake -T`

To deploy interactively:

`rake deploy:go[true]` or `rake deploy:go`

Or deploy headless-ly (Jenkins):

`rake deploy[false]`

### License

This project is available for use under the MIT software license.
See LICENSE
