class FontgresMcp < Formula
  desc "MCP server for querying installed fonts"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "ad18af47a5599298b1484a63ad8d8bf9f10ae834e6b405f32f66d436bb2b8039"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "ac717cae0ffa79753f7bc0e5fd69501e88f9045d4f600081b02a74819cdadba5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4dd4ddf56ccbdc01a464d69059be4f899954aed0824cd424d1f6250b55141625"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3ce6f2052a96758ab472fc3fea7f6eb939d6fe62b78ecc0ca7b62b3ebae25573"
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
