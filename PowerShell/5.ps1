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