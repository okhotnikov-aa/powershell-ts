$RDSessions = Get-RDUserSession -ConnectionBroker ld-s-rdcb03n02.ao.nlmk | Where-Object -Filter {$_.SessionState -eq 'STATE_DISCONNECTED'}
 Foreach ($RDSession in $RDSessions)
 {
 Invoke-RDUserLogoff -UnifiedSessionID $RDSession.SessionId -HostServer $RDSession.HostServer -Force
 Write-Host "The User" $RDSession.UserName "is logged off from" $RDSession.HostServer "server"
 } 