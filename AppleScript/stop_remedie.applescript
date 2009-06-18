start()
on start()
	try
		do shell script "ps -ef | grep 'remedie-server.pl' | awk '{print$2}' |  xargs kill -9"
	on error
		beep
	end try
end start
