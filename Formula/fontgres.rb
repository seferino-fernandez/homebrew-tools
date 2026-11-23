class Fontgres < Formula
  desc "Query installed fonts from the terminal"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-x86_64-apple-darwin.tar.gz"
      sha256 "97c5e5a1e454ce545761f4404ba2d071f5d15f846e11a8a01ff6c3f52712c304"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-aarch64-apple-darwin.tar.gz"
      sha256 "79b5d51e9249769c633bb3a27ee81daaac8c9669cc3c5bc57bb44f3ccf9a2c41"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c79ba8d149256165dce746686c16ee7bc7a8b02e8349e26e43a8942ebe0bf3d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.2.0/fontgres-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "56ef3505dca4dc86caddef859f03b4dcd977da595e9f4f4da35922f428cf0114"
    end
  end

  def install
    bin.install "fontgres"
    generate_completions_from_executable(bin/"fontgres", "completions")
    system bin/"fontgres", "man", buildpath/"man"
    man1.install buildpath.glob("man/*.1")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fontgres --version")
  end
end
