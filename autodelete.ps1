
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

write-host ---------------------------------------------------------------------------

$id = $(System.PullRequest.PullRequestId)
$id
write-host ---------------------------------------------------------------------------

$final = curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/pulls/2
$final.user.login

write-host ---------------------------------------------------------------------------

#$createpullrequest = Invoke-RestMethod -Headers $Headers

curl -s -H "Authorization: token $TokenGithub" -H "Accept: application/vnd.github.VERSION.sha" "https://api.github.com/repos/$Owner/$Repo/commits/main"

write-host ---------------------------------------------------------------------------

#get branches
curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches
#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches/main
#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches/feature_enable
#curl -X DELETE -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/git/refs/heads/main
#curl -X DELETE -u Adinath-Dukare-382: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 https://api.github.com/repos/$Owner/$Repo
#curl -X DELETE -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/$Owner/$Repo/git/refs/heads/feature_enable
