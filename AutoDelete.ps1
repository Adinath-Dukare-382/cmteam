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
    
try {
    write-Host "Commit Id: "$SHA

    $CommitUrl = "https://api.github.com/repos/$Owner/$Repo/commits/$SHA/pulls"
    $PullRequest = Invoke-RestMethod -Headers $Headers -uri $CommitUrl -Method Get
    
    write-Host "PR Number: "$PullRequest.number

    $prUrl = $PullRequest.url
    $prInfo = Invoke-RestMethod -Headers $Headers -uri $prUrl -Method Get
    
    write-Host "PR Title: "$prInfo.title

    $branchTobeDeleted = $prInfo.head.ref
    
    $branchUrl = "https://api.github.com/repos/$Owner/$Repo/git/refs/heads/$branchTobeDeleted"
    
    #############################################################################

    try{
        $PullRequestBody = @{
        head = $branchToBeDeleted; # from
        base = 'main'; # to 
        title = 'feature to main checking before delete'; #title of PR

        } | ConvertTo-Json;

      
        $uri = "https://api.github.com/repos/$Owner/$Repo/pulls"
        
        $createpullrequest = Invoke-RestMethod -Headers $Headers -uri $uri -Body $PullRequestBody -Method Post
        Start-Sleep -Seconds 10

        #get pull request details

        $uri = $createpullrequest.url
        $PullRequestDetails = Invoke-RestMethod -Headers $Headers -uri $uri
        write-Host "---------------------Before"
        $closePR = curl -X PATCH -u Adinath-Dukare-382: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 $PullRequestDetails.url -d '{"state":"closed"}'
        write-Host "---------------------After"
        $status = $false

#         if(($PullRequestDetails.mergeable -eq "True"))
#         { 
#             write-Host "New content added..We cant delete it"
#             $closePR = curl -X PATCH -u Adinath-Dukare-382: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 $PullRequestDetails.url -d '{"state":"closed"}'
#             $status = $false
#         }
    }
    catch
    {
        $uri = "https://api.github.com/repos/$Owner/$Repo/pulls?searchCriteria.sourceRefName=$branchToBeDeleted"
        $getpr = Invoke-RestMethod -Headers $Headers -uri $uri -Method Get
        
        write-Host "-----------------------------------------------********------------------------------------------------------"
        
        if($getpr.state){
            Write-Host "PR aleredy created"
            $status = $false
        }
        else{
          $status = $true    
        }
    }
    
    if($status -eq $true){    
        $Delete = Invoke-RestMethod -Headers $Headers -uri $branchUrl -Method Delete

        write-Host "Branch Name: "$branchTobeDeleted

        Write-Host $branchTobeDeleted" Branch Deleted..!"
    }
    #############################################################################
} 

catch 
{ 
    Write-Host $branchTobeDeleted" branch is either already deleted or no longer exists...!" 
}
