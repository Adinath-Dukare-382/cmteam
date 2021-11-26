param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)]
  [string]$Version
)

$TokenGithub = $env:GithubToken_ENV_VAR

$base64token = [System.Convert]::ToBase64String([char[]]$TokenGithub);

$Headers = @{
       Authorization = 'Basic {0}' -f $base64token;
    };


$urlCommitId = "https://api.github.com/repos/$Owner/$Repo/commits/$Version/pulls"
$PullRequest = Invoke-RestMethod -Headers $Headers -uri $urlCommitId -Method Get

$prUrl = $PullRequest.url

$prinfo = Invoke-RestMethod -Headers $Headers -uri $prUrl -Method Get
$branch = $prinfo.head.ref

$branchUrl = "https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branch"
$branchInfo = Invoke-RestMethod -Headers $Headers -uri $branchUrl -Method Get

if($branchInfo.message){
    Write-Host $branch"branch either be deleted or no longer exists...!"
}
else{
    Invoke-RestMethod -Headers $Headers -uri $branchUrl -Method Delete
    Write-Host $branch" Branch Deleted..!"
}
     


#$PullRequest = curl -X GET -u ${Owner}:$TokenGithub https://api.github.com/repos/$Owner/$Repo/commits/$Version/pulls | Convertfrom-Json
#$prUrl = $PullRequest.url



#$prinfo = curl -X GET -u ${Owner}:$TokenGithub $prurl | ConvertFrom-Json
#$branch = $prinfo.head.ref



#$branchInfo = curl -X GET -u ${Owner}:$TokenGithub https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branch | ConvertFrom-Json
#if($branchInfo.message)
#  {
#      Write-Host "Already branch deleted or no longer exists...!"
#  }
#else
#  {
#      curl -s -X DELETE -u $(user):$(GithubToken) https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branch
#      Write-Host $branchtobedeleted" Branch Deleted..!" 
#  }
  
# write-Host 'Deleting branch...'
# curl -X DELETE -u ${Owner}:$TokenGithub https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branch
# write-Host "$branch branch deleted"
