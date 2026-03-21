# Git Troubleshooting Guide

*Note: In this document I use the terms **project** and **repository** interchangeably.  GitLab prefers the term project, while the Git command-line program uses repository.*

*Note: In the code examples below a dollar sign `$` or percent sign `%` represents your shell prompt. This is to distinguish commands that you will input from their output. Do not type the `$` or `%` when you run these commands yourself.*


Table of Contents
=================

* [The project you were looking for could not be found](#the-project-you-were-looking-for-could-not-be-found)
* [The namespace you were looking for could not be found](#the-namespace-you-were-looking-for-could-not-be-found)
* [You are not allowed to push code to this project](#you-are-not-allowed-to-push-code-to-this-project)
* [Changing a project's URL on GitLab](#changing-a-projects-url-on-gitlab)
* [I've already taken this class and my old repositories are getting in the way](#ive-already-taken-this-class-and-my-old-repositories-are-getting-in-the-way)
* [Deleting a project from GitLab](#deleting-a-project-from-gitlab)
* [Creating an empty project on GitLab](#creating-an-empty-project-on-gitlab)
* [Renaming a project in GitLab](#renaming-a-project-in-gitlab)
* [I have created a Git repository inside another repository](#i-have-created-a-git-repository-inside-another-repository)
* [Git asks for my username and password, but freezes when i enter the password](#git-asks-for-my-username-and-password-but-freezes-when-i-enter-the-password)
* [I've created an SSH key, but GitLab still asks for a password](#ive-created-an-ssh-key-but-gitlab-still-asks-for-a-password)
* ["Permission denied" when I use 'git init' or 'git clone'](#permission-denied-when-i-use-git-init-or-git-clone)
* [SSL certificate problem: unable to get local issuer certificate](#ssl-certificate-problem-unable-to-get-local-issuer-certificate)
* ["git status" shows dozens of untracked files or says "Operation not permitted"](#git-status-shows-dozens-of-untracked-files-or-says-operation-not-permitted)
* [Git gives an 'xcrun error' on macOS](#git-gives-an-xcrun-error-on-macos)


------------------------------------------------------------

## The project you were looking for could not be found

> ... or you don't have permission to view it.


This error is often accompanied by this message:

> Please make sure you have the correct access rights and the repository exists


While it *could* be the case that you are trying to access a private repository for which you lack access privileges, this error message is also given when you use an incorrect URL with `git`.

The most common cause of this error is not putting your GitLab **USERNAME** into the URL.  The part of the URL following the server's hostname is **not** your firstname *dot* lastname; it is your **username**.   My GitLab username is `erik.falor`, which just happens to be my first and last names.  Your username probably doesn't follow that pattern, and is most likely your A Number `a01234567`.  GitLab usernames **never** include at signs `@`.

Check that the username in the middle of the URL shown by `git remote -v` matches your username on GitLab.  You can see your username by clicking on your avatar in the upper-right corner of GitLab while logged in.

The `set-url` subcommand of `git remote` lets you change a URL.  

```
Change this:                       vvvvvvvvvvvvvvvvvv
             git@gitlab.cs.usu.edu:firstname.lastname/cs1440-lastname-firstname-assn0.git

into this:                         vvvvvvvvv
             git@gitlab.cs.usu.edu:a01234567/cs1440-lastname-firstname-assn0.git
```

like this:

```bash
$ git remote set-url origin git@gitlab.cs.usu.edu:a01234567/cs1440-lastname-firstname-assn0.git
```


### HTTPS in the repository's URL

Alternatively, you may have somehow cloned a repository from an HTTPS address.
It is straightforward to transform the repo's `https://` URL used by a browser
into an SSH URL like this:

0. Replace `https://` with `git@`
1. Replace the 1st `/` after the hostname with `:`

```
Change this: vvvvvvvv                 v
             https://gitlab.cs.usu.edu/erik.falor/sp24-cs1440-lecturenotes.git
                 git@gitlab.cs.usu.edu:erik.falor/sp24-cs1440-lecturenotes.git
       into: ^^^^^^^^                 ^
```

It is common to forget to change that first `/` into a `:`.  Make sure the remainder of the URL is spelled correctly.

For example, to change `origin` to point to the SSH URL, run this command:

```bash
$ git remote set-url origin git@gitlab.cs.usu.edu:erik.falor/sp24-cs1440-lecturenotes.git
```



## The namespace you were looking for could not be found

> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights and the repository exists.

The solution is the same as the previous problem: [The project you were looking for could not be found](#the-project-you-were-looking-for-could-not-be-found)



## You are not allowed to push code to this project

You attempted to push to a project that you are not permitted to change.  This usually happens because you forgot to:

0.  set up a new `origin` remote that points to your own account
1.  run `git push -u origin master` after creating your new `origin` remote

In both cases your `git push` command tried to send your code to the professor's GitLab account.

To fix this

0.  Run `git remote -v` to make sure that your `origin` remote points to your account
1.  Run `git push -u origin master` to tell Git that `origin` is the new default destination for pushes instead of `old-origin`



## Changing a project's URL on GitLab

If you gave your project the wrong URL you can fix it in GitLab before the due date with no penalty.

*Note that the project's **URL** is different from its **name**; see the next tip for details about renaming a project*

*   **Steps to take on the GitLab website**
    1.  Navigate to the project on the web and click the gear icon at the bottom of the left sidebar (the Settings menu), and click *General*
    2.  Scroll all the way to the bottom until you find the **Advanced** section.  Click `Expand`
        *   _Do not change the **Project name** that you see at the top of this page!_
    3.  Scroll to the middle of the **Advanced** section until you see a box titled **Change path**.  Put the correct project name into this box and click the `Change path` button.
*   **Steps to take on your computer**
    1.  Update your project's remote URL.  Assuming your GitLab remote is nicknamed `origin`, this command will update the URL (substitute your own details in this command):
        ```bash
        $ git remote set-url origin git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-projN
        ```
    2.  After changing the URL you *must* make another push before my submission collection program will notice the change.
        *   You may need to edit a file and create a new commit so that you can do a push.
        *   If you don't know what to change, just make a small, cosmetic change in one of the README.md files.



## I've already taken this class and my old repositories are getting in the way

Follow these instructions if `git push` shows error messages like this:

```
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'gitlab.cs.usu.edu:erik.falor/test-repo'
hint: Updates were rejected because the remote contains work that you do not
hint: have locally. This is usually caused by another repository pushing to
hint: the same ref. If you want to integrate the remote changes, use
hint: 'git pull' before pushing again.
```

This is happening because a new repository created this semester is clashing with an existing repository that was created previously.

**You need to remove the old repositories from the GitLab server before you can push this semester's new work.**

0.  Make backups of anything you want to keep before removing old repositories from the server,
    *   This is as easy as cloning them onto your own computer.
    *   Clone them into a backup location on your computer so you don't get them mixed up with this semester's work.
1.  Then, follow the instructions under the next section, [Deleting a project from GitLab](#deleting-a-project-from-gitlab).
    *   Focus on repositories with paths that match the pattern `USERNAME/cs1440-LAST-FIRST-projN`.  Your other repositories won't get in the way.

Afterward, you will be able to `git push` into your new repository.



## Deleting a project from GitLab

This is done through the GitLab web interface.

0.  Navigate to the project on the web and click the gear icon near the bottom of the left sidebar (the Settings menu).  Click *General*
1.  Scroll all the way to the bottom until you find the **Advanced** section.  Click the `>` symbol to expand this section.
2.  Scroll all the way to the bottom one more time to find the red **Delete project** button; click it.
3.  Enter the name of the project into the text box and click **Yes, delete project** button to confirm.

You may now create a new project with the same URL.  Follow the instructions under the next section, [Creating an empty project on GitLab](#creating-an-empty-project-on-gitlab).



## Creating an empty project on GitLab

Follow these instructions closely to create a new repository on GitLab that can receive an already-existing repository from your computer.  If you miss one of these steps, GitLab will not allow you to push your code into the project that you just created, forcing you to go back and try again.

0.  Navigate to GitLab on the web and open the sidebar on the left edge of the window.
1.  Click the `+` icon next to your avatar, then select **New project/repository**
2.  Click **Create blank project**
3.  Input the name of the project in the **Project name** text box
4.  Under the *Project URL* heading, click drop-down titled **Pick a group or namespace** and select your username
5.  Under *Project Configuration* un-check **Initialize repository with a README**
    -   This is the crucial step! If GitLab initializes your repository with a README, then you will need to start over!
6.  Click **Create project**
7.  Back on your computer, you now add or set the remote URL, if needed:
    -   Add URL to the `origin` remote
        ```bash
        $ git remote add origin git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-projN
        ```
    -   Update the URL the `origin` remote points to
        ```bash
        $ git remote set-url origin git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-projN
        ```
8.  Finally, push your code into the new repository with this command:
    ```bash
    $ git push -u origin master
    ```



## Renaming a project in GitLab

For grading purposes, the name of your project on GitLab doesn't matter.  Your project's **URL** must follow a strict naming convention so that your grader can find it.

However, if you do wish to change its name, follow these steps:

0.  Navigate to the project on the web and click the gear icon at the bottom of the left sidebar (the Settings menu), and click *General*
1.  The very first setting you will see is **Project name**
2.  After changing this string click the `Save Changes` button



## I have created a Git repository inside another repository

You may have noticed that `git status` succeeded when you expected it to say this:

```
fatal: not a git repository (or any of the parent directories): .git
```

Or, you might find `git status` reports a different set of changed files depending on which directory you are in.

Either of these occurrences are symptoms of placing one Git repository inside another one, a situation that I call *Gitception*:

![](./assets/gitception.png)

Just like the movie, this can be very disorienting!  To fix it, you must separate the Git repositories from each other.  There are three possibilities:

0.  The *inner* repository is unnecessary.  Locate its `.git` directory and remove it.
1.  The *outer* repository is unnecessary.  Locate its `.git` directory and remove it.
2.  Both repositories should be kept.  Locate the inner repository and move it outside of the outer repository.  In what was formerly the outer repository run `git commit -am "..."` to record the removal of the inner repository.

Use caution if you decide to remove a `.git` directory.  If you remove the wrong one, you may destroy important project history.  It is okay to reach out to a TA or the instructor for help.



## Git asks for my username and password, but freezes when I enter the password

Git isn't frozen; your keystrokes are merely hidden from the screen to prevent a passerby from reading your password.  Type your password as usual and press Enter.



## I've created an SSH key, but GitLab still asks for a password

GitLab won't ask for a password if it has a copy of the SSH public key that matches a key on your local machine.

0.  Check that you aren't trying to push your code to the wrong website.
    *   The URL shown by the command `git remote -v` should contain **gitlab.cs.usu.edu** and your username.
1.  Ensure that you have actually generated a public key on your system.
    *   Look for a subdirectory named `.ssh` under your home folder.
    *   It should contain one or more files with the `.pub` extension.
        *   If no `.pub` files are present, use the [SSH Key Setup Tool](https://gitlab.cs.usu.edu/duckiecorp/ssh-key-setup) to make and install it.
2.  SSH prefers to use a public key called `id_rsa.pub` before one called `id_ed25519.pub`.
    *   If you have both public keys on your local machine, try importing the both to GitLab.
3.  Make sure that you're not logged in to **gitlab.com** instead of **gitlab.cs.usu.edu**
    *   An SSH key imported to **gitlab.com** does not grant access to **gitlab.cs.usu.edu**, and vice-versa.
4.  Verify that the contents of the public key file on your computer matches what is in your GitLab account.
    *   Visit the [SSH Keys](https://gitlab.cs.usu.edu/-/user_settings/ssh_keys) page on GitLab to see the list of key names and fingerprints.
        *   SSH keys may have an expiration date; if your key has expired, remove it from your computer and use the [SSH Key Setup Tool](https://gitlab.cs.usu.edu/duckiecorp/ssh-key-setup) to generate a new one.
        *   If GitLab has one or more keys, run this command in your shell to compare the *fingerprints* of your keys:
            *   `for key in ~/.ssh/*.pub; do ssh-keygen -E md5 -lf $key; done`
            *   The fingerprint looks like this: `d7:19:06:ce:c4:d4:54:9a:17:9c:77:d3:9e:c3:31:24`
        *   If there are no matches or if GitLab's list of SSH keys is empty, use the [SSH Key Setup Tool](https://gitlab.cs.usu.edu/duckiecorp/ssh-key-setup) to make and install a new one.



## "Permission denied" when I use 'git init' or 'git clone'

When running `git clone` you may see this error:

```
fatal: could not create work tree dir: Permission denied
```

`git init` may also tell you `Permission denied`.  This error means that git
cannot create files and directories in the current directory because your user
account does not have write privileges.  For instance, you will see this
message if you try to clone a repository directly into `C:\`.

Make sure that you're in your home directory or a subdirectory of your home and
try the command again.  Running the `cd` command with no arguments will always
return you to your home directory.



## SSL certificate problem: unable to get local issuer certificate

Pushes to and clones from the GitLab server via an HTTPS-style URL are failing with an error message mentioning an SSL certificate.

This is happening because the SSL library included with your installation of Git does not trust the certificate authority which issued the certificate for my GitLab server.  Most often it is students using Git+Bash for Windows, but this could happen on other platforms as well.

The best work-around is to use the SSH interface instead of HTTPS.  This involves creating an SSH key and changing the remote repository's URL over to an SSH-style address with the `git remote set-url` command.  You will find a page on Canvas called "Creating your account on GitLab and adding an SSH key".  It contains a video that walks you through the process.

After you've imported your SSH key into GitLab, you will be given the option to use an SSH-style URL.

0.  You will find this URL on your repository's GitLab page by clicking the blue "Clone" drop-down button at the upper-right of the page.
1.  Copy the URL listed in the "Clone with SSH" box
2.  In your command shell you will use another form of the `git remote` command to change the URL (substitute your own details in this command):
    ```bash
    $ git remote set-url origin git@gitlab.cs.usu.edu:USERNAME/cs1440-LAST-FIRST-assn#
    ```
3.  Run `git push` to verify that git can talk to the remote GitLab server.


## "git status" shows dozens of untracked files or says "Operation not permitted"

If you see something like this when you run `git status`, you have inadvertently made your home directory into a Git repository:

```bash
user@MacBook ~ % git status
warning: could not open directory '.Trash/': Operation not permitted
warning: could not open directory 'Documents/': Operation not permitted
warning: could not open directory 'Downloads/': Operation not permitted
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .CFUserTextEncoding
        .DS_Store
        .gitconfig
        .lesshst
        .ssh/
```

The giveaway is the tilde `~` in the prompt above.  The tilde symbol is an abbreviation for your home directory.  Previously, you ran `git init` while your shell was sitting in your home directory.  The solution is straightforward: simply remove the unnecessary hidden `.git/` directory from your home:

```bash
user@MacBook % rm -rf $HOME/.git
```

Your home directory should never be a Git repository; instead, you should make individual subdirectories into repositories.



## Git gives an 'xcrun error' on macOS

As of macOS Catalina you may run into a few errors when trying to use the Terminal application or any command line tools that are built-in.  The first error you may run into is encountered when you run the `git` command, and it looks like this:

```bash
% git
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

This is because by default command line tools are installed with Xcode.  Beginning with macOS Catalina there is a new terms and conditions agreement that has to be accepted. To install/update the built-in command line tools and accept the new agreement run:

```bash
% xcode-select --install
```

This will open a window with the new terms and agreements for developer tools.  When you accept it will open up the install/update window and it will download and install/update the command line tools from Xcode.



*Updated Mon Oct 13 2025*
