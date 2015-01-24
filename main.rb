# encoding: utf-8
require './photoIso.rb'
require './server.rb'
require './log.rb'
require './setting.rb'
require 'thread'

instance = PhotoIso.new "PhotoIso main block"
setting = Setting.new
# server
st = Thread.new { 
	
	if setting.server == "true"
		begin
                	log %(#{Time.now.to_s} [EVENT] Start server)
	                s = Server.run!
	        rescue
       	 	        log %(#{Time.now.to_s} [ERROR] Start server some error: #{$!.to_s} \nretry it...)
       	         	sleep 10
	                retry
       	 	end
	end
}

#listen channel
Thread.new {
	begin
		log %(#{Time.now.to_s} [EVENT] Start listen channel)
		instance.listenChannel while true
	rescue
		log %(#{Time.now.to_s} [ERROR] listen channel has some error: #{$!.to_s} \nretry it...)
		retry
	end
}

#friend watch
Thread.new {
	addAllAsFriends
	sleep 15
}

# check unreadPlurk once on start
#begin
#	p instance.checkUnreadPlurk
#rescue
#	log %(#{Time.now.to_s} [ERROR] Checking unread plurk has error: #{$!.to_s})
#	sleep(10)
#	retry
#end

while true
	case gets.chomp
	when "check"
		p instance.checkUnreadPlurk
		p instance.addAllAsFriends
	when "get"
		p instance.getUnreadPlurk
	when "a"
		#ic = Iconv.new("utf-8","big5")
		p instance.addPlurk(gets.to_s,{ qualifier: ':' })
	when "set"
		puts "please entry the key"
		key = gets.chomp
		puts "please entry the value"
		value = gets.chomp
		setting.set(key,value)
		setting.write!
		setting.read
	when "set -l"
		setting.list
	when "close"
		log %(#{Time.now.to_s} [EVENT] Close robot)
		exit
	end
end
