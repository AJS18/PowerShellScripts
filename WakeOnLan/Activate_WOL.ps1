$zero = "0"

do{
$PC = Read-Host "Type the PC or type 0 to exit:"

if(Test-Connection -Cn $PC -Quiet){ 

psexec \\$PC -s winrm.cmd quickconfig -q

psexec \\$PC -s powercfg.exe /hibernate off

Invoke-Command -ComputerName $PC -ScriptBlock{
set-executionpolicy unrestricted}

Invoke-Command -ComputerName $PC -ScriptBlock{
New-Item "c:\" -Name "Scripts" -ItemType "directory"}


$Session = New-PSSession -ComputerName $PC
Copy-Item "\\server\...\Enable_WOL.ps1" -Destination "C:\Scripts\Enable_WOL.ps1" -ToSession $Session

Disconnect-PSSession -Name $Session

psexec \\$PC cmd -u user -p password /c "powershell -noninteractive -file C:\Scripts\Enable_WOL.ps1"

if ($LastExitCode -eq 0){ Write-Output "

Activated!

"}else{ Write-Output "Algo deu errado."}
}While ($PC -ne $zero)