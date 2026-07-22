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
SplashImage,, W325 H100,, `nPlease Wait`, Printer Queue Being Cleared!!!`n`n This May Take Up To 10 Seconds, Clear Printer Queue
Runwait, %comspec% /c "net stop spooler",, hide ; Terminate the Print Spooler
; Windows XP has it's Print Queue located at the path used below. Adjust if necessary for your version of Windows.
Runwait, %comspec% /c "del C:\Windows\System32\spool\printers\* /Q /F /S",, hide ;  Delete all files in the Print Queue
Runwait, %comspec% /c "net start spooler",, hide ; Re-Start the Print Spooler
splashimage, off
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