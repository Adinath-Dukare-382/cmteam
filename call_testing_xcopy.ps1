[CmdletBinding()]
  param (
    [parameter(Mandatory=$True)]
    [string]$branch
  )
$ad = "Adinath"

write-host $branch
