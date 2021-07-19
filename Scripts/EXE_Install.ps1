Import-Module $env:SyncroModule

# Variables
$EXE_Filepath = "YOUR-PATH-FOR-YOUR-FILE"

# Check if Installed, if yes it will exit
if(Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object -Property DisplayName  -like "SOFTWARE XYZ") {
    Write-Output "INFO: SOFTWARE XYZ exists"
    exit 0
} else {
    Write-Output "INFO: SOFTWARE XYZ does not exist"
}

New-PSDrive -Name "Public" -PSProvider "FileSystem" -Root $EXE_Filepath

# Check if Folder can be accessed
if((Test-Path $EXE_Filepath) -eq $false){
    Log-Activity -Message "No Access to Folder" -EventName "Error"

    exit 0
}

# Install HP Click
Log-Activity -Message "INSTALL SOFTWARE XYZ" -EventName "Installer"
Write-Output $EXE_Filepath + "SOFTWARE_XYZ.exe"

$CMD = $EXE_Filepath + "SOFTWARE_XYZ.exe"
#Start-Process -Wait -FilePath $CMD -ArgumentList "--mode unattended" -PassThru
Start-Process -Wait -ArgumentList "/silent" -PassThru -FilePath $CMD

# Clean up
Remove-PSDrive -Name Public