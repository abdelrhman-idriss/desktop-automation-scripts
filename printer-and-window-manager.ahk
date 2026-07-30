/*
===============================================================================
 Script Name : System Quick Actions (Printer Spooler & Window Pinning)
 Description : A lightweight AutoHotkey utility designed to clear jammed print
               queues and toggle Always-On-Top window pinning.
 Language    : AutoHotkey (v1.1+)
 Platform    : Windows 10 / 11 (Requires Administrative Rights for Printer Spooler)
 Author      : Abdelrhman Idriss
 License     : MIT
===============================================================================
 Shortcuts:
   Ctrl + 3  : Clear Windows Print Spooler Queue
   Ctrl + 1  : Pin Active Window Always-On-Top & Snap to Top-Left
===============================================================================
*/

#SingleInstance Force
global NotepadMade := -1
global trans := -1

^3::
ClearPrinterQueue:
    ToolTip, Clearing Printer Queue... Please wait.
    RunWait, %ComSpec% /c "net stop spooler",, Hide
    RunWait, %ComSpec% /c "del /Q /F /S ""%SystemRoot%\System32\spool\printers\*""",, Hide
    RunWait, %ComSpec% /c "net start spooler",, Hide
    ToolTip, Printer Queue Cleared Successfully!
    SetTimer, RemoveToolTip, -2000
return

^1::
;Run, notepad.exe
;WinWait, Untitled - Notepad
WinGet, WinID, ID, A
if ErrorLevel
	{
		NotepadMade := -1
		return
	}
	NotepadMade := 1
trans := -1
WinMove, Untitled - Notepad,, 0,0,300, 300
Winset, Alwaysontop, , ahk_id %WinID%
return



Esc::ExitApp
