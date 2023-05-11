# check the status of the git repo
git status

# pull latest changes from the remote repo
git pull

# to create a new branch from an existing branch
git checkout -b <new-branch> <existing-branch>
# To create a new branch
git branch "Branch-name"

# To switch to another branch 
git checkout "branch-name"

# To merge branch to the master branch 
git add . 
git commit -m "new changes"
git checkout master 
git merge "New-branch"


# when changes are made locally,
1. add the file to the staging area
  - git add .
2. commit the changes to the local git repo
  - git commit -m "added git-cmds file"
3. push the changes to the remote repo
  - git push -u origin temi

# GIT COMMANDS 
* git init: Initializes a new Git repository.
* git add: Adds a file or directory to the staging area.
* git commit: Commits the changes in the staging area to the local repository.
* git push: Pushes the committed changes from the local repository to a remote repository.
* git pull: Fetches the changes from a remote repository and merges them into the local repository.
* git clone: Copies a remote repository to the local machine.
* git status: Displays the current status of the repository, including any changes that have been made.
* git log: Displays a list of all the commits that have been made to the repository.
* git diff: Shows the difference between two versions of a file.
* git branch: Lists all the branches in the repository, or creates a new branch.
* git checkout: Switches between branches or commits.
* git merge: Merges changes from one branch into another.
* git remote: Lists all the remote repositories, or adds a new remote repository.
* git fetch: Retrieves the latest changes from a remote repository.
* git reset: Resets the repository to a previous commit.
* git revert: Reverts a commit by creating a new commit with the opposite changes.
* git tag: Creates a tag for a specific commit.
* git stash: Temporarily stores changes that are not yet ready to be committed.
* git submodule: Manages submodules within a Git repository.
* git config: Configures Git settings, such as the user name and email address.

Regenerate response
