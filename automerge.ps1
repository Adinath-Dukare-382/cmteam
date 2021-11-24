
param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo
#   [parameter(Mandatory=$True)] 
#   [string]$FromBranch,
#   [parameter(Mandatory=$True)] 
#   [string]$ToBranch,
#   [parameter(Mandatory=$True)] 
#   [string]$PullRequestTitle,
#   [parameter(Mandatory=$True)] 
#   [string]$Reviewers
)

# #Reference 
# # https://docs.github.com/en/rest/reference/pulls

# $ReviewersArray = @($Reviewers)
# #################################
# #$Token = 'Add the token here if running manually and comment below line'   https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token
#  $Token = $env:GithubToken_ENV_VAR
# #################################

# $base64token = [System.Convert]::ToBase64String([char[]]$Token);

# $Headers = @{
#        Authorization = 'Basic {0}' -f $base64token;
#     };


# $PullRequestBody = @{
#       head = $FromBranch; # from
#       base = $ToBranch; # to 
#       title = $PullRequestTitle; #title of PR

# } | ConvertTo-Json;


# $MergeBody = @{
#       commit_title = $PullRequestTitle; 
# } | ConvertTo-Json;


# $ReviewerNamesBody = @{   
#     team_reviewers = $ReviewersArray;
# } | ConvertTo-Json;




# #create pull request
# $uri = "https://api.github.com/repos/$Owner/$Repo/pulls"
# $uri = "https://github.com/$Owner/$Repo/pulls"
# $createpullrequest = Invoke-RestMethod -Headers $Headers -uri  $uri -Body $PullRequestBody -Method Post
# Start-Sleep -Seconds 10
# #get pull request details
# $uri = $createpullrequest.url
# $PullRequestDetails = Invoke-RestMethod -Headers $Headers -uri $uri

curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/branches

curl \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$Owner/$Repo
  
curl -X DELETE -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/automated-security-fixes
curl -X DELETE -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$Owner/$Repo/feature_enable



# #check if the code is mergeable (there are no conflicts)
# if(($PullRequestDetails.mergeable -eq "True"))
# { 
#    #merge Pullrequest
#    $uri = $createpullrequest.url + "/merge"
#    $mergedPR = Invoke-RestMethod -Headers $Headers -uri  $uri -Method PUT -Body $MergeBody
#    $mergedPR

# }
# else
# {
# #add reviewers
# $uri = $createpullrequest.url + "/requested_reviewers"
# $requestreview = Invoke-RestMethod -Headers $Headers -uri $uri -Body $ReviewerNamesBody -Method Post
# $PullRequestDetails
# Write-Error "There are conflicts and needs to be resolved"

# }

# curl -s -X DELETE -u ['Adinath-Dukare-382']:[$Token] https://api.github.com/repos/[$Owner]/[$Repo]/git/refs/heads/feature_main

