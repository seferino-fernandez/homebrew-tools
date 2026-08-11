class RhoodMcp < Formula
  desc "MCP for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "09ce86a9099d0f22e2b5e3534cb038e176ab0cca9b24b0219eae898b6c8bc325"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "67adb42031f3589c68a6286bdf64f7c594a89322f2dae2570d37b6aebf4a5fdf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5cb9ffc6dfbb7282baa0abd8b731423926f74511a8712efd700e2fed54b0d4e7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b219223488347624e9bc14b3030d6208d55400cb6be52ad5ae89b374f91488be"
    end
  end

  def install
    bin.install "rhood-mcp"
  end

  test do
    system bin/"rhood-mcp", "--version"
  end
end
