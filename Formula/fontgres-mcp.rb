class FontgresMcp < Formula
  desc "MCP server for querying installed fonts"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "c1424fc9fd92876e72f392f9847a701a5db76e2da791aeb9e13b37c5bb5a43f5"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "a8a35d9fafaedc528f68c97908170186840cb8c7e1b91d5e188a0dd42c8a5245"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "106ab09b24568e3b5ca276e2cbdb330140e0f89fc97a48058efa2649764ba917"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "debcd70459db2cbd619c32efe9cc91b06bcf0a7d87ae69a482f4dfe0043fbb72"
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
