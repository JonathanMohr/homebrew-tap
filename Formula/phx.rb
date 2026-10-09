class Phx < Formula
    desc "Disk-image creation and manipulation"
    homepage "https://github.com/JonathanMohr/PHX"

    url "https://github.com/JonathanMohr/PHX/archive/refs/tags/v0.1.0-alpha.2b.tar.gz"
    sha256 "8f7b00a0e69fb1f609f5af3e39e2f00d76461e0abb8c79100899036ef161b8dc"

    license "Apache-2.0"

    depends_on "nasm" => :build
    depends_on "llvm" => :build
    depends_on "lld" => :build
    depends_on "python@3.12" => :build

    version "v0.1.0-alpha.2b"

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
        system "#{bin}/phx", "--version"
        system "#{bin}/phx-lfs", "--version"
    end

end
