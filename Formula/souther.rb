class Souther < Formula
  desc "Small JVM language for building closed, executable business models"
  homepage "https://github.com/souther-lang/souther"
  url "https://github.com/souther-lang/souther/releases/download/v0.3.0/souther.jar"
  sha256 "902bfa6d9489c730a8e1db503c7cd35ac7bd0f901a379d136e06ec9c969a7691"
  license "EPL-2.0"
  # The release candidates were given a scheme so that they would outrank the version they carried,
  # and a scheme cannot be given back: audit refuses a decrease, and an installed formula's own
  # scheme is what an upgrade is judged against.
  version_scheme 1

  bottle do
    root_url "https://github.com/souther-lang/homebrew-souther/releases/download/souther-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "24034cc851cab16d9160bae78ef45be9484aad132cf72524e857fba1e52dca46"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "38d227ddde9abd7314b8244fbe743403e06bbbb9b5dec8961800383ca03d7886"
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
