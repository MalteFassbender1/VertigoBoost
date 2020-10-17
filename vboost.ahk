#NoEnv  
#include FindClick.ahk
#SingleInstance force
SetTitleMatchMode, 2

t1 = ahk_class Sandbox:Box1:Valve001
t2 = ahk_class Sandbox:Box2:Valve001
t3 = ahk_class Sandbox:Box3:Valve001
t4 = ahk_class Sandbox:Box4:Valve001
t5 = ahk_class Sandbox:Box5:Valve001
t6 = ahk_class Sandbox:Box6:Valve001
t7 = ahk_class Sandbox:Box7:Valve001
t8 = ahk_class Sandbox:Box8:Valve001
t9 = ahk_class Sandbox:Box9:Valve001
t10 = ahk_class Sandbox:Box10:Valve001

MsgBox, 4,, Would you like the autosetup to login?

IfMsgBox Yes
	{
		MsgBox, 0,,Setting up accounts  ,1
		Setup()
	}
else
	MsgBox, 0,, If you are done starting the accounts manually please press ok
	
	CheckOkpress:
		IfMsgBox, OK
		{
			if (CheckAccountStatus())
				Boosting()
			else
				MsgBox Something went wrong in accountCheck
		}
		
		else
			goto, CheckOkpress									
   
			
	




Setup()
{
	Run, StartWingman.bat
	Sleep, 80000
	check:
		Sleep, 10000
		
		if (CheckAccountStatus() = 4)
		{
			Boosting()
		}	
		
		else
		{
			Goto, check
		}
}

SetupMM()
{
	checkmm:
		Run, Startmm.bat
		Sleep, 200000
		
		if (CheckAccountStatus() = 10)
		{
			Boosting()
		}	
		
		else
		{
			Goto, checkmm
		}
}



CheckAccountStatus()
{									
	CountWindow = 0

	if WinExist("ahk_class Sandbox:Box1:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box2:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box3:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box4:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box5:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box6:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box7:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box8:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box9:Valve001")
		CountWindow++
	if WinExist("ahk_class Sandbox:Box10:Valve001")
		CountWindow++

	return CountWindow
}






Boosting()
{
	MsgBox, 0,, Please select the maps you want to q and then press ok
	
	pressedOK:
		IfMsgBox, OK
			QueGame()
		
		else
			goto, pressedOK
}




QueGame() 
{
	PressGo:
		go = 0
		go += % FindClick("START.png", "o68 n2 Silent Count")
		
		if(go > 1)
		goto, errorCheck

		else	
		goto, PressGo
	
	errorCheck:
		if (CheckForAccept() > 3)
		{
			sleep, 24000
			Ingame()
			
		}
		else
			Goto, errorCheck
}


Ingame() 
{
	BuyMenuCheck:
	WinActivate, %t1%
	Sleep, 1000
	Send b
	Sleep, 100


	ingameIcon = 0
	ingameIcon += % FindClick("Cticon.png", "o50 n Silent Count")
	ingameIcon += % FindClick("Ticon.png", "o50 n Silent Count")
	if(ingameIcon > 0)
	{
	 Send 4
	 Sleep, 100
	 WinGetPos, X, Y, Width, Height, %t1%
	 DllCall("SetCursorPos", "int", 178, "int", 166)
	 Redcheck:
		redmoney = 0
		redmoney += % FindClick("redmoney.png", "o50 n Silent Count")
		if(redmoney > 0)
		DcScript()
		
		else
		goto, Redcheck
	}
	else
	goto, BuyMenuCheck

}

DcScript()
{
	i = 0
	
	dcAcc:
	if(i > 8)
	{
		Sleep 2000
		QueGame()
	}
	else
	{
		Sleep, 10100
		WinActivate, %t1%
		Send M
		Sleep 10
		WinActivate, %t2%
		Send M
		Sleep 10
		WinActivate, %t3%
		Send M
		Sleep 10
		WinActivate, %t4%
		Send M
		Sleep 10
		WinActivate, %t5%
		Send M
		Sleep 2000
		i = i +1
		if(i > 8)
		QueGame()
		else
		{
			reconnect()
			Sleep 11000
			i = i +1
		}
		goto, dcAcc
	}
}





;////////////////////////////////////////////////////////
;////////////////////GLOBAL FUNCTIONS////////////////////
;////////////////////////////////////////////////////////


CheckForAccept()
{
	halt_on_accept = 0
	halt_on_accept += % FindClick("ACCEPT1.png", "o68 n Silent Count")
	halt_on_accept += % FindClick("ACCEPT2.png", "o68 n Silent Count")
	halt_on_accept += % FindClick("ACCEPT3.png", "o68 n Silent Count")
	halt_on_accept += % FindClick("ACCEPT4.png", "o68 n Silent Count")
	halt_on_accept += % FindClick("accepted_accept.png", "o68 n Silent Count")
	halt_on_accept += % FindClick("loading_screen.png", "o68 n Silent Count")
	
	if not ErrorLevel
	FileRead, Contents, C:\steam\csgo\log1.txt
	IfInString, Contents, match_id
	{
		StringGetPos, foundpos, Contents, match_id
		NewStr := SubStr(Contents, foundpos + 10, 19)
		MatchID1 := %NewStr%
	}
	else
	{
		MsgBox, didn't find matchID1
		return 0
	}
	
	FileRead, Contents, C:\steam\csgo\log2.txt
	IfInString, Contents, match_id
	{
		StringGetPos, foundpos, Contents, match_id
		NewStr := SubStr(Contents, foundpos + 10, 19)
		MatchID2 := %NewStr%
	}
	else
	{
		MsgBox, didn't find matchID2
		return 0
	}
	if(matchID1 == matchID2)
	{
		CoordMode, Mouse, Relative	
		return halt_on_accept
	}
}

Fix_FilePAK() 
{
	FindClick("C:\Users\acale\Desktop\bla\FindClick\confirm_tekstury.png", "o9 n4 e Silent") 
	CoordMode, Mouse, Relative	
}


reconnect()
{
	Loop, 9
	{
		FindClick("reconnect1.png", "o72 n4 e")
		FindClick("reconnect2.png", "o72 n4 e")
		Sleep, 999
	}
	CoordMode, Mouse, Relative
}




