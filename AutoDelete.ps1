param(
  [parameter(Mandatory=$True)] 
  [string]$Owner,
  [parameter(Mandatory=$True)] 
  [string]$Repo,
  [parameter(Mandatory=$True)]
  [string]$SHA
)
$status = $true

$Token = $env:GithubToken_ENV_VAR

$base64token = [System.Convert]::ToBase64String([char[]]$Token);

$Headers = @{
       Authorization = 'Basic {0}' -f $base64token;
    };
    
# $deletebody  = @{
#   "title"="delete";
# #   state= "closed"
# # \""title\"" = \""open\"";
#   } | ConvertTo-Json;

# $uri = "https://api.github.com/Adinath-Dukare-382/cmteam/pulls/103"
# $closedpr = Invoke-RestMethod -Headers $Headers -uri $uri -d $deletebody -Method Patch 
# $closedpr

# curl -X PATCH -H "Accept: application/vnd.github.v3+json" $uri -d '{"title":" delete"}'


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

    try{
        $PullRequestBody = @{
        head = $branchToBeDeleted; # from
        base = 'main'; # to 
        title = 'feature to main checking before delete'; #title of PR

        } | ConvertTo-Json;

      
        $uri = "https://api.github.com/repos/$Owner/$Repo/pulls"
        
        $createpullrequest = Invoke-RestMethod -Headers $Headers -uri $uri -Body $PullRequestBody -Method Post
        # $createpullrequest
        Start-Sleep -Seconds 10

        #get pull request details

        $uri = $createpullrequest.url
        $PullRequestDetails = Invoke-RestMethod -Headers $Headers -uri $uri

        if(($PullRequestDetails.mergeable -eq "True"))
        { 
            write-Host "New content added..We cant delete it"
            $closePR = curl.exe -X PATCH -u Adinath-Dukare-382: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 $PullRequestDetails.url -d "{ \""state\"": \""closed\"" }"
            $status = $false
        }
    }
    catch
    {
        $getpr = curl.exe -X GET -u Adinath-Dukare-382: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 https://api.github.com/repos/Adinath-dukare-382/cmteam/pulls?searchCriteria.sourceRefName=$branchToBeDeleted ConvertFrom-Json
        $already = $getpr.state

        if($already -eq 'open'){
            Write-Host "PR aleredy created"
        }
        $status = $false        
    }
    
    if($status -eq $true){
        $branchUrl = "https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branchTobeDeleted"
    
        $Delete = Invoke-RestMethod -Headers $Headers -uri $branchUrl -Method Delete

        write-Host "Branch Name: "$branchTobeDeleted

        Write-Host $branchTobeDeleted" Branch should Deleting..!"
    }
    #############################################################################
} 

catch 
{ 
    Write-Host $branchTobeDeleted" branch is either already deleted or no longer exists...!" 
}
