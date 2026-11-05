class TermoraCli < Formula
  desc "Command-line companion of Termora: list and open saved hosts"
  homepage "https://termoraplus.com"
  version "0.0.5"
  license :cannot_represent

  on_macos do
    depends_on arch: :arm64
    url "https://termoraplus.com/downloads/v#{version}/termora-cli-macos-arm64"
    sha256 "8a2424bdd70700cd28209ae61965de57be1144d4fee4ad1f64cbdeb6e3523ca5"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://termoraplus.com/downloads/v#{version}/termora-cli-linux-amd64"
    sha256 "7ebb6ac62c41e3fa02cdde0feb4722e68e5c7d12df4355527295a94915cda647"
  end

  livecheck do
    url "https://termoraplus.com/downloads/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  def install
    binary = Dir["termora-cli-*"].first
    chmod 0755, binary
    bin.install binary => "termora-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termora-cli version")
  end
end
