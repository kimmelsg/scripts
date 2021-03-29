#run as super user?


$tenantRoot = "SOFTWARE\Policies\Microsoft\OneDrive\TenantAutoMount"
$keyValues = @{
    "Kimmel Share" = "tenantId=5866fb96-f186-464b-94ad-097b0cc023a9&siteId={1d6305a1-07c8-457f-b688-b515654e9d7c}&webId={972547b2-ec3d-4040-89ad-9bc54f03df20}&listId={F439D6B9-53C0-4C45-888A-198F63B0D369}&folderId=f83ecd9f-7bb4-4451-a42e-112acdffecc6&webUrl=https://kimmel.sharepoint.com/sites/KimmelUsers&version=1"
    "Marketing Material" = "tenantId=5866fb96-f186-464b-94ad-097b0cc023a9&siteId={1d6305a1-07c8-457f-b688-b515654e9d7c}&webId={972547b2-ec3d-4040-89ad-9bc54f03df20}&listId={F439D6B9-53C0-4C45-888A-198F63B0D369}&folderId=003d8f8a-aa42-4a9d-a317-35e6d30a2642&webUrl=https://kimmel.sharepoint.com/sites/KimmelUsers&version=1"
    "Email Signatures" = "tenantId=5866fb96-f186-464b-94ad-097b0cc023a9&siteId={1d6305a1-07c8-457f-b688-b515654e9d7c}&webId={972547b2-ec3d-4040-89ad-9bc54f03df20}&listId={F439D6B9-53C0-4C45-888A-198F63B0D369}&folderId=e7a6c62d-b8f1-4178-93e0-39157e9f435e&webUrl=https://kimmel.sharepoint.com/sites/KimmelUsers&version=1"
    "Teams Backgrounds" = "tenantId=5866fb96-f186-464b-94ad-097b0cc023a9&siteId={1d6305a1-07c8-457f-b688-b515654e9d7c}&webId={972547b2-ec3d-4040-89ad-9bc54f03df20}&listId={F439D6B9-53C0-4C45-888A-198F63B0D369}&folderId=fe71461e-7fd0-4446-ab01-155b81c568ea&webUrl=https://kimmel.sharepoint.com/sites/KimmelUsers&version=1"
    "Adminlinks" = "tenantId=5866fb96-f186-464b-94ad-097b0cc023a9&siteId={ef975f5b-609b-4aa2-a642-ee733b06eee5}&webId={db126de5-99e5-4432-9e51-81cf68a6be54}&listId={2C974691-FC09-40B5-9449-828AE8F900D2}&folderId=a4cfc2c9-e08a-4cf6-b1ff-9a0f416e0604&webUrl=https://kimmel.sharepoint.com/sites/FrontOffice&version=1"
}

$registryPathRoot = "$($user.name)\"
Write-Host $registryPathRoot
    

foreach ($key in $keyValues.keys){
    Remove-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\$tenantRoot" -Name "$key"
    Remove-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\$tenantRoot" -Name "$key" 
    New-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\$tenantRoot" -Name $key -Value $keyValues[$key]  -PropertyType "String"
    New-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\$tenantRoot" -Name $key -Value $keyValues[$key]  -PropertyType "String"
}

