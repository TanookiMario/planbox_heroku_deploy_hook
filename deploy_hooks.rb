require 'sinatra'
require './lib/finds_planbox_ids'
require './lib/promotes_completed_stories_to_delivered'

post '/deploy_staging' do #your heroku deploy hook path
  logger.info "A deploy was pushed to staging."
  logger.info "Git commits:"
  logger.info params[:git_log]

  stories = FindsPlanboxIds.new(params[:git_log]).find
	PromotesCompletedStoriesToDelivered.new(stories).promote_staging

  redirect '/'
end

post '/deploy_production' do # your heroku deploy hook path
  logger.info "A deploy was pushed to production."
  logger.info "Git commits:"
  logger.info params[:git_log]

  stories = FindsPlanboxIds.new(params[:git_log]).find
	PromotesCompletedStoriesToDelivered.new(stories).promote_production

  redirect '/'
end
