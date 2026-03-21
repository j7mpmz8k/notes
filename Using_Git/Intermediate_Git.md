# Intermediate Git

This document describes Git commands that will give you more detailed
information about the state and structure of your repository, and the ability
to time-travel to older points in history.

* [Important Git Jargon](#important-git-jargon)
* [See What's Changed With `git diff`](#see-whats-changed-with-git-diff)
* [Reading Git's Log](#reading-gits-log)
* [Discarding Uncommitted Changes](#discarding-uncommitted-changes)
* [Temporarily Stashing Uncommitted Changes](#temporarily-stashing-uncommitted-changes)
* [Tagging Commits](#tagging-commits)


## Important Git Jargon

*Protip You can view a manual page defining bits of Git jargon with this command:*

```bash
git help glossary
```


#### Commit

*   **(n):** A single point in the Git history
    *   The entire history of a project is stored as a chain of commit objects.
    *   Everything you push to or pull from a Git server is a commit.  In other words, you don't send files or directories to the server when you run `git push`.  You send **commits**.
*   **(v):** The action of storing a new snapshot of the project's state in the Git history by creating a new commit.
    *   A *commit* is performed with the `git commit` command.
    *   New commits are formed with `git add` by computing the differences in the contents of the working tree with the most recently recorded commit.  This new commit is then permanently recorded by running the `git commit` command.


#### HEAD

*   The currently checked-out commit is *always* named `HEAD`.
*   `HEAD` is analogous to the concept of "current working directory".
    *   Instead of location on the file system, `HEAD` refers to a commit in your repository's *history*.


#### Working tree

*   The files and directories that are currently "checked out".
    *   The working tree consists of files and directories as of the `HEAD` commit, plus any new changes that you have not yet committed.
*   You cannot open or run the "old", historical files in the repository until they are *checked out* into the *working tree*.
    *   When you "checkout" a commit, what Git actually does is edit the files in the *working tree* to make them appear as they were at that point in time.
    *   You can think of Git as an automated text editor.


#### Object name or SHA-1 ID

*   The "true name" of a Git commit.
*   Takes the form of a 40 character-long string of hexadecimal digits (`0` through `9`, `A` through `F`)
    *   e.g. `f7e8295498512363f5cd0b12459e548ca80f329f`
*   It is a cryptographic checksum of the author's name and email address, time stamp, commit message, as well as the checksum of the contents of the commit (in a round-about way).
    *   This cryptographically-strong digital fingerprint of the commit prevents tampering with the history of the repository.
*   A commit's SHA-1 object name also incorporates the SHA-1 object name of its parent commits, which, in turn, depend upon their parents' checksums, etc.
    *   Thus, Git repositories were **blockchains** before blockchains were cool.

You can always refer to a commit with this universally unique identifier.  Because sequences of 40 arbitrary characters are hard for humans to remember, Git provides nicknames, such as `HEAD` or `master`.  A commit may have multiple names at once, but it *always* has *one* SHA-1 object name.


### Know Which Git Commands Operate On Commit Objects

Some Git commands take filenames as arguments.  One such command is `git add`.

Other Git commands take names of objects as their arguments.  `git log` is an
example.  For commands that operate on *OBJECTS* you may use any of the
following names as this argument:

0.  An *SHA-1 object ID*, which may be abbreviated to the first 7 or 8 characters
1.  A relative reference such as `HEAD`
2.  A branch name such as `master`, `main`, `devel`, etc.
3.  The name of a *tag*

Understand that for the rest of this document `OBJECT` refers *only* to Git
commits.  A file or directory is *never* an `OBJECT`.



## See What's Changed With `git diff`

`git status` tells you which files have been changed since the last commit, but
it cannot tell you *how* those files have been modified.  `git diff` displays
the differences in each changed file since the last commit.

**Important**: press `q` to quit the diff viewer.


### `git diff` with no other arguments
Displays the difference between your source code files in the working tree and
the most recent commit.  This provides a more detailed picture than `git
status`.  This shows you what will be recorded with `git add` followed by `git
commit`.


### `git diff -- FILE...`
Displays changes in specific files instead of *everything* in the repository.


### `git diff --cached` or `git diff --staged`
Once you run `git add` your changes aren't visible with the ordinary `git diff` command.

The `--cached` or `--staged` argument can be used between running `git add` and
before `git commit`, when the changes are said to be in the "staging area".


### `git diff OBJECT` 
Show the changes between `OBJECT` and `HEAD`.

*   In other words, what changes are needed to make to the code at `OBJECT` become the same as `HEAD`?
*   This lets you peer into the past and compare changes to files across time.
    -   This command lets you see the cumulative effects of *many* commits.


### `git diff OBJECT -- FILE ...` 
Show the changes that occurred between `OBJECT` and `HEAD` only for the listed files.

For example, to see how your Software Development Plan changed between the
latest commit and the tag `designed`, you would run this command:

```bash
git diff designed -- doc/Plan.md
```

It doesn't matter if the `designed` tag is 2 or 20 commits back in history.


## Reading Git's Log

The `git log` command displays the commit history from the current commit back
to the genesis of the repository.  What you see at the top of the listing is
the latest commit.  Scrolling down takes you back in time.

### Navigating The Log Viewer

On most computers the Git log is displayed using the `less` program, the same
text viewer that displays manual pages.  Use these keyboard commands to move
about the log:

*   <kbd>k</kbd> or <kbd>Up Arrow</kbd> to scroll up one line
*   <kbd>j</kbd> or <kbd>Down Arrow</kbd> to scroll down one line
*   <kbd>Space</kbd> scrolls down one screenful
*   <kbd>g</kbd> returns to the top of the log
*   <kbd>G</kbd> jumps to the bottom of the log, showing the oldest commit (sometimes you must press <kbd>G</kbd> twice)
*   Press <kbd>/</kbd> followed by a search term and <kbd>Enter</kbd> to find and highlight matches
    *   <kbd>n</kbd> jumps to the next match
    *   <kbd>N</kbd> jumps to the previous match
*   <kbd>q</kbd> or <kbd>:</kbd><kbd>q</kbd> to quit
*   <kbd>h</kbd> to open the help page; press <kbd>q</kbd> to go back to the log


*Protip If you don't see the extra branch/commit name information in the output of `git log` as well as an abbreviated Git commit ID, enable it with these commands:*

```bash
git config --global log.decorate true
git config --global log.abbrevCommit true
```

### `git log --stat`

Shows a brief summary for each commit of which files changed and the magnitude of their changes.


### `git log --patch`

Display a diff describing the changes recorded in each commit


### `git log --stat --patch`

Show both the stat and the patch at once


### `git log OBJECT`

*   This form of `git log` displays the commit history beginning from the commit denoted by `OBJECT` back to the genesis of the repository.
*   Any commits which were added *after* `OBJECT` are not listed in this output.
    *   `OBJECT`s stored in Git's database are *singly-linked* to a "parent" object
        *   Thus, an object can always find its parent, but they cannot easily track down their children
        *   This is by design!  Once an object has been created, its SHA-1 ID cannot be changed.  To update it so it can point to a newly created child would require that a new SHA-1 ID be generated.  Then *its* parent would need a new SHA-1 ID, and so on.


### `git log :/pattern`

*   A colon, followed by a slash, followed by *pattern*, names a commit whose *commit message* matches the specified pattern.
*   When several commits would match, this returns the *youngest* matching commit.
*   Surround `pattern` with quote marks if it contains spaces or other characters with significance to the shell (e.g. `$`, `?`, `*`, `[]`, etc.).
    *   Alternatively, you can use a dot `.` in place of spaces or special characters; a dot matches *any* character.
    *   Specifically, `pattern` is interpreted as a [regular expression](https://www.regexone.com/).
*   Examples (try these after cloning https://gitlab.cs.usu.edu/erik.falor/primetime):
    *   `git log :/"keep last 257 lines"`
    *   `git log :/"web/: <title> matches the banner"`
        *   In this example the first `:/` tells Git to perform a text search
        *   The next `/:` is part of the string to search for
    *   `git log :/web/:..title..matches.the.banner`   *look ma, no quotes!*



## Discarding Uncommitted Changes

If you don't like what the `git diff` shows, you can discard those changes instead of permanently committing them.

```bash
git restore FILENAME...
```

The `git status` command will remind you that the `git restore` command
restores one or more files to their state at the last commit.  To throw away
changes to your `README.md` since the last commit:

```bash
git restore README.md
```

To throw away all changes to all files **under the current directory** since the
last commit:

```bash
git restore .
```

This command restores all files in the **entire repository** to their state
as of the latest commit:

```bash
git restore :/
```

`git restore` is a new-ish command in Git.  In case you are ever stranded on a
system with an old version of Git you should know how to do this the
"old-fashioned way", which was to use `git checkout` followed by a two hyphens
`--` and filename(s):

```bash
git checkout -- README.md
git checkout -- *.py task0.jpg task1.jpg
```

The "old-fashioned way" still works in modern Git.


### Discarding Changes In The Staging Area (A.K.A. The Index)

When you run `git add FILENAME...`, the changes to the affected files are said to be "staged" or *put into the staging area*, or *added to the index*.  The *index* isn't another place on your computer that you can go into, like a directory; the files you have changed are still right here.  The index is better thought of as a temporary *pre commit* that isn't yet part of the repository's permanent record; you cannot see them by running `git log`.

If you ran `git add FILENAME...` but have decided that you do not want to go through with it, you can "unstage" those changes by running `git restore` with the `--staged` argument:

```bash
git restore --staged FILENAME...
```

This command puts `README.md` back into the "Changes not staged for commit" state:

```bash
git restore --staged README.md
```

From here you can completely discard your recent changes to `README.md` with `git restore README.md`.



## Temporarily Stashing Uncommitted Changes

Use `git stash` when you want to record the current state of the working directory and the index, but want to go back to a clean working directory. The command saves your local modifications away and reverts the working directory to match the `HEAD` commit.

The changes are saved in the same way as an ordinary commit, but are not stored in the history.  In other words, you cannot view stashed changes with `git log`.

`git stash` lets you discard changes with the option of digging them out of the recycle bin later.

You can create, view, restore or discard stashed changes with the following commands:

### `git stash`

Stash the changes in the working tree, restoring the working tree to its `HEAD` state.  You can create as many stashes as you wish.  They are stored in a stack in the order in which you created them.


### `git stash list`

List the stack of stashed changes.


### `git stash show`

Display the names of files changed and the number of lines added/removed by the top-most stash in the stack.


### `git stash pop`

Apply to the working tree the changes stored in the stash entry at the top of the stack, and remote that stash object.  According to `git status`, these changes are 'not staged for commit'.


### `git stash apply`

Like `git stash pop`, but do not remove this stash from the stack.


### `git stash drop`

Discard the most recent stash.



## Tagging Commits

In Git, a **tag** is a human-friendly name for a commit object.

A tag always refers to the same commit, even after new commits are added to the repository.  This is in contrast to how the name `master` works.  `master` always refers to the latest commit in the master branch, and moves as you make new commits.  A tag, once created, "sticks" to its commit.

A tag exists only in your local repository unless you push it.  This is because tags are intended for your own personal use.  You must explicitly push tags to make them available for other users of the repository.

Identifying version numbers of released software is the most common use case for "public" tags.


### `git tag`
### `git tag -l [PATTERN]`

*   When run without arguments this command lists existing tags 
*   In the 2nd form, an optional `PATTERN` can be specified
    -   This lets you filter the list of tag names down to ones that interest you
*   Remember that tags only exist in the local repository *unless* you push them!


### `git tag TAGNAME`

*   Gives the name `TAGNAME` to the current commit (`HEAD`)
    *   The tag sticks to this commit and does not move when you make new commits
*   One commit can have 0, 1, 2, 3, ... or more tags
    *   `TAGNAME` can only refer to one commit at a time


### `git tag TAGNAME OBJECT`

*   Apply the name `TAGNAME` to the commit identified by `OBJECT`
*   `OBJECT` can refer to any commit object anywhere in your repository; it doesn't have to be the current `HEAD` object


### `git tag -d TAGNAME`

*   Remove a tag from a commit in the local repository
*   This command does not modify or delete the commit; it just removes the name
    *   Use this command to move `TAGNAME` to a different commit


### `git push REMOTE TAGNAME ...`

*   Send the name of one or more tags along with the commits they point to over to the `REMOTE` repository
*   Remember that tags only exist in the local repository *unless* you push them!


### `git push REMOTE --tags`

*   Like the above command, but send **all defined tags** to `REMOTE`


### `git push --delete REMOTE TAGNAME ...`

*   Remove the named tags from the `REMOTE` repository
*   Use this if you tagged the wrong commit and want to reuse that tag name on a different commit


### How To Move A Tag To A Different Commit

Git doesn't have a dedicated *move tag* command.  Changing which commit a tag applies to boils down to "remove the tag, then re-apply it elsewhere".  How you do this depends on whether you have **pushed** the tag to a remote repository.

*   If you **have not** pushed the tag to a remote repository:
    0.  `git tag -d TAGNAME` to remove the tag
    1.  `git tag TAGNAME OBJECT` to apply it to the desired commit
*   If you **have already** pushed the tag to a remote repository:
    0.  Do the above 2 steps
    1.  `git push --delete REMOTE TAGNAME` to remove the tag from its old position in the remote repository
    2.  `git push REMOTE TAGNAME` to tell the remote repository where the tag now belongs


#### Example: Move the pushed tag `designed` from commit `9ba1ac3` to `3f94dab`

*Note: in this example commands are prefixed with the prompt character `$` to distinguish them from their output*

```bash
$ git tag -d designed
Deleted tag 'designed' (was 9ba1ac3)

$ git tag designed 3f94dab

$ git push --delete origin designed
remote: ***********************************************************************
remote: *           __  ________  __  _____                ____    _          *
remote: *          / / / / __/ / / / / ___/__  __ _  ___  / __/___(_)         *
remote: *         / /_/ /\ \/ /_/ / / /__/ _ \/  ' \/ _ \_\ \/ __/ /          *
remote: *         \____/___/\____/  \___/\___/_/_/_/ .__/___/\__/_/           *
remote: *                                         /_/                         *
remote: *  ,/         \,                                                      *
remote: * ((__,-"""-,__))                                                     *
remote: *  `--)~   ~(--`                                                      *
remote: * .-'(       )'-,                                                     *
remote: * `--`d\   /b`--`  Big Blue says:                                     *
remote: *     |     |                                                         *
remote: *     (6___6)  Your submission arrived Tue 05 Apr 2022 09:17:17 MDT   *
remote: *      `---`                                                          *
remote: *                                                                     *
remote: ***********************************************************************
To gitlab.cs.usu.edu:erik.falor/cs1440-falor-erik-assn5.git
 - [deleted]         designed

$ git push origin designed
remote: ***********************************************************************
remote: *           __  ________  __  _____                ____    _          *
remote: *          / / / / __/ / / / / ___/__  __ _  ___  / __/___(_)         *
remote: *         / /_/ /\ \/ /_/ / / /__/ _ \/  ' \/ _ \_\ \/ __/ /          *
remote: *         \____/___/\____/  \___/\___/_/_/_/ .__/___/\__/_/           *
remote: *                                         /_/                         *
remote: *  ,/         \,                                                      *
remote: * ((__,-"""-,__))                                                     *
remote: *  `--)~   ~(--`                                                      *
remote: * .-'(       )'-,                                                     *
remote: * `--`d\   /b`--`  Big Blue says:                                     *
remote: *     |     |                                                         *
remote: *     (6___6)  Your submission arrived Tue 05 Apr 2022 09:18:07 MDT   *
remote: *      `---`                                                          *
remote: *                                                                     *
remote: ***********************************************************************
To gitlab.cs.usu.edu:erik.falor/cs1440-falor-erik-assn5.git
 * [new tag]         designed -> designed
```


*Updated Fri Oct  3 2025*
