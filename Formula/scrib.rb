class Scrib < Formula
    desc "Text formatting tool"
    homepage "https://github.com/JonathanMohr/scrib"

    url "https://github.com/JonathanMohr/scrib/archive/refs/tags/v0.1.0-alpha.tar.gz"
    sha256 "3a2b381d2d3a3a33c413161ee9c0d4b8fcb962536ee24313d25ac240d794855f"

    license "Apache-2.0"

    depends_on "llvm" => :build
    depends_on "lld" => :build
    depends_on "python@3.12" => :build

    version "v0.1.0-alpha"

    def install
        # set PATH
        ENV.prepend_path "PATH", Formula["llvm"].opt_bin
        ENV.prepend_path "PATH", Formula["lld"].opt_bin
        
        # build
        system "python3", "-m", "ci", "-v", version

        # Install dist/
        prefix.install Dir["dist/*"]
    end

    test do
        system "#{bin}/scrib", "--version"
    end

end
