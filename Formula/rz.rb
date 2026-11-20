# rz for Homebrew, from the tap rinkans/homebrew-rz:
#
#   brew install rinkans/rz/rz
#   brew services start rz
#
# rz's release workflow writes this file (version, URL, checksum) for each
# stable release; don't edit it in the tap by hand.
#
# A formula, not a cask: Homebrew marks a cask's download as from the
# internet, and macOS then refuses rz (it isn't notarized). Homebrew
# updates rz (brew upgrade), so rz's own updater stays off for this copy.
class Rz < Formula
  desc "Keyboard-first window placement: grids, workspaces and hints"
  homepage "https://github.com/rinkans/rz-releases"
  url "https://github.com/rinkans/rz-releases/releases/download/v0.1.1/rz-macos-universal.tar.gz"
  version "0.1.1"
  sha256 "100b1c837b71929e8bacfa14387cbef6e3f2f2e13a2e6272283c8f24b58c2877"

  depends_on :macos

  def install
    # The archive holds rz.app; Homebrew steps into a lone top folder.
    if File.directory?("Contents")
      (prefix/"rz.app").install Dir["*"]
    else
      prefix.install "rz.app"
    end
    bin.install_symlink prefix/"rz.app/Contents/MacOS/rz"
    tui = prefix/"rz.app/Contents/MacOS/rz-tui"
    bin.install_symlink tui if tui.exist?
  end

  service do
    run [opt_prefix/"rz.app/Contents/MacOS/rzd"]
    # Started again after a crash, not after `rz stop`.
    keep_alive successful_exit: false
    process_type :interactive
    log_path var/"log/rz.log"
    error_log_path var/"log/rz.log"
  end

  def caveats
    <<~EOS
      Start rz now and whenever you log in:
        brew services start rz

      Then allow it to place windows: System Settings > Privacy & Security >
      Accessibility > switch on rz. macOS asks the first time rz starts.

      § (left of 1) becomes rz's key: hold it alone to see every shortcut,
      tap it to type §. On a keyboard without §, put hyper = "capslock"
      under [general] in ~/.config/rz/config.toml. The menu bar shows rz
      while it runs.
    EOS
  end

  test do
    assert_match "rz #{version}", shell_output("#{bin}/rz version")
  end
end
