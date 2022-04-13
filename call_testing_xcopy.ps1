[CmdletBinding()]
  param (
    [parameter(Mandatory=$True)]
    [string]$branch
  )
$ad = "Adinath"
write-host $ad
$source = "C:\Users\A888382\Desktop\Dustbin\zips\HIMReportDataSync"
$destination = "C:\Users\A888382\Desktop\Dustbin\zips\COPYFiles\"
   
xcopy "$source\appsettings.json" "$destination"  /c /d /i /y
xcopy "$source\microsoft.codeanalysis.csharp.dll" "$destination"  /c /d /i /y
xcopy "$source\appsettings.himreport.json"	"$destination"  /c /d /i /y

write-host $branch
