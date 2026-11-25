class Souther < Formula
  desc "Small JVM language for building closed, executable business models"
  homepage "https://github.com/souther-lang/souther"
  url "https://github.com/souther-lang/souther/releases/download/v0.5.0/souther.jar"
  sha256 "504945376706aea5c03343a4dd32e0a40f266324b6814680117701b507e50385"
  license "EPL-2.0"
  # The release candidates were given a scheme so that they would outrank the version they carried,
  # and a scheme cannot be given back: audit refuses a decrease, and an installed formula's own
  # scheme is what an upgrade is judged against.
  version_scheme 1

  bottle do
    root_url "https://github.com/souther-lang/homebrew-souther/releases/download/souther-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "fe97227f3c3e15ad235a046080f573352ee40e10998d400c754a3023d3483ef4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2c8f74a901ac455790c0e0757d5cc3f939d50287158116037c69f0067265341f"
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
