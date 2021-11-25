
param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)] 
  [string]$TokenGithub
)

 $Token = $env:GithubToken_ENV_VAR

curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/Adinath-Dukare-382/githubpoc/branches

$output = curl -X GET -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/Adinath-Dukare-382/githubpoc/commits/b20b89382683ceaee0e84021403248031bd5be3b/pulls | ConvertFrom-Json
$output
$output.url

$prinfo = curl -X GET -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/Adinath-Dukare-382/githubpoc/pulls/3 | ConvertFrom-Json
$prinfo
$branch = $prinfo.head.ref

curl -X DELETE -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/Adinath-Dukare-382/github/git/refs/heads/$branch

write-host ---------------------------------------------------------------------------

#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/pulls
#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/octocat/hello-world/pulls

write-host ---------------------------------------------------------------------------

#curl -s -H "Authorization: token $TokenGithub" -H "Accept: application/vnd.github.VERSION.sha" "https://api.github.com/repos/$Owner/$Repo/commits/871b281c3b3f294f428e98b335d024f641d73b77"

write-host ---------------------------------------------------------------------------

#get branches
#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches

#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches/main
#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches/feature_enable
#curl -X DELETE -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/git/refs/heads/main
#curl -X DELETE -u Adinath-Dukare-382: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 https://api.github.com/repos/$Owner/$Repo
#curl -X DELETE -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/$Owner/$Repo/git/refs/heads/feature_enable
