require 'thread_safe'
require 'json'
require 'sinatra/base'
require 'erubis'
require 'time'

DB = ThreadSafe::Hash.new

class App < Sinatra::Base
  helpers do
    def github_event_type
      request.env['HTTP_X_GITHUB_EVENT']
    end
  end

  get '/' do
    @db = DB

    erb :index
  end

  post '/github' do
    DB[Time.now.to_f] = {
      event_type: github_event_type,
      payload: JSON.parse(request.body.read)
    }

    "OK\n"
  end
end
