class RhoodMcp < Formula
  desc "MCP for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "0a7b84326df5fb3489854bbf25363e41165637c378e39e12ad130df77c482727"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "4e19ac48e6e349620a0f07af7a189a9ccd9702cfe3f842634fbecb4dc50cf71b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "73073cc31edaab7498944e57f779abbea2a8994e753e8a222938899065db42b9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "824ffcd16b90d10a11fdbe3e124e36f1a0881e0454e1737330db3677fe557315"
    end
  end

  def install
    bin.install "rhood-mcp"
  end

  test do
    system bin/"rhood-mcp", "--version"
  end
end
