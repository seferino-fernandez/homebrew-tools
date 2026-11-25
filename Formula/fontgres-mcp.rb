class FontgresMcp < Formula
  desc "MCP server for querying installed fonts"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "9a07b991c76de33fe146ffb6ffe4b5d1840eda14ac0174a120e11d342efc1d74"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "0ad862b01139311871866a3d8422016fac6c5b9e171f36762312f3a115e5be23"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d85efa7d92c7ccb5e901701410f14cf9ef9179c3d7feef8809629bbe40ef5377"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9524cfc72bd546b6fcef7ed0f7263f630bf26a455e5ef0aa6ab19c9fa312e600"
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
