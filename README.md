deploy-hooks
============

This is a simple Sinatra app that does interesting things after a Heroku deploy.

[your heroku app] has an HTTP deploy notification configured to post to: `[custom_name].heroku.com/deploy-staging`.
We use this hook to deliver Planbox items.

It works by:

* Looking for Planbox IDs in the git log (which is provided as a parameter to the POST request)
* Finding those stories in Planbox (using the Planbox API with HTTParty)
* Updating those stories to Delivered if they are in the Completed state

You need to set up a 'Deploy Hooks HTTP Post Hook' on your heroku app ( it's free :D )