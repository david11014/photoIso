# encoding: utf-8
require 'sinatra'
require 'haml'
require './log.rb'
set :port , 80

get '/' do
	erb :index
end

get '/log' do
	erb :log
end

get '/Cmd' do
	erb :index
end

after '/Cmd' do
	log %( #{Time.now.to_s} [EVENT] Cmd #{params[:cmd]} )
end

get '/setting' do
	erb :index
end

after '/setting' do
	
	log %( #{Time.now.to_s} [EVENT] setting ISO:#{params[:ISO]} GPS:#{params[:GPS]})
end

