
param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)] 
  [string]$TokenGithub
#   [parameter(Mandatory=$True)] 
#   [string]$FromBranch,
#   [parameter(Mandatory=$True)] 
#   [string]$ToBranch,
#   [parameter(Mandatory=$True)] 
#   [string]$PullRequestTitle,
#   [parameter(Mandatory=$True)] 
#   [string]$Reviewers
)

 #$Token = $env:GithubToken_ENV_VAR

 $Token = $env:GithubToken_ENV_VAR
#################################

$base64token = [System.Convert]::ToBase64String([char[]]$Token);

$Headers = @{
       Authorization = 'Basic {0}' -f $base64token;
    };

write-host $Headers

$webRequest = Invoke-RestMethod -URI "http://api.open-notify.org/astros.json"

$createpullrequest = Invoke-RestMethod -Headers $Headers

