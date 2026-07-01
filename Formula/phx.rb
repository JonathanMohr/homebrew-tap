class Phx < Formula
    desc "Disk-image creation and manipulation"
    homepage "https://github.com/JonathanMohr/PHX"

    url "https://github.com/JonathanMohr/PHX/archive/refs/tags/v0.1.0-alpha.tar.gz"
    sha256 "77d82469137015e3c9022510647a5046249e012eaa6ac87e92151546ba83ba69"

    license "Apache-2.0"

    depends_on "llvm" => :build
    depends_on "lld" => :build
    depends_on "python@3.12" => :build

    def install
        # set PATH
        ENV.prepend_path "PATH", Formula["llvm"].opt_bin
        ENV.prepend_path "PATH", Formula["lld"].opt_bin
        
        # build
        system "python3", "-m", "ci", "-v", version

        # Install dist/
        prefix.install Dir["dist/*"]

        # Set binary symlinks
        Dir[prefix/"bin/*"].select { |f| File.executable?(f) }.each do |file|
            bin.install_symlink file
        end
    end

    test do
        system "#{bin}/phx", "--version"
    end

end
