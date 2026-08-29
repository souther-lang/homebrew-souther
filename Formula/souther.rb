class Souther < Formula
  desc "Small JVM language for building closed, executable business models"
  homepage "https://github.com/souther-lang/souther"
  url "https://github.com/souther-lang/souther/releases/download/v0.1.0/souther.jar"
  sha256 "bb95ae6f747ce9c6a3b66b054a865b075b681e0e698a817c801b1cbf59df085d"
  license "EPL-2.0"
  # The release candidates were given a scheme so that they would outrank the version they carried,
  # and a scheme cannot be given back: audit refuses a decrease, and an installed formula's own
  # scheme is what an upgrade is judged against.
  version_scheme 1

  bottle do
    root_url "https://github.com/souther-lang/homebrew-souther/releases/download/souther-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "88bbddce60f08c2258498bc83aa62b815c0b759e3cd52e427c7862da193bf0f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9a44b3fee050951069fe9c71a638d88fdc5893444ba2e51205be3bc011f3becc"
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
