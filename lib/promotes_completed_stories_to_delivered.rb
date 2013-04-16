require 'httparty'

class PromotesCompletedStoriesToDelivered

	include HTTParty

	PROJECT_ID = your_project_id

  def login
    response = self.class.post("https://www.planbox.com/api/login", { :body => {:email => 'youremail@example.com', :password => 'password'}})
    cookie = HTTParty::CookieHash.new 
    cookie.add_cookies(response.headers["set-cookie"])
    self.class.cookies(cookie)
  end

  def initialize(story_ids)
    @story_ids = story_ids
  end

  def promote_staging
  	login

    @story_ids.each do |story_id|
      promote_story_staging(story_id)
    end
  end

  def promote_production
    login

    @story_ids.each do |story_id|
      promote_story_production(story_id)
    end
  end


  private

  def promote_story_staging(story_id)
    log "Attempting to deliver story ##{story_id}..."

    story = self.class.post('https://www.planbox.com/api/get_story', { :body => { :story_id => story_id}})

    return unless story

    state = story.parsed_response["content"]

    if(state["status"] == "completed")
      log "Story ##{story_id} is finished. Marking it as delivered."
      self.class.post('https://www.planbox.com/api/update_story_status', { :body => { :story_id => story_id, :action => 'deliver' }})
    else
      log "Story ##{story_id} is not finished. Ignoring it."
    end
  end

  def promote_story_production(story_id)
    log "Attempting to release story ##{story_id}..."

    story = self.class.post('https://www.planbox.com/api/get_story', { :body => { :story_id => story_id}})

    return unless story

    log "Story ##{story_id} got deployed to production. Marking it as released."
    self.class.post('https://www.planbox.com/api/update_story_status', { :body => { :story_id => story_id, :action => 'release' }})
  end

  def log(message)
    puts message
  end
end