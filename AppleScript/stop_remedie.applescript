start()
on start()
	try
		tell application "Finder" to set pwd to POSIX path of (parent of (path to me) as text)
		set script_path to pwd & "../Core/Resources"
		try
			do shell script "ls '" & script_path & "'/script"
			do shell script "ps -ef | grep 'remedie-server.pl' | awk '{print$2}' |  xargs kill -9"
		end try
	on error
		beep
	end try
end start
