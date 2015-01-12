# encoding: utf-8
def log(text)
	
	begin
		puts text
		re = File.open("./log.db","a+")
		re.write(text + "\n" )
		er = File.open("./views/log.erb","a+")
		er.write(text + "</br> \n" )
		re.close
		er.close
	rescue
		puts text
		print "record file has error" + $!.to_s + "\n"
	end
end

