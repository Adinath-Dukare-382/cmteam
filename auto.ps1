param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)] 
  [string]$TokenGithub,
  [parameter(Mandatory=$True)]
  [string]$Version
)
write-Host $Version

curl -X GET -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/Adinath-Dukare-382/cmteam/commits/$Version/pulls
