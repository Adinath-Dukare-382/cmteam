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

$PullRequest = curl -X GET -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/Adinath-Dukare-382/cmteam/commits/$Version/pulls
$prurl = $PullRequest.url

$prinfo = curl -X GET -u Adinath-Dukare-382:$TokenGithub $prurl | ConvertFrom-Json
$branch = $prinfo.head.ref
$branch

curl -X DELETE -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/Adinath-Dukare-382/githubpoc/git/refs/heads/$branch
