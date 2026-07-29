class RhoodMcp < Formula
  desc "MCP for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "e58b1bb423aafb6bd1b9ee500f21d52778e77dfa0470a1a3ba2817aa40a2a3be"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "ab884331f5b2ad4b89686da5aaae32cb42829a32f1113f80c0e1cd67ca1140e2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a773ceda0a33ca558cdf1d59e9a1f32b878318756e18b7ecced0665c2697cd7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e42dff1cae61091895001d43a6f1b365a51d2af05737e73ccd3b9aaaa2c83c01"
    end
  end

  def install
    bin.install "rhood-mcp"
  end

  test do
    system bin/"rhood-mcp", "--version"
  end
end
