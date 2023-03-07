$TenantID = '0821259b-26fd-4642-b49a-e5a83460648f'
Connect-AzureAD -TenantId $TenantID
$functionIdentityObjectId ='e9d0c0a2-3468-40d1-8f1a-fef2d2561ab9'
$graphAppId = '00000003-0000-0000-c000-000000000000' # This is a well-known Microsoft Graph application ID.
$graphApiAppRoleName = 'Application.ReadWrite.All'
$graphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$graphAppId'"
$graphApiAppRole = $graphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $graphApiAppRoleName -and $_.AllowedMemberTypes -contains "Application"}

# Assign the role to the managed identity.
New-AzureADServiceAppRoleAssignment -ObjectId $functionIdentityObjectId -PrincipalId $functionIdentityObjectId -ResourceId $graphServicePrincipal.ObjectId -Id $graphApiAppRole.Id
