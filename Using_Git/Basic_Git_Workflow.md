# Basic Git Workflow

Once you have cloned a project onto your computer, follow these instructions to commit and push your changes.

If you haven't gotten Git installed on your computer or haven't cloned the repository, read [Git Repository Setup](./Repository_Setup.md) instead.


## Add And Commit Changes Made In The Repository

0.  Enter the directory containing the newly cloned repository.
    ```bash
    $ cd cs1440-LAST-FIRST-assn0
    ```

1.  Edit one or more files and save your changes

2.  In your command shell ask `git` about the status of your repository:
    ```bash
    $ git status
    ```

3.  Run `git add` to add the changes you made to the staging area.  There are a few ways to do this:
    *   Stage changes made to a specific file (such as `README.md`):
        ```bash
        $ git add README.md
        ```
    *   Stage changes to all files in the current directory:
        ```bash
        $ git add .
        ```
    *   Stage changes to all files in the entire repository:
        ```bash
        $ git add :/
        ```

4.  Check the status of your repository again; it should tell you that you have changes ready to be committed.
    ```
    $ git status
    ```

5. You're ready to permanently commit to these changes.  Use the `-m` option to add a brief message (between double quotes) about this change.
    ```
    $ git commit -m "Fixed a bug and tested the changed code"
    ```

6. Get the status of your repository once more; the directory should be "clean".
    ```
    $ git status
    ```

7. Review the commit history of your repository.
    ```
    $ git log
    ```



## Send Your Code To The GitLab Server

Now you're ready to put your code up on the web, but you don't need to open your browser.  The `git` command can do it all from the command line.

### Create Connection To The Remote Repository

*If you followed the instructions on the assignment page when you cloned the starter code, you may skip most of these steps.*

Run `git remote -v` to see if there are already remote servers connected to your repository.


*   If you see this output, you may skip ahead to [Push Commits To The GitLab Server](#push-commits-to-the-gitlab-server):
    ```bash
    $ git remote -v
    origin	git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0 (fetch)
    origin	git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0 (push)
    old-origin	git@gitlab.cs.usu.edu:duckiecorp/cs1440-falor-erik-assn0 (fetch)
    old-origin	git@gitlab.cs.usu.edu:duckiecorp/cs1440-falor-erik-assn0 (push)
    ```
*   If you see this output, expand the *Configure A Remote Repository Under Your Own GitLab Account* section and follow its instructions:
    ```bash
    $ git remote -v
    origin	git@gitlab.cs.usu.edu:duckiecorp/cs1440-falor-erik-assn0 (fetch)
    origin	git@gitlab.cs.usu.edu:duckiecorp/cs1440-falor-erik-assn0 (push)
    ```


<details>
<summary><h4>Configure A Remote Repository Under Your Own GitLab Account</h4></summary>

0.  Rename `origin` to `old-origin`
    ```bash
    $ git remote rename origin old-origin
    ```

1.  Define the name that your repository will have on the GitLab server.  The name you choose in this step becomes part of the URL (a.k.a. internet address) for your repository.  *This is the name that matters!*  This name must follow the course guidelines.  If it doesn't match the expected pattern I will not be able to find your repository on GitLab.  It will be as though you did not turn it in.
    *   The pattern has four parts, in this order, separated with hyphens `-`:
        *   Course number.  In this class use `cs1440`.
        *   Your last name (if you have two last names, separate them with hyphens).
        *   First name (if you have two first names, separate them with hyphens).
        *   `assn` plus the assignment number.
    *   For example, `cs1440-LAST-FIRST-assn0` is appropriate for my Assignment #0 submission.
    *   *Note* this name does *not* need to match the name of the repository's directory on your own computer.
    *   Do not take any liberties with this pattern.  I wrote a program to go out and find your submissions.  It is a dumb program that is easily confused.

2.  Create a remote repository called `origin` that points to the URL for your repository on the GitLab server.  This will be an SSH URL; it looks a little different than the web addresses you are familiar with.  An SSH URL has four parts:
    *   The username `git`, followed by `@`
    *   The address to the GitLab server `gitlab.cs.usu.edu`, followed by `:`
    *   Your username on GitLab (in the example below I use `USERNAME` as a placeholder), followed by `/`
    *   The repository name you defined in the previous step

    For example: `git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0`

    Use the `git remote add` command to associate the nickname `origin` to the complete URL.  Pay attention to the `@`, `:` and `/` in this URL:

    ```bash
    $ git remote add origin git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0
    ```

3.  Run `git remote -v` to make sure everything looks okay:
    ```bash
    $ git remote -v
    origin	git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0 (fetch)
    origin	git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0 (push)
    old-origin	git@gitlab.cs.usu.edu:duckiecorp/cs1440-falor-erik-assn0 (fetch)
    old-origin	git@gitlab.cs.usu.edu:duckiecorp/cs1440-falor-erik-assn0 (push)
    ```

#### Protip: If you spelled `origin` wrong, you can fix it with `git remote rename`

*   If the remote's name is `origin` and the URL is correct, you might just try pushing your code.  Just continue following the steps above.  If that doesn't work...
*   If you spelled `origin` wrong, you may change it with `git remote rename`:
    ```bash
    $ git remote rename origin old-origin
    ```
    I should point out that there is nothing special about the name `origin`; it's just a Git tradition.  You can submit your work to my server under any name you please.

#### Protip: If you made a typo in the URL, you can fix it with the `git remote set-url` command

This applies to you if `git push` tells you that your project cannot be found or you lack permission to access it.

*   If the name of the remote server is `origin`, but the URL is wrong, fix it with `git remote set-url`:
    ```bash
    $ git remote set-url origin git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0
    ```
*   If the remote repository already exists on GitLab but contains the wrong stuff, you can [delete it](./Troubleshooting.md#deleting-a-repository-from-gitlab).


</details>


### Push Commits To The GitLab Server

Run `git push` to upload all of your code to the GitLab server under the nickname `origin`.  You will see an ASCII art receipt if this works.  If you do not see this image, contact the instructor or a TA for help.

```bash
$ git push -u origin --all
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 270 bytes | 270.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
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
remote: *     (6___6)  Your submission arrived Thu 22 Aug 2024 01:07:26 MDT   *
remote: *      `---`                                                          *
remote: *                                                                     *
remote: ***********************************************************************
To gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```


## Double-Check That Everything Worked As Expected

0.  Visit your repository online using your web browser.  Do this by converting the SSH URL into a familiar HTTPS address.
    *   Replace `git@` with `https://`
    *   Replace the `:` separating your username from the repository's name with `/`.
    *   **Before** `git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn0`
    *   **After** `https://gitlab.cs.usu.edu/USERNAME/cs1440-LAST-FIRST-assn0`

1.  You should not see the message **The repository for this project is empty**; instead, you should see a listing of files in your repo and the contents of `README.md`.

2.  Double-check that *all* of the files that you expect to see are present, including your `.gitignore`.  Make sure that *no* files that should *not* be part of your project are present
    *   What you see on this page is what we will see when we grade your work.

3.  Triple-check that everything works by cloning your project back to your computer.  This step replicates what we'll do when we grade your work.  What you see here is what we will see when we grade your submission.
    *   Use the `cd` command to go to a new location on your computer, one that is not associated with your project.
    *   Run `git status` to make sure you're not already in a git repository (you want to see a **fatal** error here).
    *   Run `git clone` along with the SSH URL to your repository to re-download it here.
    *   The `git clone` command creates a new directory with the full name of your repo on GitLab (e.g. `cs1440-LAST-FIRST-assn0`).
    *   `cd` into this directory to look around, execute your program, run your tests, etc.  Make sure everything looks good.



## Help! I'm still having some troubles with Git

See the [Git Troubleshooting Guide](./Troubleshooting.md) for solutions to the most common problems.


*Updated Tue Oct  8 2024*
