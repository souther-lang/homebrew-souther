# Souther Homebrew tap

The [Souther](https://github.com/souther-lang/souther) compiler and CLI, installed from the jar
attached to each GitHub Release.

```sh
brew install souther-lang/souther/souther
```

Or tap first, then install by bare name:

```sh
brew tap souther-lang/souther
brew install souther
```

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "souther-lang/souther"
brew "souther"
```

## What it installs

`souther.jar` goes into the formula's `libexec`, and `bin/souther` is a launcher that runs it with
`-Xss4m` — the stack the compiler is supported on, since every phase descends what it builds by
recursion.

The launcher points `JAVA_HOME` at the `openjdk` this tap depends on. Souther's output is pinned to
the Java 25 class-file version, so the launcher asks for 25 or later. An existing `JAVA_HOME` in the
environment wins, so a machine that already has a JDK 25+ uses that one.

## Usage

```sh
souther                                        # the commands and their options
souther run hello.sou --input '"world"'
souther compile model.sou -d out
souther doc --search "newtype"
```

## Releasing a new version

`brew bump-formula-pr` writes the bump and opens the pull request. The formula pins `version`, so
pass it — Homebrew would otherwise read a release candidate's URL as plain `0.1.0`:

```sh
brew bump-formula-pr souther-lang/souther/souther \
  --url=https://github.com/souther-lang/souther/releases/download/vX.Y.Z/souther.jar \
  --sha256=<the jar's sha256> \
  --version=X.Y.Z
```

It drops any `revision` line, since a new version supersedes the rebuild the revision stood for.
The `bottle do` block stays and is rewritten when the bottle is published.

`brew test-bot` then builds a bottle on macOS and Linux, installs from it and runs the formula's
test. Once that is green, label the pull request `pr-pull`. That publishes the bottles to a release
on this repository, commits the `bottle do` block, pushes to `main` and closes the pull request.

`--dry-run` is worth skipping: through Homebrew 6.0.18 it ends in ``Error: `brew audit` failed``
whatever the formula says, because the dry run returns the value the caller reads as a failed audit.
