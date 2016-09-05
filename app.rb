require 'sinatra'
require 'json'

require './lib/game'
require './lib/player'

set :port, 3100
# set :bind, `ifconfig`.scan(/192\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/).first

configure do
  set :game, Game.new(Player.locate)
end

get '/' do
  erb :index
end

post '/play' do
  @results = settings.game.play
  erb :index, locals: {results: @results}
end

get '/players' do
  settings.game.players.map(&:to_json).to_json
end