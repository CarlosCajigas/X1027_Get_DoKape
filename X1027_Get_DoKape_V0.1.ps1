<#
Author: Carlos Cajigas <los1662@gmail.com> 
This program is free software.  You can redistribute
it and/or modify it in any way you desire.

X1027_Get_Do_Kape_V#.#.ps1
    Helps in collecting data remotely

V0.1 - initial
 
This is an example of running the script internally against a list of systems in computers.txt
#Invoke-Command (Get-Content .\computers.txt) -Credential carlos .\X1027_Get_Do_Kape_V#.#.ps1
This is an example of running the script in an admin prompt as a oneliner.   
#PowerShell "Invoke-Expression (New-Object System.Net.WebClient).downloadstring('http://10.10.10.10/X1027_Get_DoKape_V0.1.ps1')"

#>

#change this to the webserver IP address
$webhost = "10.10.10.10"

#you should not have to change anything below this point

#This is to supress the output of the invoke-webrequest 
$ProgressPreference="SilentlyContinue"

#This downloads the zip file to the remote machine from a webserver
Invoke-WebRequest -Uri http://$webhost/KAPE.zip -OutFile .\KAPE.zip

#This expands the newly downloaded zip file
Expand-Archive -Path .\KAPE.zip

#This runs the Kape command of your choice
KAPE\KAPE\kape.exe --tsource C: --tdest C:\temp\kape\collect --tflush --target PowerShellConsole --scs $webhost --scp 1034 --scu collect --scpw 0788a6922bd5f9f130e7ed8980193bab --vhdx host --mdest C:\temp\kape\process --mflush --zm true --module NetworkDetails,PWSH-Get-ProcessList --mef csv --gui

#This removes the kape directory for cleaning purposes
Remove-Item .\KAPE\ -Recurse -Confirm:$false -Force

#This removes the zip file
Remove-Item .\KAPE.zip