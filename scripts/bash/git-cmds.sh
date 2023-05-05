# check the status of the git repo
git status

# pull latest changes from the remote repo
git pull

# to create a new branch from an existing branch
git checkout -b <new-branch> <existing-branch>

# when changes are made locally,
1. add the file to the staging area
  - git add .
2. commit the changes to the local git repo
  - git commit -m "added git-cmds file"
3. push the changes to the remote repo
  - git push -u origin temi
# some changes from remote
