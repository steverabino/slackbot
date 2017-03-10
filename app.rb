require 'sinatra'
require 'httparty'
require 'json'

post '/gateway'  do
  message = params[:text].gsub(parame[:trigger_word], '').strip

  action, repo = message.split('_').map { |c| c.strip.downcase }
  repo_url = "https://api.github.com/repos/#{repo}"

  case action
  when 'issues'
    resp = HTTParty.get(repo_url)
    resp = JSON.parse resp.body
    respond message "There are #{resp['open_issues_count']} open issues on #{repo}"
  end
end

def respond_message
  content_type :json
  {:text => message}.to_json
end