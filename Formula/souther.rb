class Souther < Formula
  desc "Small JVM language for building closed, executable business models"
  homepage "https://github.com/souther-lang/souther"
  url "https://github.com/souther-lang/souther/releases/download/v0.1.0-rc5/souther.jar"
  # Homebrew reads "0.1.0" out of a "v0.1.0-rc5" URL, so a pre-release has to say which one it is.
  # On a final tag this line is what `brew audit` calls redundant with the URL, and it comes off.
  version "0.1.0-rc5"
  sha256 "d04161c6de87291571b157eabdf327f6fe259b4dddf0edc728de453eef4336fc"
  license "EPL-2.0"
  # 0.1.0 was tagged before rc1, so every release candidate since is lower than it by semantic
  # versioning while being newer code. Without a scheme of its own the older tag outranks all of
  # them: audit refuses the decrease, and an installed 0.1.0 never shows as outdated.
  version_scheme 1

  bottle do
    root_url "https://github.com/souther-lang/homebrew-souther/releases/download/souther-0.1.0-rc5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3ae4e4be04b739d9139f4db338209d876d020239503ad7086ea38cf8d3699ba0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af749a495c7199dcf971a3802e251063fc2a4d995a963bfce18c475c26755d6d"
  end

  depends_on "openjdk"

  def install
    libexec.install "souther.jar"
    bin.write_jar_script libexec/"souther.jar", "souther", "-Xss4m", java_version: "25+"
  end

  test do
    (testpath/"hello.sou").write <<~SOU
      behavior greet : (name: String) -> String

      let greet (name) = String.append("Hello, ", name)
    SOU

    assert_equal "\"Hello, world\"",
                 shell_output("#{bin}/souther run #{testpath}/hello.sou --input '\"world\"'").strip
  end
end
