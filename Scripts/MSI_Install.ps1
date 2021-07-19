Import-Module $env:SyncroModule

# Variables

$MSI_Download_File = "HTTP.//WWW.YOUR-PATH-TO-FILE";
$MSI_File = "FILENAME.MSI";
# Folder
$MSI_Filepath = "c:\temp\";

# Check if Software is Installed, if yes it will exit
# Powershell Command to get the Software List: Get-WmiObject -Class Win32_Product 
if(Get-CimInstance win32_product | Where-Object -Property Name -Match "Filename found in system") {
    Write-Output "INFO: SOFTWARE XYZ is installed."
    exit 0
}

# Check if Download Folder exist
if((Test-Path $MSI_Filepath) -eq $false){
    New-Item -Path $MSI_Filepath -ItemType Directory
}

Log-Activity -Message "Downloading MSI File into Temp Folder" -EventName "Download MSI File"

# Download File
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($MSI_Download_File, $MSI_Filepath + $MSI_File)

Log-Activity -Message "Install $MSI_File" -EventName "INSTALL MSI File"

# Install Software
$CMD = $MSI_Filepath + $MSI_File
msiexec /i $CMD.ToString() /qf /norestart
# with KEY
# msiexec /i $CMD.ToString() /qf /norestart KEYFILE="c:\temp\key.txt"

# Cleanup
rm $CMD
# rm "c:\temp\key.txt"