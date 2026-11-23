class FontgresMcp < Formula
  desc "MCP server for querying installed fonts"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "f0a59218d15b153fa5ec47b0f070bdf88b1c12bd0619d632dcffceda88042f87"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "eca2de16e39932275e71a3b79d05944220dafe5e4f84dcba0a88dcc784393beb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f098b3a6a06a324851a46e2efae943f534844942faa0097bd098ec5fa19c413f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff60608c994065668fb014e9356fcf1f55a83c04d5c7f1c8a5cf6d0ed5834070"
    end
  end

  def install
    bin.install "fontgres-mcp"
    generate_completions_from_executable(bin/"fontgres-mcp", "completions")
    system bin/"fontgres-mcp", "man", buildpath/"man"
    man1.install buildpath.glob("man/*.1")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fontgres-mcp --version")
  end
end
