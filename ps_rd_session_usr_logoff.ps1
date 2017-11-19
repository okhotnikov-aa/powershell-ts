Write-Host ""
Write-Host "RDS User Control"
Write-Host ""
Write-Host "Please enter RD Connection Broker FQDN:"
$rdcb = "ld-s-rdcb03n02.ao.nlmk" #Read-Host 
Write-Host ""

$rddepl = Get-RDServer -ConnectionBroker $rdcb | Where-Object -Filter {$_.Roles -eq 'RDS-RD-SERVER'} # get all RDSH in deployment
$sessions = Get-RDUserSession -ConnectionBroker $rdcb # get all sessions in deployment
Write-Host "This RD Deployment contains:"
Write-Host ""
foreach ($rddepl in $rddepl) # show all RDSH and they connected sessions
{
    Write-Host $rddepl.Server

    #cout all sessions
    $ssns = $sessions | Where-Object -Filter {$_.HostServer -eq $rddepl.Server} | measure
    Write-Host "Number of sessions:" $ssns.Count 

    #count active sessions
    $ssns = $sessions | Where-Object -Filter {$_.HostServer -eq $rddepl.Server}| Where-Object -Filter {$_.SessionState -eq 'STATE_ACTIVE'}  | measure
    Write-Host "Number of active:" $ssnss.Count

    #count disconnected sessions
    $ssns = $sessions | Where-Object -Filter {$_.HostServer -eq $rddepl.Server} | Where-Object -Filter {$_.SessionState -eq 'STATE_DISCONNECTED'} | measure
    Write-Host "Number of disconnected:" $ssns.Count
    Write-Host ""

}