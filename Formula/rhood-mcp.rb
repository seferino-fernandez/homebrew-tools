class Rhood < Formula
  desc "MCP for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "25f7ca1a76a5a2fc86ffd6ccdaa43514779c8d118dcb61dd5882c46ee2f29e0a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "186f13335f9d2958c8527561585fd53341d806b556bff194a226f55ffc409d87"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a5b5f17c7c2d3dcf21e92e253d924ae5ca492b809b01e8b9e63cac91550718d8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c2637e4158d3bc5bcc8af96d6c4a5460a6bac934a67a21f6c35bdfad8e84bcbb"
    end
  end

  def install
    bin.install "rhood-mcp"
  end

  test do
    system bin/"rhood-mcp", "--version"
  end
end
