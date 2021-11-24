# update local list of pruned branches on the remote to local:
git fetch --prune 

# delete branches on remote origin that have been merge to master
git branch --merged remotes/origin/main -r | %{$_.trim().replace('origin/', '')} | ?{$_ -notmatch 'main'} | %{git push --delete origin $_}

# delete local branches that have been merged to master
git branch --merged remotes/origin/main | %{$_.trim()} | ?{$_ -notmatch 'main'} | %{git branch -d $_}

# remove stale refs (local refs to branches that are gone on the remote)
git remote prune origin
