# The Homebrew cask, for the tap in packaging/release.conf (brew install spacefarm-digital/tap/sunlight).
# scripts/release.sh fills in the version and checksum and writes the result to build/release/sunlight.rb.
cask "sunlight" do
  version "0.2"
  sha256 "696f7bb7e43f9dfcb6668339c9c8e718633f571ac01ebce34c4fe91172447e91"

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
