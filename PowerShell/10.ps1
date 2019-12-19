# This is a comment in PowerShell
Write-Host "Welcome to my first simple PowerShell script"

# Cleaning the screen now
cls

# Setting your first variable in PowerShell
$just_var = "I am a just a test variable"

# Writing the variable on the screen
$just_var

# Now I will require information from the user asking a question
# and that information will be stored in the variable <username>
$username = Read-Host "`nPlease, type your name"

# Introducing a temporary interruption or pause until pressing ENTER
pause

Write-Host "Hello $username, will need your password in a while, but first, lets build a function"

# We are going to create a simple function. It will show a menu of options
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

Write-Host "The Show-Menu function has been created. It will appear after the pause..."
pause
Show-Menu

# Creating the function for the password authentication process
Function Password
{
    cls
    # Setting the maximum number of tries
    $tries = 3

    Do
    {
        cls
        $password = Read-Host "Type your password:"
        # Decreasing the number of tries after a try
        $tries--
    }
    Until (($tries -eq 0) -or ($password -eq "myuserpass") -or ($password -eq "AdminMaster"))
    if ($password -eq "myuserpass")
    {
        Write-Host "Welcome $username, now I will show a menu with options"
        Show-Menu
    }
    elseif ($password -eq "AdminMaster")
    {
        Write-Host "Welcome Administrator. I will show you the menu"
        pause
        Show-Menu
    }
    else
    {
        Write-Host "You tried too many times"
    }
}

Password

# Creating the function to perform ping connectivity checkings
# Remember to properly configure the network range
Function PingSub 
{
    Foreach ($i in $oct = 1..254)
    {
        $myHost = "192.168.1."+$i
        Write-Host "Pinging on 192.168.1.$i"
        Write-Host "========================="
        ping -n 1 -w 2 $myHost | Select-String "bytes=32"
    }
}

# Creating the function to check TCP ESTABLISHED connections
Function EstablishedCon
{
    Write-Host "The following TCP connections are ESTABLISHED"
    Write-Host "========================================="
    netstat -ano | Select-String ESTABLISHED | Select-String TCP
}

# Creating the function to get information about the Operating System
Function GetOSInfo
{
    Write-Host "OS information as requested"
    Write-Host "==========================="
    Get-WmiObject -class Win32_OperatingSystem
}

# Establishing how to proceed with an until loop
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
