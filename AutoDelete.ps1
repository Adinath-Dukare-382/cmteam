param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)]
  [string]$SHA
)

$Token = $env:GithubToken_ENV_VAR

$base64token = [System.Convert]::ToBase64String([char[]]$Token);

$Headers = @{
       Authorization = 'Basic {0}' -f $base64token;
    };

try {
    write-Host "Commit Id: "$SHA

    $CommitUrl = "https://api.github.com/repos/$Owner/$Repo/commits/$SHA/pulls"
    $PullRequest = Invoke-RestMethod -Headers $Headers -uri $CommitUrl -Method Get
    
    write-Host "PR Number: "$PullRequest.number

    $prUrl = $PullRequest.url
    $prInfo = Invoke-RestMethod -Headers $Headers -uri $prUrl -Method Get
    
    write-Host "PR Title: "$prInfo.title

    $branchTobeDeleted = $prInfo.head.ref
    
    #############################################################################
    
    $PullRequestBody = @{
      head = $branchToBeDeleted; # from
      base = 'main'; # to 
      title = 'feture to main checking before delete'; #title of PR

      } | ConvertTo-Json;


      $MergeBody = @{
            commit_title = 'checking mergeable'; 
      } | ConvertTo-Json;

    try{
      $uri = "https://api.github.com/repos/$Owner/$Repo/pulls"
      $res = Invoke-RestMethod -Headers $Headers -uri  $uri
      $res
      
      $createpullrequest = Invoke-RestMethod -Headers $Headers -uri  $uri -Body $PullRequestBody -Method Post
      Start-Sleep -Seconds 10

      #get pull request details
      $uri = $createpullrequest.url
      $PullRequestDetails = Invoke-RestMethod -Headers $Headers -uri $uri

      if(($PullRequestDetails.mergeable -eq "True"))
      { 
           write-Host "New content added"
      }
    }
#     else
    catch
      {
          write-Host "Nothing new added.. Good to delete"
      }
    
    #############################################################################
    
    $branchUrl = "https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branchTobeDeleted"
   
    $Delete = Invoke-RestMethod -Headers $Headers -uri $branchUrl -Method Delete

    write-Host "Branch Name: "$branchTobeDeleted

    Write-Host $branchTobeDeleted" Branch Deleted..!"
} 
catch { 
    Write-Host $branchTobeDeleted" branch is either already deleted or no longer exists...!" 
}
