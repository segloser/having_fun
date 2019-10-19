function Show-Menu
{
     param (
           [string]$Title = 'My Menu'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' for pinging your subnetwork."
     Write-Host "2: Press '2' for checking connected ports."
     Write-Host "3: Press '3' for getting information of the OS and registered user."
     Write-Host "Q: Press 'Q' to quit."
}

Function PingSub 
{
    Foreach ($i in $oct = 1..254)
    {
        $myHost = "192.168.0."+$i
        Write-Host "Pinging on 192.168.0.0/24"
        Write-Host "========================="
        ping -n 1 -w 2 $myHost | Select-String "bytes=32"
    }
}

Function EstablishedCon
{
    Write-Host "The following connections are ESTABLISHED"
    Write-Host "========================================="
    netstat -bano | Select-String ESTABLISHED
}

Function GetOSInfo
{
    Write-Host "OS information as requested"
    Write-Host "==========================="
    Get-WmiObject -class Win32_OperatingSystem
}

do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                cls
                 PingSub
           } '2' {
                cls
                EstablishedCon
           } '3' {
                cls
                GetOSInfo
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
