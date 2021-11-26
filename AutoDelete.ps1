param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)]
  [string]$Version
)

$TokenGithub = $env:GithubToken_ENV_VAR

$PullRequest = curl -X GET -u ${Owner}:$TokenGithub https://api.github.com/repos/$Owner/$Repo/commits/$Version/pulls | Convertfrom-Json
$prurl = $PullRequest.url

$prinfo = curl -X GET -u ${Owner}:$TokenGithub $prurl | ConvertFrom-Json
$branch = $prinfo.head.ref
$prinfo

write-Host 'Deleting branch...'
curl -X DELETE -u ${Owner}:$TokenGithub https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branch
write-Host "$branch branch deleted"

