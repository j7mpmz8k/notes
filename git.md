`git reset --hard` -> moves head one commit backwards and changes file to remove broken commit changes
`git reset --soft` -> moves head one commit backwards but does not change files and stages changes from broken commit ready to commit

`git revert` -> commit a copy of previous commit before broken commit preventing rewriting history...use `-n` to just stage them instead of commit

use `~` for relative checkouts
`git checkout HEAD~` <- goes back one commit always
`git checkout master~1` <- also goes back one commit but from master

`git diff <commit>` compares current checked out commit to requested commit
`git show` shows diff of checked out commit compared to branch's most recent commit

`git reflog` shows history of checked out commits
`git log -g` shows more detailed reflog in log format
`git log --online` much shorter version of reflog in log format
`git log master` shows log from branch perspective

`git show-branch` helpful since it gives an overview of all other brancches if added to or reverted commits
`git log --graph` shows visual tree of branches

setup new remote
`git remote rename origin old-origin`
`git remote add origin <URL>`
`git push -u origin master`sets origin/master as default for push

`git bisect start` or `git
`git bisect bad`
`git bisect good master`
`git bisect run sh custom-script.sh` lets me automate bisect. Combine with `$?` in shell script to decode error messages 

deleting a tag
`git tag -d <tag_name>`
`git push -d origin <tage_name>`
