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

$PullRequest = curl -X GET -u $Owner :$TokenGithub https://api.github.com/repos/$Owner/$Repo/commits/$Version/pulls | Convertfrom-Json
$prurl = $PullRequest.url

$prinfo = curl -X GET -u $Owner :$TokenGithub $prurl | ConvertFrom-Json
$branch = $prinfo.head.ref

curl -X DELETE -u $Owner :$TokenGithub https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branch
write-host "$branch be deleted"
