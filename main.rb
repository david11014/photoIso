# encoding: utf-8
require './photoIso.rb'

instance = PhotoIso.new "PhotoIso main block"
cmd = PhotoIso.new "command line block"
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
		instance.listenChannel while true
	rescue
		retry
	end
}

# check unreadPlurk once on start
begin
	instance.checkUnreadPlurk
rescue
	puts %(#{Time.now.to_s} [ERROR] Checking unread plurk has error: #{$!.to_s})
end

while true
	case gets.chomp
	when "check"
		p cmd.checkUnreadPlurk
	when "get"
		p cmd.getUnreadPlurk
	when "a"
		#ic = Iconv.new("utf-8","big5")
		p cmd.addPlurk(gets.to_s,{ qualifier: ':' })
	when "close"
		exit
	end
end
