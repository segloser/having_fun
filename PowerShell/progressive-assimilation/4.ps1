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

Write-Host "Hello $username, now we will need your password"
