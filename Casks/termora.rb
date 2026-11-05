cask "termora" do
  version "0.0.4"
  sha256 "b16e2fdbdd9cd540d39eea50104382670b772654284af2720b489beb1a42fe96"

  url "https://termoraplus.com/downloads/v#{version}/termora-#{version}-macos-arm64.dmg"
  name "Termora"
  desc "SSH client, terminal and connection manager"
  homepage "https://termoraplus.com"

  livecheck do
    url "https://termoraplus.com/downloads/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # Termora updates itself (Settings > Updates).
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Termora.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Termora.app"]
  end

  # The data folder (~/Library/Application Support/Termora, with the vault)
  # is left alone: delete it by hand to remove the saved hosts and secrets.
  zap trash: [
    "~/Library/Caches/io.github.csturiale.termora",
    "~/Library/Preferences/io.github.csturiale.termora.plist",
    "~/Library/Saved Application State/io.github.csturiale.termora.savedState",
    "~/Library/WebKit/io.github.csturiale.termora",
  ]
end
