$strString = "Hello World"
write-host $strString

param (
    [string]$sub
  
)
# Create the application

$SecureStringPassword = ConvertTo-SecureString -String "dkw1sba4syem37jq" -AsPlainText -Force
$AppID= New-AzureRmADApplication -DisplayName "CustomerApplication" -IdentifierUris "https://google.com" -HomePage "https://google.com"  -Password $SecureStringPassword
$AID = $AppID.ApplicationId
#Create a Service Principal for the Application

$SPID = New-AzureRmADServicePrincipal -ApplicationID $AID
$SID = $SPID.Id
# Assign the Role to Service Principal:

New-AzureRmRoleAssignment -Scope /subscriptions/$sub -ObjectId $SID -RoleDefinitionId 8e3af657-a8ff-443c-a75c-2fe8c4bcb635
