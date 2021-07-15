$digPC = read-host "Type the PC:"

#need create a list in a note pad with the pc names.

$CSV = import-csv "\\server\A_List_Of_Pcs.csv" 

foreach($LINE in $CSV){

if($LINE.namePC -eq $digPC){ 

$mac = $LINE.mac }

}

$MacByteArray = $mac -split "[:-]" | ForEach-Object { [Byte] "0x$_"}
[Byte[]] $MagicPacket = (,0xFF * 6) + ($MacByteArray  * 16)
$UdpClient = New-Object System.Net.Sockets.UdpClient
$UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
$UdpClient.Send($MagicPacket,$MagicPacket.Length)
$UdpClient.Close() 
read-host

#cod. 102 = good.