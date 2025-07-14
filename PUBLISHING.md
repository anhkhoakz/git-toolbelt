# Personal notes for publishing a new version

1. Update/check CHANGELOG.md
2. Tag the version with Git (e.g. `git tag --annotate v1.2.3`)
3. Push the tag out (`git push --tags`)
4. Go to <https://github.com/anhkhoakz/git-toolbelt/tags>
5. Create a release from a tag
6. Compute the SHA1 hash:
    `curl -L https://github.com/anhkhoakz/git-toolbelt/archive/vX.X.X.tar.gz | sha256sum`
7. `cd homebrew-tap`
8. Update URL + SHA256 value
