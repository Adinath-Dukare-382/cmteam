$source = "C:\Users\A888382\Desktop\Dustbin\zips\HIMReportDataSync"
$destination = "C:\Users\A888382\Desktop\Dustbin\zips\COPYFiles\"

write-host $source
write-host $destination

${{ github.workspace }}\call_testing_xcopy.ps1 -branch "CMTEAM"
