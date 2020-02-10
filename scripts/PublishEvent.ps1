#code for sending custom data to subscribed endpoint. Need to embed this in azure function and also need to write the handler part in the application


param (
    [string]$topicEndpoint,
    [string]$topicKey
  
)
$endpoint = $topicEndpoint
$keys = $topicKey

#$subID =(Get-AzureRmContext).Subscription.Id
#$directoryID = (Get-AzureRmContext).Subscription.TenantId
$eventID = Get-Random 99999

#Date format should be SortableDateTimePattern (ISO 8601)
$eventDate = Get-Date -Format s

#Construct body using Hashtable
$htbody = @{
    id= $eventID
    eventType="CustomEventsNotification"
    subject="AzureOnboardingStatus"
    eventTime= $eventDate   
    data= @{
        Status="Pending"
    }
    dataVersion="1.0"
}

#Use ConvertTo-Json to convert event body from Hashtable to JSON Object
#Append square brackets to the converted JSON payload since they are expected in the event's JSON payload syntax
$body = "["+(ConvertTo-Json $htbody)+"]"
Invoke-WebRequest -Uri $endpoint -Method POST -Body $body -Headers @{"aeg-sas-key" = $keys}
