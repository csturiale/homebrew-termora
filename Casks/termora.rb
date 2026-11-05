cask "termora" do
  version "0.0.5"
  sha256 "5034883208b86fee80a57591ac99dc95dcb0abe83a590923f97e6cc1ad8ccc1d"

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
