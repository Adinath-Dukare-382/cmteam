@echo off



set "source=C:\Users\A888382\Desktop\Dustbin\zips\HIMReportDataSync\"

set "destination=C:\Users\A888382\Desktop\Dustbin\zips\COPYFiles\"
echo "%source%appsettings.json"

xcopy "%source%appsettings.json"	"%destination%"		/c /d /i /y
xcopy "%source%microsoft.codeanalysis.csharp.dll"	"%destination%"		/c /d /i /y 
xcopy "%source%microsoft.codeanalysis.visualbasic.dll"	"%destination%"  /c /d /i /y 
xcopy "%source%microsoft.codeanalysis.visualbasic.workspaces.dll"	"%destination%"  /c /d /i /y
xcopy "%source%microsoft.codeanalysis.workspaces.dll"	"%destination%"  /c /d /i /y