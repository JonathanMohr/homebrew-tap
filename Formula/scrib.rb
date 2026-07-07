class Scrib < Formula
    desc "Text formatting tool"
    homepage "https://github.com/JonathanMohr/scrib"

    url "https://github.com/JonathanMohr/scrib/archive/refs/tags/v0.1.0-alpha.2.tar.gz"
    sha256 "37e9c8ae899264b2dd0eb444190b438242e07c7134971e31651d3f631f968a81"

    license "Apache-2.0"

    depends_on "llvm" => :build
    depends_on "lld" => :build
    depends_on "python@3.12" => :build

    version "v0.1.0-alpha.2"

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
