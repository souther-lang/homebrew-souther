class Souther < Formula
  desc "Small JVM language for building closed, executable business models"
  homepage "https://github.com/souther-lang/souther"
  url "https://github.com/souther-lang/souther/releases/download/v0.2.0/souther.jar"
  sha256 "7c277419a1f8f456a48cffc4d8e77cd8d306380a8b5094aa97227e250b593a79"
  license "EPL-2.0"
  # The release candidates were given a scheme so that they would outrank the version they carried,
  # and a scheme cannot be given back: audit refuses a decrease, and an installed formula's own
  # scheme is what an upgrade is judged against.
  version_scheme 1

  bottle do
    root_url "https://github.com/souther-lang/homebrew-souther/releases/download/souther-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a63d23b56677e581ad8d92e455917ecabde596ccc7bf481d41baa22a9a42f1f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d47f4e84458be95d280833ece2d6509ec72c7f53c59e89b1ca584413ce7fc8f1"
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
