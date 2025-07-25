# Git Toolbelt

<div align="center">
  <img src="./img/git-toolbelt.png" width="376" height="409"
  alt="git-toolbelt logo" /><br>
</div>

## Installation instructions

```zsh
    brew tap anhkhoakz/tap
    brew install anhkhoakz/tap/git-toolbelt
```

Or if your prefer using from source, you can use:

Prerequisites:

- [uutils/careutils](https://github.com/uutils/coreutils)
- [fzf](https://github.com/junegunn/fzf)
- [just](https://github.com/casey/just)
- [fd](https://github.com/sharkdp/fd)

```zsh
    git clone https://github.com/anhkhoakz/git-toolbelt.git
    cd git-toolbelt
    just install # just.systems
```

If not using Homebrew, you will need to have [GNU coreutils][coreutils]
installed, for the `realpath` utility. Git for Windows users see [#29](https://github.com/nvie/git-toolbelt/issues/29).

Helper tools to make everyday life with Git much easier.  Commands marked with
⭐️ are my personal favorites and are commands I use almost every day.

Everyday helpful commands:

* ⭐️ [git-cleanup](#git-cleanup)
* [git-current-branch](#git-current-branch)
* [git-main-branch](#git-main-branch)
* ⭐️ [git-fixup](#git-fixup)
* ⭐️ [git-fixup-with](#git-fixup-with)
* ⭐️ [git-active-branches](#git-local-branches--git-remote-branches--git-active-branches)
* ⭐️ [git-diff-since](#git-diff-since)
* [git-local-branches](#git-local-branches--git-remote-branches--git-active-branches)
* [git-local-commits](#git-local-commits--git-has-local-commits)
* [git-merged / git-unmerged / git-merge-status](#git-merged--git-unmerged--git-merge-status)
* [git-branches-containing](#git-branches-containing)
* [git-recent-branches](#git-recent-branches)
* [git-remote-branches](#git-local-branches--git-remote-branches--git-active-branches)
* [git-remote-tracking-branch](#git-remote-tracking-branch)
* [git-repo](#git-root--git-repo)
* [git-root](#git-root--git-repo)
* [git-initial-commit](#git-initial-commit)
* ⭐️ [git-sha](#git-sha)
* [git-stage-all](#git-stage-all)
* [git-unstage-all](#git-unstage-all)
* [git-update-all](#git-update-all)
* [git-workon](#git-workon)
* ⭐️ [git-modified](#git-modified)
* ⭐️ [git-modified-since](#git-modified-since)
* ⭐️ [git-separator](#git-separator)
* ⭐️ [git-spinoff](#git-spinoff)
* ⭐️ [git-wip](#git-wip)

Statistics:

* [git-committer-info](#git-committer-info)

Commands to help novices out:

* [git-drop-local-changes](#git-drop-local-changes)
* [git-stash-everything](#git-stash-everything)
* ⭐️ [git-push-current](#git-push-current)
* [git-undo-commit](#git-undo-commit)
* [git-undo-merge](#git-undo-merge)

Commands that simplify scripting. These commands typically only return exit
codes and have no output.

* [git-is-repo](#git-is-repo)
* [git-is-headless](#git-is-headless)
* [git-has-local-changes / git-is-clean / git-is-dirty](#git-has-local-changes--git-is-clean--git-is-dirty)
* [git-has-local-commits](#git-local-commits--git-has-local-commits)
* [git-contains / git-is-ancestor](#git-contains--git-is-ancestor)
* [git-local-branch-exists](#git-local-branch-exists--git-remote-branch-exists--git-tag-exists)
* [git-remote-branch-exists](#git-local-branch-exists--git-remote-branch-exists--git-tag-exists)
* [git-tag-exists](#git-local-branch-exists--git-remote-branch-exists--git-tag-exists)

Advanced usage:

* [git-skip / git-unskip / git-show-skipped](#git-skip--git-unskip--git-show-skipped)
* [git-commit-to](#git-commit-to)
* [git-cherry-pick-to](#git-cherry-pick-to)
* ⭐️ [git-delouse](#git-delouse)
* ⭐️ [git-shatter-by-file](#git-shatter-by-file)
* ⭐️ [git-cleave](#git-cleave)

## git current-branch

Returns the name of the current branch, if any.  Why doesn't this come with git?

```bash
    $ git current-branch
    master
```

Alias to `git rev-parse --abbrev-ref HEAD`.

## git main-branch

Returns the name of the default main branch for this repository.  Historically
`master`, but could also be `main` if you've changed the default branch name.
Since there's no way of reliably telling what the default branch name is for
a repo, this script will probe for the existence of local branches named either
`main` or `master`.  The first one found is used.

```bash
    $ git main-branch
    master
```

## git sha

Returns the SHA value for the specified object, or the current branch head, if
nothing is provided.

```bash
    git sha <some-object>
```

Typical example:

```bash
$ git sha HEAD
f688d7543c5d52f5f78b3db1b0dd1616059299a4
$ git sha -s HEAD
f688d75
```

Shows the commit SHA for the latest commit.

## git modified

Returns a list of locally modified files.  In contrast to git status, it does
not include any detailed file status, and never includes non-existing files.

This makes it ideal for the following use-case:

```bash
vim (git modified)
```

If you want to locally modified files that are already staged, too, use:

```bash
vim (git modified -i)
```

## git modified-since

Like git-modified, but for printing a list of files that have been modified
since master (or whatever commit specified).  In contrast to git status, it
does not include any detailed file status, and never includes non-existing
files.

Opens all files modified on your branch (since you branched off `master`).

```bash
vim (git modified-since)
```

## git separator

Adds a commit with a message of only ---'s, so that it visually separates
commits in the history.  This is incredibly useful when doing more complex
rebase operations.  (They should be used as a temporary measure, and ideally
taken out of the history again when done rebasing.)

## git spinoff

Inspired by Magit's `spinoff` command.  Creates and checks out
a new branch starting at and tracking the current branch.  That
branch in turn is reset to the last commit it shares with its
upstream.  If the current branch has no upstream or no unpushed
commits, then the new branch is created anyway and the previously
current branch is not touched.

This is useful to create a feature branch after work has already
began on the old branch (likely but not necessarily "master").

## git push-current

Pushed the current branch out to `origin`, and makes sure to setup tracking of
the remote branch.  Shorthand for `git push -u origin <current-branch>`.

Accepts options, too, so you can use

```bash
git push-current -f
```

to force-push.

## git is-headless

Tests if `HEAD` is pointing to a branch head, or is detached.

## git diff-since

Shows the differences made on the current branch, compared to the main branch
(or the given branch).

## git local-branches / git remote-branches / git active-branches

Returns a list of local or remote branches, but contrary to Git's default
commands for this, returns them machine-processable.  In the case of remote
branches, can be asked to return only the branches in a specific remote.

For `git active-branches`, a branch is deemed "active" if its head points to
a commit authored in the last 3 weeks, by default. An arbitrary date can be
specified using either `git active-branches -s <date>` or `-a <date>`
(mnemonic: "since" or "after"), using any date format
[supported by `git log`][gitlog].

## git local-branch-exists / git remote-branch-exists / git tag-exists

Tests if the given local branch, remote branch, or tag exists.

## git recent-branches

Returns a list of local branches, ordered by recency:

```bash
$ git recent-branches
foo
master
bar
qux
```

## git remote-tracking-branch

Print the name of the remote tracking branch of the current or
given local branch name, if one exists.  Errors otherwise.

## git local-commits / git has-local-commits

Returns a list of commits that are still in your local repo, but haven't been
pushed to `origin`.  `git has-local-commits` is the scriptable equivalent that
only returns an exit code if such commits exist.

## git contains / git is-ancestor

Tests if X is merged into Y:

```bash
git contains X Y  # does X contain Y?
git is-ancestor X Y  # is X an ancestor of Y?
```

**CAVEAT:**
Even though they might look like opposites, `X contains Y` does not mean `not
(X is-ancestor Y)`, since (1) X and Y can point to the same commit, or the
branches may have no common history and thus be unrelated completely.

## git stage-all

Mimics the index / staging area to match the working tree exactly.  Adds files,
removes files, etc.

Alias to `git add --all`.

## git unstage-all

Unstages everything.  Leaves the working tree intact.

Alias to `git reset HEAD`.

## git undo-merge

Ever created a merge accidentally, or decided that you didn't want to merge
after all?  You can undo the last merge using `git undo-merge`.

## git undo-commit

Ever committed too soon, or by accident?  Or on the wrong branch?  You can now
undo your last commit and you won't lose any data.  All the changes in the
commit will be staged (like right before the commit) and the commit itself is
gone.

## git cleanup

Deletes all branches that have already been merged into the main branch. Keeps
other branches lying around.  Removes branches both locally and in the origin
remote.  Will be most conservative with deletions.

## git fixup

Amend all local staged changes into the last commit. Ideal for fixing typo's,
when you don't want to re-edit the commit message.

```bash
    git commit -m "Something cool."
    vim somefile.txt  # fix typo
    git add somefile.txt
    git fixup  # merge this little change back into the last commit
```

## git fixup-with

Interactively lets you pick a commit to fixup with.  (Uses `fzf` for the
interactive picking.  Use `brew install fzf` to install this tool separately.)
Use `-r` to trigger an interactive rebase right afterwards.

## git workon

Convenience command for quickly switching to a branch `<name>`. If such local
branch does not exist, but there is a remote branch named `origin/<name>`, then
a local branch is created and the remote is tracked.

## git delouse

Say you want to rebuild your last commit, but want to keep the commit message.
git delouse empties the last commit on the current branch and places all
changes back into the working tree.

Since the commit remains in history, you can now rebuild the commit by "git
amend"'ing or "git fixup"'ing, instead of making new commits.

## git shatter-by-file

Splits the last commit into N+1 commits, where N is the number of files in the
last commit.  The first commit is an empty commit with the original commit
message and author details, and the following commits add (or delete) one file
each, keeping the subject line of the original commit message.

After running `git shatter-by-file`, you'll typically want to run `git rebase
--interactive` to start fixing up changes to files, etc.  For that purpose, the
original commit message is kept in there (in the empty first commit), so make
sure to use it.

```bash
$ git branch
  master
* mybranch
$ git status
M foo.txt
M bar.txt
$ git add foo.txt
$ git commit-to master -m "Add foo to master."
$ git add bar.txt
$ git commit -m "Add bar to mybranch."
```

## git cleave

Splits the last commit into 2 or more commits. Takes one or more regex values
(which are fed to `grep -Ee`), and will split the last commit by file paths
matching each of the regexes.

For example:

```bash
git cleave client/ server/
```

Will split the last commit into 2 (or 3) commits. The first one will contain
all the files containing `client/`, the second will contain all the files
matching `server/`. If there are files that don't match either of those, then
a 3rd commit will be made with the "remainder".

Another example:

```bash
git cleave '.*\.js$'
```

This will split off all Javascript files from a commit.

## git commit-to

Ever been on a branch and really wanted to quickly commit a change to
a different branch?  Given that this is possible without merge conflicts, git
commit-to will allow you to do so, without checking out the branch necessarily.

```bash
$ git branch
  master
* mybranch
$ git status
M foo.txt
M bar.txt
$ git add foo.txt
$ git commit-to master -m "Add foo to master."
$ git add bar.txt
$ git commit -m "Add bar to mybranch."
```

## git cherry-pick-to

Every been on a branch, just made a commit, but really want that commit
available on other branches as well? You can now cherry-pick this commit to any
branch, staying on the current branch. (Given the change won't lead to a merge
conflict.)

```bash
$ git branch
  master
* mybranch
$ git add foo.txt
$ git commit -m "Really useful thing."
$ git cherry-pick-to master HEAD
$ git branch  # did not switch branches
  master
* mybranch
```

## git is-repo

Helper function that determines whether the current directory has a Git repo
associated to it.  Scriptable equivalent of `git repo`.

## git root / git repo

`git root` prints the root location of the working tree.

```bash
$ cd /path/to/worktree
$ cd some/dir/in/worktree
$ pwd
/path/to/worktree/some/project/dir
$ git root
/path/to/worktree
```

`git repo` prints the location of the Git directory, typically `.git`, but
could differ based on your setup.  Will return with a non-zero exit code if not
in a repo.

```bash
$ cd /path/to/my/worktree
$ git repo
.git
$ cd /tmp
$ git repo
fatal: Not a git repository (or any of the parent directories): .git
```

## git initial-commit

`git initial-commit` prints the initial commit for the repo.

```bash
$ git initial-commit
48c94a6a29e9e52ab63ce0fab578101ddc56a04f
```

## git has-local-changes / git is-clean / git is-dirty

Helper function that determines whether there are local changes in the working
tree, by returning a 0 (local changes) or 1 (no local changes) exit code.

## git drop-local-changes

Don't care about your local working copy's state and really want to revert back
to whatever is recorded in the history? git drop-local-changes lets you do
this.

This covers aborting rebases, undoing partial merges, resetting the index and
removing any unknown local files from the work tree. Anything that is already
committed remains safe.

??? issue a git pull, too? Typical beginners will want this.

## git stash-everything

The stash behaviour you (probably) always wanted.  This actually stashes
everything what's in your index, in your working tree, and even stashes away
your untracked files, leaving a totally clean working tree.

Using "git stash pop" will recover all changes, including index state, locally
modified files, and untracked files.

## git update-all

Updates all local branch heads to the remote's equivalent.  This is the same as
checking out all local branches one-by-one and pulling the latest upstream
changes.  Will only update if a pull succeeds cleanly (i.e. is a fast-forward
pull).

## git-merged / git-unmerged / git-merge-status

This trio of subcommands makes it easy to inspect merge status of local
branches.  Use them to check whether any local branches have or haven't been
merged into the target branch (defaults to master).

git-merge-status is a useful command that presents both lists in a single
overview (not for machine processing).

## git-branches-containing

This command, "git branches-containing [<object>]" returns a list of branches
which contain the specified '<object>' (defaults to 'HEAD').

git-branches-containing is useful to see if a branch has been merged, and,
if so, which releases contain the feature/fix (if you use release
branches).

## git-committer-info

Shows contribution stats for the given committer, like "most productive day",
"most productive hour", "average commit size", etc.

## TODO: git force-checkout

Don't care about your local working copy's state and really want to switch to
another branch? git force-checkout lets you do this.

Switching branches can be prevented by git. For good reasons, mostly. Git is
designed to prevent you from losing data potentially. Examples are there are
local unmerged files, or some files that would be overwritten by doing the
checkout.

By using force-checkout you basically give git the finger, and check out
a branch anyway. **You do agree to lose data when using this command.**

```bash
$ git checkout master
error: Your local changes to the following files would be overwritten by checkout:
    foo/bar.txt
Please, commit your changes or stash them before you can switch branches.
Aborting
$ git force-checkout master
Switched to branch 'master'
```

## git conflicts

Generates a summary for all local branches that will merge uncleanly—i.e. will
lead to merge conflicts later on.

```bash
$ git branch
develop
* mybranch
master
other-branch
$ git conflicts
develop... merges cleanly
master...  merges cleanly
other-branch... CONFLICTS AHEAD
```

## git-skip / git-unskip / git-show-skipped

Git supports marking files "skip worktree", meaning any change in the file
locally will not be shown in status reports, or be added when you stage all
files.  This feature can be useful to toggle some switches locally, or
experiment with different settings, without running the risk of accidentally
committing this local data (that should remain untouched in the repo).

Notice that status reports won't show these files anymore, so it's also easily
to lose track of these marked assumptions, and you probably run into weird
issues if you don't remember this. (This is the reason why I put these scripts
in the "advanced" category.)

Basic usage:

```bash
$ git status
 M foo.txt
 M bar.txt
 M qux.txt
$ git skip foo.txt
$ git status
 M bar.txt
 M qux.txt
$ git show-skipped
foo.txt
$ git commit -am 'Commit everything.'
$ git status
nothing to commit, working directory clean
$ git is-clean && echo "clean" || echo "not clean"
not clean
$ git unskip -a
$ git status
 M foo.txt
```

As you can see, `git-is-clean` is aware of any lurking "skipped" files, and
won't report a clean working tree, as these assumed unchanged files often block
the ability to check out different branches.

## git wip

Commits all local changes under a commit message of "WIP". Great for quickly
creating "savepoint" commits.  If there is a mix of staged changes, and
unstaged changes, and new files, will commit each of these as a separate
commit, all titled "WIP". Effectively, running `git-wip` once will potentially
lead to anywhere between 0 and 3 "WIP" commits being created.

[coreutils]: https://www.gnu.org/software/coreutils/
[gitlog]: https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History#_limiting_log_output
