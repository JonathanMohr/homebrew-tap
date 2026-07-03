class Scrib < Formula
    desc "Text formatting tool"
    homepage "https://github.com/JonathanMohr/scrib"

    url "https://github.com/JonathanMohr/scrib/archive/refs/tags/v0.1.0-alpha.tar.gz"
    sha256 "8d1b24a928f519b73423b7a3e99423589e33b96c0aa6106486c83ee7a3f10ebd"

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
