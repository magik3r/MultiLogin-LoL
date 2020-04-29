; Multi-login for LoL - by magik3r 
; VERSION 1.0
; credits to szujeq - "ControlColor" - https://autohotkey.com/board/topic/104539-controlcol-set-background-and-text-color-gui-controls/
; credits to tmplinshi - "CustomFont" - https://gist.github.com/tmplinshi/7717340
; credits to Pizzadude - font "abduction2002" - https://www.dafont.com/abduction-2002.font


#SingleInstance Force
#NoEnv
SetBatchLines -1
SendMode Input
SetWorkingDir %A_ScriptDir% 

#Include Class_CustomFont.ahk
font1 := New CustomFont("abduction2002.ttf")
#Include ControlColor.ahk

global matchesAcc
global matchesPass
global matchesAlias
global accountlist



OnMessage(0x201, "WM_LBUTTONDOWN")
WM_LBUTTONDOWN() 
{

   PostMessage, 0xA1, 2

   return

}



aliasin()

aliasin()
{
  matchesAlias := []
  numMatchesAlias := 0
  FileRead, placeholder, users.txt
  Loop parse, placeholder, `n
    Loop parse, A_LoopField, `,
      if InStr(A_LoopField, "alias")
        matchesAlias[++numMatchesAlias] := trim( substr(A_LoopField, InStr(A_LoopField, ":") + 1), " `t`n`r")
}

aliasout()

aliasout()
{
  for index, element in matchesAlias
  {
accountlist .= matchesAlias[A_index]"|"
  }
}
accountlist .= matchesAlias[A_index]



usrin()

usrin()
{
  matchesAcc := []
  numMatchesAcc := 0
  FileRead, placeholder, users.txt
  Loop parse, placeholder, `n
    Loop parse, A_LoopField, `,
      if InStr(A_LoopField, "usrname")
        matchesAcc[++numMatchesAcc] := trim( substr(A_LoopField, InStr(A_LoopField, ":") + 1), " `t`n`r")
}

usrout()

usrout()
{
  for index, element in matchesAcc
  {
  }
}




passin()

passin()
{
  matchesPass := []
  numMatchesPass := 0
  FileRead, placeholder, users.txt
  Loop parse, placeholder, `n
    Loop parse, A_LoopField, `,
      if InStr(A_LoopField, "usrpass")
        matchesPass[++numMatchesPass] := trim( substr(A_LoopField, InStr(A_LoopField, ":") + 1), " `t`n`r")
}

passout()

passout()
{
  for index, element in matchesPass
  {
  }
}



IfWinExist ahk_exe LeagueClientUx.exe
{
	 MsgBox, Already running
	 goto, EXIT
}
else{
	 goto, START
	 return
}

START:
Gui, +hWndhWindow1 -Caption
Gui, Margin, 0, 0
Gui color, 0x8000FF
;~ Gui color, A0A0A0
Gui, font, c0xFFFFFF
Gui, font, s8 cWhite, Abduction2002
Gui, Add, ListBox, hWndhListBox x10 y10 w130 h156 vAccounts AltSubmit, %accountlist%
ControlColor(hListBox, hWindow1, 0x8000FF, 0xFFFFFF, redraw=1)
Gui, Add, Button, x11 y160 w35 h30 gEXIT , Exit
Gui, Add, Button, x48 y160 w49 h30 gNewUsr , Add Usr 
Gui, Add, Button, x99 y160 w40 h30 gLogIn , Log In
Gui, Show, x340 y300 h200 w150, Window
return

EXIT:
Gui, Destroy
ExitApp

NewUsr:
Gui, New
Gui, show
Gui +hWndhWindow2 -Caption
Gui, margin, 0, 0
Gui Color, 0x8000FF
Gui, font, s8 cWhite, Abduction2002
Gui Add, Text, x8 y8 w53 h23 +0x200, Usr :
Gui Add, Text, x8 y32 w53 h23 +0x200, Pwd :
Gui add, text, x8 y56 w54 h23 +0x200, Alias :
Gui Add, Edit, hWndhEdtValue x64 y8 w120 h21 vusrAcc
ControlColor(hEdtValue, hWindow2, 0x8000FF, 0xFFFFFF, redraw=1)
Gui Add, Edit, hWndhEdtValue2 x64 y32 w120 h21 vusrPass +Password
ControlColor(hEdtValue2, hWindow2, 0x8000FF, 0xFFFFFF, redraw=1)
Gui Add, Edit, hWndhEdtValue3 vusrAlias x64 y56 w120 h21 
ControlColor(hEdtValue3, hWindow2, 0x8000FF, 0xFFFFFF, redraw=1)
Gui Add, Button, hWndhBtnCancel gcloseUsr x8 y88 w80 h23, &CANCEL
ControlColor(hBtnCancel, hWindow2, 0x8080C0, 0x8080C0, redraw=1)
Gui Add, Button, hWndhBtnOk2 x104 y88 w80 h23 gaddUsr, &OK
ControlColor(hBtnOk2, hWindow2, 0x8080C0, 0x8080C0, redraw=1)
Gui Show, x340 y300 w192 h119, Window2
Return

addUsr:
Gui submit
ControlGetText, hWndEdtValue
FileAppend, usrname: %usrAcc%`n, users.txt
If errorlevel=1
	MsgBox, error

ControlGetText, hWndEdtValue2 
FileAppend, usrpass: %usrPass%`n, users.txt
If errorlevel=1
	MsgBox, error

ControlGetText, hWndEdtValue3
MsgBox, %usrAlias%
FileAppend, alias: %usrAlias%`n`n, users.txt
if errorlevel=1
	MsgBox, error
MsgBox, User added
Reload
return


closeUsr: 
Gui, destroy
return


LogIn:
Gui, submit
loginUsr := matchesAcc[Accounts]
loginPass := matchesPass[Accounts]

IfWinNotExist, ahk_exe RiotClientUx.exe
{
	RunWait, LoL.lnk
	WinWaitActive ahk_exe RiotClientUx.exe
	goto, progStart
	return
}

IfWinExist, ahk_exe RiotClientUx.exe
{
	WinActivate, ahk_exe RiotClientUx.exe
	goto, progExist
	return
}

	PROGEXIST:

	IfWinExist ahk_exe  RiotClientUx.exe
		WinActivate ahk_exe RiotClientUx.exe
		Sleep, 100
		CoordMode, mouse, Relative
		MouseMove, 195, 300
		MouseClick
	goto, LogClient
	return
	
	PROGSTART:
	IfWinExist ahk_exe RiotClientUx.exe
		WinActivate ahk_exe RiotClientUx.exe
		Sleep, 100
		CoordMode, mouse, Relative
		MouseMove, 195, 300
		MouseClick
	goto, LogClient
	return
	
	LogClient:
	Send, %loginUsr%
	Sleep, 100
	Send, {Tab}
	Send , %loginPass%
	Sleep, 100
	Send, {Enter}
	sleep, 2000
	IfWinNotExist ahk_exe LeagueClientUx.exe
	{
	WinActivate, ahk_exe RiotClientUx.exe
	Sleep, 100
	send, {Tab}
	send, {Enter}
	goto, EXIT
	}
