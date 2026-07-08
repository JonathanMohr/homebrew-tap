class Scrib < Formula
    desc "Text formatting tool"
    homepage "https://github.com/JonathanMohr/scrib"

    url "https://github.com/JonathanMohr/scrib/archive/refs/tags/v0.1.0-alpha.2.1.tar.gz"
    sha256 "d41a1ebebf71a4c47d55d474cbfca15f1642b8937fa48abb1a433f8c964db364"

    license "Apache-2.0"

    depends_on "llvm" => :build
    depends_on "lld" => :build
    depends_on "python@3.12" => :build

    version "v0.1.0-alpha.2.1"

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
