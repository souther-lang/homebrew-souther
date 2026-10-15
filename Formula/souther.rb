class Souther < Formula
  desc "Small JVM language for building closed, executable business models"
  homepage "https://github.com/souther-lang/souther"
  url "https://github.com/souther-lang/souther/releases/download/v0.4.0/souther.jar"
  sha256 "a29a610ea0778052ea5203cfb24357c3c725d438510f1e0a59bf0087e0911581"
  license "EPL-2.0"
  # The release candidates were given a scheme so that they would outrank the version they carried,
  # and a scheme cannot be given back: audit refuses a decrease, and an installed formula's own
  # scheme is what an upgrade is judged against.
  version_scheme 1

  bottle do
    root_url "https://github.com/souther-lang/homebrew-souther/releases/download/souther-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "21223e1723e536778258c6042967ec9f50b73b3fc42cfabcdc1b10a1b5d26c20"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6d7406f277a1f6c319c0ee642fe46f5838a49e4b5fd63b1598b83d7936ad7163"
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
