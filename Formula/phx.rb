class Phx < Formula
    desc "Disk-image creation and manipulation"
    homepage "https://github.com/JonathanMohr/PHX"

    url "https://github.com/JonathanMohr/PHX/archive/refs/tags/v0.1.0-alpha.3.tar.gz"
    sha256 "be81488aefbc8f9f155d576a16b49ea00d098101da7a3287a4e8eea82661fa3d"

    license all_of: [
        "Apache-2.0",
        "MIT",
        "Unicode-DFS-2016"
    ]

    depends_on "nasm" => :build
    depends_on "llvm" => :build
    depends_on "lld" => :build
    depends_on "python@3.12" => :build

    version "v0.1.0-alpha.3"

    def install
        # set PATH
        ENV.prepend_path "PATH", Formula["llvm"].opt_bin
        ENV.prepend_path "PATH", Formula["lld"].opt_bin
        
        # build
        system "python3", "-m", "build", "-t", "none", "-v", version

        # Install dist/
        prefix.install Dir[".dist/*"]
    end

    test do
        system "#{bin}/phx", "--version"
    end

end
