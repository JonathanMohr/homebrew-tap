class Phx < Formula
    desc "Disk-image creation and manipulation"
    homepage "https://github.com/JonathanMohr/PHX"

    url "https://github.com/JonathanMohr/PHX/archive/refs/tags/v0.1.0-alpha.3.2-actually.tar.gz"
    sha256 "429edfbe9820b50e74510d76c932329e1350522b93da02983cc3f5ac7459b193"

    license all_of: [
        "Apache-2.0",
        "MIT",
        "Unicode-DFS-2016"
    ]

    depends_on "nasm" => :build
    depends_on "llvm" => :build
    depends_on "lld" => :build
    depends_on "python@3.12" => :build

    version "v0.1.0-alpha.3.2-actually"

    def install
        # set PATH
        ENV.prepend_path "PATH", Formula["llvm"].opt_bin
        ENV.prepend_path "PATH", Formula["lld"].opt_bin
        
        # build
        system "python3", "-m", "build", "-t", "none", "--no-root", "-v", version

        # Install dist/
        prefix.install Dir["dist/*"]
    end

    test do
        system "#{bin}/phx", "--version"
    end

end
