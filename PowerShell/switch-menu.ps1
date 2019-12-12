function Show-Menu
{
     param (
           [string]$Title = 'My Menu'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Type '1' and press ENTER to ping your subnetwork."
     Write-Host "2: Type '2' and press ENTER to check connected ports."
     Write-Host "3: Type '3' and press ENTER to get information of the OS and registered user."
     Write-Host "q: Type 'q' and press ENTER to quit."
}

Function PingSub 
{
    Foreach ($i in $oct = 1..254)
    {
        $myHost = "192.168.38."+$i
        Write-Host "Pinging on 192.168.38.$i"
        Write-Host "========================="
        ping -n 1 -w 2 $myHost | Select-String "bytes=32"
    }
}

Function EstablishedCon
{
    Write-Host "The following TCP connections are ESTABLISHED"
    Write-Host "========================================="
    netstat -ano | Select-String ESTABLISHED | Select-String TCP
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
     $input = Read-Host "`nPlease, make a selection"
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
