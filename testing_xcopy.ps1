[CmdletBinding()]
  param (
    [parameter(Mandatory=$True)]
    [string]$branchName
  )
  
$source = "C:\Users\A888382\Desktop\Dustbin\zips\HIMReportDataSync"
$destination = "C:\Users\A888382\Desktop\Dustbin\zips\COPYFiles"

xcopy "$source\appsettings.json" "$destination"  /c /d /i /y
xcopy "$source\microsoft.codeanalysis.csharp.dll" "$destination"  /c /d /i /y

write-host $source
write-host $destination
write-host $branchName

function builddetails
{
  write-host "adinath"
  .\call_testing_xcopy.ps1 -branch "CMTEAM"
}

builddetails
