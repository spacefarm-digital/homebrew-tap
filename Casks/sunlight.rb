# The Homebrew cask, for the tap in packaging/release.conf (brew install spacefarm-digital/tap/sunlight).
# scripts/release.sh fills in the version and checksum and writes the result to build/release/sunlight.rb.
cask "sunlight" do
  version "0.2.3"
  sha256 "327e4617b1ab8f6a4185342ad3c06fd4a425f79319704ef6b042139b2174841c"

  url "https://github.com/spacefarm-digital/sunlight-releases/releases/download/v#{version}/Sunlight-#{version}.dmg"
  name "Sunlight"
  desc "Window manager that puts every window on an infinite, zoomable canvas"
  homepage "https://sunlight.software"

  livecheck do
    url "https://github.com/spacefarm-digital/sunlight-releases/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates it in place.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Sunlight.app"

  # The Dock add-on and the reload rule older builds wrote; the background helper goes with the app.
  uninstall quit:      "com.spacefarm.sunlight",
            launchctl: "com.spacefarm.sunlight.live-windows",
            delete:    [
              "/Library/ScriptingAdditions/Sunlight.osax",
              "/private/etc/sudoers.d/sunlight-live-windows",
            ]

  zap trash: [
    "~/Library/Application Support/Sunlight",
    "~/Library/Caches/com.spacefarm.sunlight",
    "~/Library/HTTPStorages/com.spacefarm.sunlight",
    "~/Library/Preferences/com.spacefarm.sunlight.plist",
  ]

  caveats <<~EOS
    Live windows need System Integrity Protection partly off. Open Sunlight and choose
    Sunlight › Set Up Sunlight… for the steps.
  EOS
end
