require 'thread_safe'
require 'json'
require 'sinatra/base'
require 'erubis'
require 'time'

DB = ThreadSafe::Hash.new

class App < Sinatra::Base
  get '/' do
    @db = DB

    erb :index
  end

  post '/github' do
    DB[Time.now.to_f] = JSON.parse(request.body.read)

    "OK\n"
  end
end
