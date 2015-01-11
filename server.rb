# encoding: utf-8
require 'sinatra'
require 'sinatra/base'
require './setting.rb'
require './log.rb'

 class Server < Sinatra::Base
	attr_reader :setting
	attr_writer :setting
	set :port , 80
	@filename = ENV["SETTING_FILE"] || "setting.db"

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
	
		@setting = Setting.new
		
		@setting["size"] =          params.key?("size") ?  true : false
		@setting["model"] =         params.key?("model") ?  true : false
		@setting["time"] =          params.key?("time") ?  true : false
		@setting["exposure_time"] = params.key?("exposure_time") ?  true : false
		@setting["white_balance"] = params.key?("white_balance") ?  true : false
		@setting["f_number"] =      params.key?("f_number") ?  true : false
		@setting["ISO"] =           params.key?("ISO") ?  true : false
		@setting["GPS"] =           params.key?("GPS") ?  true : false
		@setting["focal_length"] =  params.key?("focal_length") ?  true : false
		@setting.write!
		p @setting.size
		s = "#{Time.now.to_s} [EVENT] setting from web interface\n"
		s += "key = {set value} {receive value}\n"
		s += "size= #{@setting.size}  #{@params["size"]}\n"
		s += "model= #{@setting.model}  #{@params["model"]}\n"
		s += "time = #{@setting.time}  #{@params["time"]}\n"
		s += "exposure_time = #{@setting.exposure_time}  #{@params["exposure_time"]}\n"
		s += "white_balance =#{@setting.white_balance}  #{@params["white_balance"]}\n"
		s += "f_number =#{@setting.f_number}  #{@params["f_number"]}\n"
		s += "ISO =#{@setting.ISO}  #{@params["ISO"]}\n"
		s += "GPS =#{@setting.GPS}  #{@params["GPS"]}\n"
		s += "focal_length =#{@setting.focal_length}  #{@params["focal_length"]}\n"
		
		log s
		
		erb :index 
	end

private
	def tr(t)
		if t == "true"
			return true
		else
			return false
		end
	end

	
end

