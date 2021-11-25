
param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)] 
  [string]$TokenGithub
)

 $Token = $env:GithubToken_ENV_VAR


write-host ---------------------------------------------------------------------------

curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/pulls/25


write-host ---------------------------------------------------------------------------

#curl -s -H "Authorization: token $TokenGithub" -H "Accept: application/vnd.github.VERSION.sha" "https://api.github.com/repos/$Owner/$Repo/commits/main"

write-host ---------------------------------------------------------------------------

#get branches
curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches
#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches/main
#curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches/feature_enable
#curl -X DELETE -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/git/refs/heads/main
#curl -X DELETE -u Adinath-Dukare-382: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 https://api.github.com/repos/$Owner/$Repo
#curl -X DELETE -u Adinath-Dukare-382:$TokenGithub https://api.github.com/repos/$Owner/$Repo/git/refs/heads/feature_enable
