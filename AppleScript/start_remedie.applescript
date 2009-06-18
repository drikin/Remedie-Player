start()
on start()
	try
		tell application "Finder" to set pwd to POSIX path of (parent of (path to me) as text)
		do shell script "cd '" & pwd & "';/bin/sh ../Core/Resources/script &> /dev/null & echo $!"
	on error
		beep
	end try
end start