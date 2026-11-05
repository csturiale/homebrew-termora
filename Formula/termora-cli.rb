class TermoraCli < Formula
  desc "Command-line companion of Termora: list and open saved hosts"
  homepage "https://termoraplus.com"
  version "0.0.4"
  license :cannot_represent

  on_macos do
    depends_on arch: :arm64
    url "https://termoraplus.com/downloads/v#{version}/termora-cli-macos-arm64"
    sha256 "21f72b9b472c6cc3e6d5193cbb87ffe6ddc4e1dbb5983d426aa1c1ccfc8a7486"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://termoraplus.com/downloads/v#{version}/termora-cli-linux-amd64"
    sha256 "c9b485d8d5a11f86e07461ba9d04eb2ab5cf4ea869d3801a7412b9b822ffb525"
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
