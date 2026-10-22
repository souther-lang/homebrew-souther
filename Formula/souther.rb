class Souther < Formula
  desc "Small JVM language for building closed, executable business models"
  homepage "https://github.com/souther-lang/souther"
  url "https://github.com/souther-lang/souther/releases/download/v0.4.1/souther.jar"
  sha256 "64017791bed45376587e7386b5219d594d1522899046d91cd24e343063e22f24"
  license "EPL-2.0"
  # The release candidates were given a scheme so that they would outrank the version they carried,
  # and a scheme cannot be given back: audit refuses a decrease, and an installed formula's own
  # scheme is what an upgrade is judged against.
  version_scheme 1

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
