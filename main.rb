# encoding: utf-8
require './photoIso.rb'
require './server.rb'
require './log.rb'

instance = PhotoIso.new "PhotoIso main block"

# Thread.new {
#   while true
#     begin
#       instance.acceptAllFriends
#       sleep 30
#     rescue
#       sleep 10
#       retry
#     end
#   end
# }
Thread.new {
	begin
		log %(#{Time.now.to_s} [EVENT] Start server)
		s = Server.run!
	rescue
		log %(#{Time.now.to_s} [ERROR] Start server some error: #{$!.to_s} \nretry it...)
		sleep 10
		retry
	end
}

Thread.new {
	begin
		log %(#{Time.now.to_s} [EVENT] Start listen channel)
		instance.listenChannel while true
	rescue
		log %(#{Time.now.to_s} [ERROR] listen channel has some error: #{$!.to_s} \nretry it...)
		retry
	end
}

# check unreadPlurk once on start
begin
	instance.checkUnreadPlurk
rescue
	log %(#{Time.now.to_s} [ERROR] Checking unread plurk has error: #{$!.to_s})
end

while true
	case gets.chomp
	when "check"
		p instance.checkUnreadPlurk
	when "get"
		p instance.getUnreadPlurk
	when "a"
		#ic = Iconv.new("utf-8","big5")
		p instance.addPlurk(gets.to_s,{ qualifier: ':' })
	when "close"
		log %(#{Time.now.to_s} [EVENT] Close robot)
		exit
	end
end
