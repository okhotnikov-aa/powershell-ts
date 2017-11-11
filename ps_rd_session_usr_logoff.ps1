 Write-Host "RDS Util by okhotnikov-aa"
 Write-Host ""
 Write-Host " 1. Log Off Disconnected Sessions"
 Write-Host " 2. Log Of All Sessions"
 Write-Host " 0. Quit"
 $menu = Read-Host ""

 Write-Host ""
 Write-Host "Please enter RD Connection Broker FQDN"
 $rdcb = Read-Host ""

 Switch ($menu) {
 "1" {$session_list = Get-RDUserSession -ConnectionBroker $rdcb | Where-Object -Filter {$_.SessionState -eq 'STATE_DISCONNECTED'} }
 "2" {$session_list = Get-RDUserSession -ConnectionBroker $rdcb}
 "0" {Exit}
 }

 Foreach ($session_list in $session_list)
 {
 Invoke-RDUserLogoff -UnifiedSessionID $session_list.SessionId -HostServer $session_list.HostServer -Force
 Write-Host "The User" $session_list.UserName "is succesfully logged off from" $session_list.HostServer "server"
 } 