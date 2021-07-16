$PC = Read-Host "Type the PC"
$userName = Read-Host "Type your username"

psexec \\$PC -s winrm.cmd quickconfig -q

Invoke-Command -ComputerName $PC -ScriptBlock{
New-Item "c:\" -Name "newFolder" -ItemType "directory"}

$Session = New-PSSession -ComputerName $PC
Copy-Item "\\server\...\someMSI.msi" -Destination "C:\newFolder\someMSI.msi" -ToSession $Session

Disconnect-PSSession -Name $Session

#You need put the psexec folder in C:\

C:\PSTools\psexec.exe \\$PC -s -u $userName msiexec.exe /i C:\Temp\someMSI.msi /qn+

if ($LastExitCode -eq 0){ Write-Output "Nitro installed!"}
else{ Write-Output "Doesnt installed. Something gonne wrong. "} Read-Host