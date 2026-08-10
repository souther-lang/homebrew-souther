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
