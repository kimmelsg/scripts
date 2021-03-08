#Checks if outlook profile exists - we only want it to run on people who have a profile so they dont get an annoying profile popup #

$OutlookProfileExists = Test-Path "C:\Users\$env:Username\AppData\Local\Microsoft\Outlook"

if ($OutlookProfileExists -eq $true) {
    Write-Host "User Outlook profile exists.. continuing.." -ForegroundColor Yellow 

    # Signature Variables #

    $SigSource = $home + "\Kimmel & Associates\Kimmel Users - EmailSignatures\" + $env:username 
  
    # Environment variables #

    $AppData = $env:appdata 
    $SigPath = '\Microsoft\Signatures' 
    $LocalSignaturePath = $AppData + $SigPath 

    # Check signature path # 

    if (!(Test-Path -path $LocalSignaturePath)) { 
        New-Item $LocalSignaturePath -Type Directory 
    } 
    Copy-Item -Path $SigSource\*.* -Destination $LocalSignaturePath -Force



    # Set as Default Signature #

    If (Test-Path HKCU:'\Software\Microsoft\Office\16.0') { 

        Write-host "Setting signature for Office 2019"-ForegroundColor Green 
        Write-host "Setting signature for Office 2019 as available" -ForegroundColor Green 

        If ((Get-ItemProperty -Name 'First-Run' -Path HKCU:'\Software\Microsoft\Office\16.0\Outlook\Setup' -ErrorAction SilentlyContinue))   
        {  
            Remove-ItemProperty -Path HKCU:'\Software\Microsoft\Office\16.0\Outlook\Setup' -Name 'First-Run' -Force  
        }  

        If (!(Get-ItemProperty -Name 'NewSignature' -Path HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -ErrorAction SilentlyContinue))   
        {  
            New-ItemProperty -Path HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name 'NewSignature' -Value $env:username -PropertyType 'String' -Force  
        }  
 
        If (!(Get-ItemProperty -Name 'ReplySignature' -Path HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -ErrorAction SilentlyContinue))   
        {  
            New-ItemProperty -Path HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name 'ReplySignature' -Value $env:username -PropertyType 'String' -Force 
        }  
    }   
}
else {
    Write-Host "User Outlook profile doesn't exist. This script will run again on next logon and check for Outlook profile existence.." -ForegroundColor Yellow 
    exit
}
