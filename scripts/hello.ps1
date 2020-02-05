$strString = "Hello World"
write-host $strString

param (
    [string]$mysub,
  
)
az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/$mysub"  
