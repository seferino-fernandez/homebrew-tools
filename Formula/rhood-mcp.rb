class RhoodMcp < Formula
  desc "MCP for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "690cdf3f13950d7b9625d3f187beb9faa359dadfb664ce9c11c8da24423feadb"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "54b06ea4880a799e1ef3ab80d0b1a10e6116bd5ae807f5210ad0e9caaffdcfa5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "56f461f5bb11f11a228bd2798e6d3de507ac26073f73097ca343916b4e15409c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2b42e1184a4c046684d0a4465ca13f70b35601916929507efa07c0165e4b454d"
    end
  end

  def install
    bin.install "rhood-mcp"
  end

  test do
    system bin/"rhood-mcp", "--version"
  end
end
