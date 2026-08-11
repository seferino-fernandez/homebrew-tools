class Rhood < Formula
  desc "Terminal CLI for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-x86_64-apple-darwin.tar.gz"
      sha256 "63821d0bd64c14fd84ebe62c7c8103b2b63548555916996c67893e1d4a452f96"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-aarch64-apple-darwin.tar.gz"
      sha256 "752c30f5868e00aa0ba2ca01c0240276ac73eb814bac1d6700b9adfc7ce37460"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f63261f4bbc34e2958fb44abf3429a44fcdb267aba596ff7d1823f536849918"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.2.0/rhood-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "162e6d783153fc84d81f6d9f16f11f82a448140b0f86803668869990ec0bd3c8"
    end
  end

  def install
    bin.install "rhood"
  end

  test do
    system bin/"rhood", "--version"
  end
end
