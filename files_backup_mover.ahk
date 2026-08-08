#Requires AutoHotkey v2.0
#SingleInstance Force

Timestamp := FormatTime(, "yyyy-MM-dd_HH-mm")
BaseDir   := "D:\backupusingscripts\backup_" . Timestamp
PdfDir    := BaseDir . "\pdfs"

try {
    DirCreate(PdfDir)
} catch as err {
    MsgBox("Failed to create backup directory:`n" . err.Message, "Error", 16)
    ExitApp()
}

try {
    FileMove(A_Desktop . "\*.pdf", PdfDir . "\", 0)
}

movedFiles := 0
loop files, PdfDir . "\*.pdf" {
    movedFiles++
}

if (movedFiles === 0) {
    MsgBox("No PDF files were found on the desktop to back up (they may not exist or are currently open).", "Backup Status", 48)
} else {
    MsgBox("PDF Backup Complete!`n`nSuccessfully moved files to:`n" . PdfDir, "Backup Status", 64)
}

ExitApp()